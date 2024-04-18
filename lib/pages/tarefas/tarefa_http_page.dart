import 'package:flutter/material.dart';
import 'package:trilhaapp/model/Tarefas_back4app_model.dart';
import 'package:trilhaapp/repositories/back4app/tarefas_back4app_repository.dart';

class TarefaHttpPage extends StatefulWidget {
  const TarefaHttpPage({super.key});

  @override
  State<TarefaHttpPage> createState() => _TarefaHttpPageState();
}

class _TarefaHttpPageState extends State<TarefaHttpPage> {
  final tarefasBack4appRepository = TarefasBack4appRepository();
  var _tarefasBack4app = TarefasBack4AppModel(tarefas: []);
  var apenasNaoConcluidos = false;
  var loading = false;
  TextEditingController descricaoController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    setState(() {
      loading = true;
    });
    _tarefasBack4app =
        await tarefasBack4appRepository.obterTarefas(apenasNaoConcluidos);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas"),
      ),
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
                            await tarefasBack4appRepository.criarTarefa(
                                TarefaBack4AppModel.criar(
                                    descricao: descricaoController.text,
                                    concluido: false));
                            obterTarefas();
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
            loading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _tarefasBack4app.tarefas.length,
                      itemBuilder: (context, index) {
                        var tarefa = _tarefasBack4app.tarefas[index];
                        return Dismissible(
                          onDismissed: (direction) async {
                            await tarefasBack4appRepository
                                .removerTarefa(tarefa.objectId);
                            obterTarefas();
                          },
                          key: Key(tarefa.descricao),
                          child: ListTile(
                            title: Text(tarefa.descricao),
                            trailing: Switch(
                              onChanged: (value) async {
                                tarefa.concluido = value;
                                await tarefasBack4appRepository
                                    .atualizarTarefa(tarefa);
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
