import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class ConfiguracoesSharedPreferencesPage extends StatefulWidget {
  const ConfiguracoesSharedPreferencesPage({super.key});

  @override
  State<ConfiguracoesSharedPreferencesPage> createState() =>
      _ConfiguracoesSharedPreferencesPageState();
}

class _ConfiguracoesSharedPreferencesPageState
    extends State<ConfiguracoesSharedPreferencesPage> {
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String? nomeUsuario;
  double? altura;
  bool receberNotificacoes = false;
  bool temaEscuro = false;

  AppStorageService appStorageService = AppStorageService();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    nomeUsuarioController.text = await appStorageService.getConfigNomeUsuario();
    alturaController.text =
        (await appStorageService.getConfigAltura()).toString();
    receberNotificacoes =
        await appStorageService.getConfigReceberNotificacoes();
    temaEscuro = await appStorageService.getConfigTemaEscuro();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: const InputDecoration(hintText: "Nome Usuário"),
                controller: nomeUsuarioController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Altura"),
                controller: alturaController,
              ),
            ),
            SwitchListTile(
              title: const Text("Receber notificações"),
              value: receberNotificacoes,
              onChanged: (value) {
                setState(() {
                  receberNotificacoes = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text("Tema escuro"),
              value: temaEscuro,
              onChanged: (value) {
                setState(() {
                  temaEscuro = value;
                });
              },
            ),
            TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await Future.delayed(const Duration(milliseconds: 500));
                  try {
                    await appStorageService
                        .setConfigAltura(double.parse(alturaController.text));
                  } catch (e) {
                    Future.delayed(
                      const Duration(milliseconds: 500),
                      () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Meu App"),
                            content:
                                const Text("Favor informar uma altura válida!"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ok"))
                            ],
                          ),
                        );
                      },
                    );

                    return;
                  }
                  await appStorageService
                      .setConfigNomeUsuario(nomeUsuarioController.text);
                  await appStorageService
                      .setConfigReceberNotificacoes(receberNotificacoes);
                  await appStorageService.setConfigTemaEscuro(temaEscuro);
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () {
                      Navigator.pop(context);
                    },
                  );
                },
                child: const Text("Salvar"))
          ],
        ),
      ),
    ));
  }
}
