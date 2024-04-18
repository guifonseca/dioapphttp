import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class NumerosAleatoriosSharedPreferencesPage extends StatefulWidget {
  const NumerosAleatoriosSharedPreferencesPage({super.key});

  @override
  State<NumerosAleatoriosSharedPreferencesPage> createState() =>
      _NumerosAleatoriosSharedPreferencesPageState();
}

class _NumerosAleatoriosSharedPreferencesPageState
    extends State<NumerosAleatoriosSharedPreferencesPage> {
  AppStorageService appStorageService = AppStorageService();

  int numeroGerado = 0;
  int quantidadeCliques = 0;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    numeroGerado = await appStorageService.getNumeroAleatorio();
    quantidadeCliques = await appStorageService.getQuantidadeCliques();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Gerador de números aleatórios"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              numeroGerado.toString(),
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              quantidadeCliques == 0
                  ? "Nenhum clique efetuado"
                  : quantidadeCliques.toString(),
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(1000);
              quantidadeCliques = quantidadeCliques + 1;
            });
            await appStorageService.setNumeroAleatorio(numeroGerado);
            await appStorageService.setQuantidadeCliques(quantidadeCliques);
          },
          child: const Icon(Icons.add)),
    ));
  }
}
