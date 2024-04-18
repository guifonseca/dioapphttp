class ConfiguracoesModel {
  String _nomeUsuario = "";
  double _altura = 0.0;
  bool _receberNotificacoes = false;
  bool _temaEscuro = false;

  ConfiguracoesModel.empty() {
    _nomeUsuario = "";
    _altura = 0.0;
    _receberNotificacoes = false;
    _temaEscuro = false;
  }

  ConfiguracoesModel(this._nomeUsuario, this._altura, this._receberNotificacoes,
      this._temaEscuro);

  String get nomeUsuario => _nomeUsuario;
  set nomeUsuario(String value) => _nomeUsuario = value;

  double get altura => _altura;
  set altura(double value) => _altura = value;

  bool get receberNotificacoes => _receberNotificacoes;
  set receberNotificacoes(bool value) => _receberNotificacoes = value;

  bool get temaEscuro => _temaEscuro;
  set temaEscuro(bool value) => _temaEscuro = value;
}
