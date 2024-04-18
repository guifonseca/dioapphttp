import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa.dart';
import 'package:trilhaapp/repositories/tarefa_repository.dart';

class TarefaSharedPreferencesPage extends StatefulWidget {
  const TarefaSharedPreferencesPage({super.key});

  @override
  State<TarefaSharedPreferencesPage> createState() =>
      _TarefaSharedPreferencesPageState();
}

class _TarefaSharedPreferencesPageState
    extends State<TarefaSharedPreferencesPage> {
  var tarefaRepository = TarefaRepository();
  var _tarefas = const <Tarefa>[];
  var apenasNaoConcluidos = false;
  TextEditingController descricaoController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    if (apenasNaoConcluidos) {
      _tarefas = await tarefaRepository.listarNaoConcluidas();
    } else {
      _tarefas = await tarefaRepository.listarTarefas();
    }

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
                            await tarefaRepository.adicionar(
                                Tarefa(descricaoController.text, false));
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
                      await tarefaRepository.remove(tarefa.id);
                      obterTarefas();
                    },
                    key: Key(tarefa.id),
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        onChanged: (value) async {
                          await tarefaRepository.alterar(tarefa.id, value);
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
