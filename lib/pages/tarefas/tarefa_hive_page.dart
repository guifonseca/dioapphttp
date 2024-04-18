import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';
import 'package:trilhaapp/repositories/tarefa_hive_repository.dart';

class TarefaHivePage extends StatefulWidget {
  const TarefaHivePage({super.key});

  @override
  State<TarefaHivePage> createState() => _TarefaHivePageState();
}

class _TarefaHivePageState extends State<TarefaHivePage> {
  late TarefaHiveRepository tarefaHiveRepository;
  var _tarefas = const <TarefaHiveModel>[];
  var apenasNaoConcluidos = false;
  TextEditingController descricaoController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    tarefaHiveRepository = await TarefaHiveRepository.carregar();
    _tarefas = tarefaHiveRepository.obterDados(apenasNaoConcluidos);
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
                            tarefaHiveRepository.salvar(TarefaHiveModel.criar(
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
                      tarefaHiveRepository.excluir(tarefa);
                      obterTarefas();
                    },
                    key: Key(tarefa.descricao),
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        onChanged: (value) async {
                          tarefa.concluido = value;
                          tarefaHiveRepository.alterar(tarefa);
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
