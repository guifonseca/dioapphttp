import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_sqflite_model.dart';
import 'package:trilhaapp/repositories/sqflite/tarefa_sqflite_repository.dart';

class TarefaSqflitePage extends StatefulWidget {
  const TarefaSqflitePage({super.key});

  @override
  State<TarefaSqflitePage> createState() => _TarefaSqflitePageState();
}

class _TarefaSqflitePageState extends State<TarefaSqflitePage> {
  final tarefaSqfliteRepository = TarefaSqfliteRepository();
  var _tarefas = const <TarefaSqfliteModel>[];
  var apenasNaoConcluidos = false;
  TextEditingController descricaoController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    _tarefas = await tarefaSqfliteRepository.obterDados(apenasNaoConcluidos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          descricaoController.text = "";
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Adicionar Tarefa"),
                    content: TextField(
                      controller: descricaoController,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar")),
                      TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            tarefaSqfliteRepository.insert(
                                TarefaSqfliteModel.insert(
                                    descricaoController.text, false));
                            obterTarefas();
                            setState(() {});
                          },
                          child: const Text("Salvar"))
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Apenas não concluídas",
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: apenasNaoConcluidos,
                    onChanged: (value) {
                      apenasNaoConcluidos = value;
                      obterTarefas();
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    onDismissed: (direction) async {
                      await tarefaSqfliteRepository.delete(tarefa);
                      obterTarefas();
                    },
                    key: Key(tarefa.descricao),
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        onChanged: (value) async {
                          tarefa.concluido = value;
                          await tarefaSqfliteRepository.update(tarefa);
                          obterTarefas();
                        },
                        value: tarefa.concluido,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
