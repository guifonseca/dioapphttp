import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/app_images.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset(AppImages.user2),
          title: const Text("Usuário 2"),
          subtitle: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Olá, tudo bem?"), Text("08:58")],
          ),
          trailing: PopupMenuButton<String>(
              onSelected: (menu) {
                print(menu);
              },
              itemBuilder: (context) => const <PopupMenuEntry<String>>[
                    PopupMenuItem(value: "opcao1", child: Text("Opção 1")),
                    PopupMenuItem(value: "opcao2", child: Text("Opção 2")),
                    PopupMenuItem(value: "opcao3", child: Text("Opção 3"))
                  ]),
        ),
        Image.asset(
          AppImages.user1,
        ),
        Image.asset(
          AppImages.user2,
        ),
        Image.asset(
          AppImages.user3,
        ),
        Image.asset(
          AppImages.paisagem1,
        ),
        Image.asset(
          AppImages.paisagem2,
        ),
        Image.asset(
          AppImages.paisagem3,
        ),
      ],
    );
  }
}
