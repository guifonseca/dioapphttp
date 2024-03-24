import 'package:trilhaapp/model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  Future<void> adicionar(Tarefa tarefa) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas.add(tarefa);
  }

  Future<void> alterar(String id, bool concluido) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _tarefas.where((element) => element.id == id).first.concluido;
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _tarefas.remove(_tarefas.where((element) => element.id == id).first);
  }

  Future<List<Tarefa>> listarTarefas() async {
    await Future.delayed(const Duration(seconds: 1));
    return _tarefas;
  }

  Future<List<Tarefa>> listarNaoConcluidas() async {
    await Future.delayed(const Duration(seconds: 1));
    return _tarefas.where((tarefa) => !tarefa.concluido).toList();
  }
}
