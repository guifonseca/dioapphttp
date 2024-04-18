import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  late Box boxNumerosAleatorios;

  int numeroGerado = 0;
  int quantidadeCliques = 0;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');
    } else {
      boxNumerosAleatorios = await Hive.openBox('box_numeros_aleatorios');
    }

    numeroGerado = boxNumerosAleatorios.get('numeroGerado') ?? 0;
    quantidadeCliques = boxNumerosAleatorios.get('quantidadeCliques') ?? 0;
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
            await boxNumerosAleatorios.put('numeroGerado', numeroGerado);
            await boxNumerosAleatorios.put(
                'quantidadeCliques', quantidadeCliques);
          },
          child: const Icon(Icons.add)),
    ));
  }
}
