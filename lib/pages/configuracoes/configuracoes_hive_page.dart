import 'package:flutter/material.dart';
import 'package:trilhaapp/model/configuracoes_model.dart';
import 'package:trilhaapp/repositories/configuracoes_repository.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({super.key});

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  late ConfiguracoesRepository configuracoesRepository;
  ConfiguracoesModel configuracoesModel = ConfiguracoesModel.empty();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();
    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
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
              value: configuracoesModel.receberNotificacoes,
              onChanged: (value) {
                setState(() {
                  configuracoesModel.receberNotificacoes = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text("Tema escuro"),
              value: configuracoesModel.temaEscuro,
              onChanged: (value) {
                setState(() {
                  configuracoesModel.temaEscuro = value;
                });
              },
            ),
            TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await Future.delayed(const Duration(milliseconds: 500));
                  try {
                    configuracoesModel.altura =
                        double.parse(alturaController.text);
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
                  configuracoesModel.nomeUsuario = nomeUsuarioController.text;
                  configuracoesRepository.salvar(configuracoesModel);
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
