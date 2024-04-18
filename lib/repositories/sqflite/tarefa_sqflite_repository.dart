import 'package:trilhaapp/model/tarefa_sqflite_model.dart';
import 'package:trilhaapp/repositories/sqflite/sqflite_database.dart';

class TarefaSqfliteRepository {
  Future<List<TarefaSqfliteModel>> obterDados(bool apenasNaoConcluidos) async {
    List<TarefaSqfliteModel> tarefas = [];
    var db = await SqfliteDataBase().obterDataBase();
    var result = await db.rawQuery(apenasNaoConcluidos
        ? 'SELECT id, descricao, concluido FROM tarefas WHERE concluido = 0'
        : 'SELECT id, descricao, concluido FROM tarefas');
    for (var element in result) {
      tarefas.add(TarefaSqfliteModel(int.parse(element["id"].toString()),
          element["descricao"].toString(), element["concluido"] == 1));
    }
    return tarefas;
  }

  Future<void> insert(TarefaSqfliteModel tarefaSqfliteModel) async {
    var db = await SqfliteDataBase().obterDataBase();
    db.rawInsert('INSERT INTO tarefas (descricao, concluido) VALUES (?,?)',
        [tarefaSqfliteModel.descricao, tarefaSqfliteModel.concluido]);
  }

  Future<void> update(TarefaSqfliteModel tarefaSqfliteModel) async {
    var db = await SqfliteDataBase().obterDataBase();
    db.rawInsert(
        'UPDATE tarefas SET descricao = ?, concluido = ? WHERE id = ?', [
      tarefaSqfliteModel.descricao,
      tarefaSqfliteModel.concluido,
      tarefaSqfliteModel.id
    ]);
  }

  Future<void> delete(TarefaSqfliteModel tarefaSqfliteModel) async {
    var db = await SqfliteDataBase().obterDataBase();
    db.rawInsert('DELETE tarefas WHERE id = ?', [tarefaSqfliteModel.id]);
  }
}
