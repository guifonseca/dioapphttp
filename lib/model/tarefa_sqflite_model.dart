class TarefaSqfliteModel {
  int _id = 0;
  String _descricao = "";
  bool _concluido = false;

  TarefaSqfliteModel.insert(this._descricao, this._concluido);

  TarefaSqfliteModel(this._id, this._descricao, this._concluido);

  int get id => _id;
  set id(int value) => _id = value;

  String get descricao => _descricao;
  set descricao(String value) => _descricao = value;

  bool get concluido => _concluido;
  set concluido(bool value) => _concluido = value;
}
