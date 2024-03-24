import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/configuracoes_page.dart';
import 'package:trilhaapp/pages/dados_cadastrais.dart';
import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/numeros_aleatorios_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.orange),
              currentAccountPicture: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Wrap(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Camera"),
                          leading: const Icon(Icons.camera),
                        ),
                        ListTile(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            title: const Text("Galeria"),
                            leading: const Icon(Icons.folder))
                      ],
                    ),
                  );
                },
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.network(
                        "https://hermes.digitalinnovation.one/assets/diome/logo.png")),
              ),
              accountName: const Text("Guilherme Santos"),
              accountEmail: const Text("email@email.com")),
          InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DadosCadastraisPage(),
                    ));
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: double.infinity,
                  child: const Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Dados cadastrais"),
                    ],
                  ))),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: const Column(
                      children: [
                        Text(
                          "Termos de uso e privacidade",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "As experiências acumuladas demonstram que a percepção das dificuldades nos obriga à análise das condições financeiras e administrativas exigidas. Percebemos, cada vez mais, que a execução dos pontos do programa obstaculiza a apreciação da importância de todos os recursos funcionais envolvidos. O cuidado em identificar pontos críticos na contínua expansão de nossa atividade exige a precisão e a definição do processo de comunicação como um todo.",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: double.infinity,
                  child: const Row(
                    children: [
                      Icon(Icons.info),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Termos de uso e privacidade"),
                    ],
                  ))),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NumerosAleatoriosPage()));
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: double.infinity,
                  child: const Row(
                    children: [
                      Icon(Icons.numbers),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Gerador de Números"),
                    ],
                  ))),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfiguracoesPage()));
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: double.infinity,
                  child: const Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Configurações"),
                    ],
                  ))),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    alignment: Alignment.centerLeft,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: const Text(
                      "Meu App",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    content: const Wrap(
                      children: [
                        Text("Você sairá do aplicativo!"),
                        Text("Deseja realmente sair do aplicativo?")
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Não")),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text("Sim"))
                    ],
                  ),
                );
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: double.infinity,
                  child: const Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Sair"),
                    ],
                  ))),
        ],
      ),
    );
  }
}
