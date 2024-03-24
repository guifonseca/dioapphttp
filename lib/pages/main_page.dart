import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/card_page.dart';
import 'package:trilhaapp/pages/image_assets.dart';
import 'package:trilhaapp/pages/list_view_h_page.dart';
import 'package:trilhaapp/pages/list_view_page.dart';
import 'package:trilhaapp/pages/tarefa_page.dart';
import 'package:trilhaapp/shared/widgets/custom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Meu App"),
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                children: const [
                  CardPage(),
                  ImageAssetsPage(),
                  ListViewPage(),
                  ListViewHPage(),
                  TarefaPage()
                ],
              ),
            ),
            BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  pageController.jumpToPage(value);
                },
                currentIndex: posicaoPagina,
                items: const [
                  BottomNavigationBarItem(
                      label: "Pagina 1", icon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      label: "Pagina 2", icon: Icon(Icons.add)),
                  BottomNavigationBarItem(
                      label: "Pagina 3", icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      label: "Pagina 4", icon: Icon(Icons.image)),
                  BottomNavigationBarItem(
                      label: "Pagina 5", icon: Icon(Icons.list))
                ])
          ],
        ),
      ),
    );
  }
}
