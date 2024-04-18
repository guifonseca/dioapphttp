import 'package:trilhaapp/model/Tarefas_back4app_model.dart';
import 'package:trilhaapp/repositories/back4app/back4app_custom_dio.dart';

class TarefasBack4appRepository {
  final _customDio = Back4appCustomDio();

  Future<TarefasBack4AppModel> obterTarefas(bool naoConcluidas) async {
    String queryParams = "";
    if (naoConcluidas) {
      queryParams = "?where={\"concluido\":false}";
    }
    final result = await _customDio.dio.get("/Tarefas$queryParams");
    return TarefasBack4AppModel.fromJson(result.data);
  }

  Future<void> criarTarefa(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _customDio.dio
          .post("/Tarefas", data: tarefaBack4AppModel.toCreateJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizarTarefa(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _customDio.dio.put("/Tarefas/${tarefaBack4AppModel.objectId}",
          data: tarefaBack4AppModel.toCreateJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removerTarefa(String objectId) async {
    try {
      await _customDio.dio.delete("/Tarefas/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}
