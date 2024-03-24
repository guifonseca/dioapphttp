import 'package:shared_preferences/shared_preferences.dart';

enum StorageKeys {
  chaveDadosCadastraisNome,
  chaveDadosCadastraisDataNascimento,
  chaveDadosCadastraisNivelExperiencia,
  chaveDadosCadastraisLinguagens,
  chaveDadosCadastraisTempoExperiencia,
  chaveDadosCadastraisSalario,
  chaveConfigNomeUsuario,
  chaveConfigAltura,
  chaveConfigReceberNotificacoes,
  chaveConfigTemaEscuro,
  chaveNumeroAleatorio,
  chaveQuatidadeCliques;
}

class AppStorageService {
  Future<void> setDadosCadastraisNome(String nome) async {
    _setString(StorageKeys.chaveDadosCadastraisNome, nome);
  }

  Future<String> getDadosCadastraisNome() async {
    return _getString(StorageKeys.chaveDadosCadastraisNome);
  }

  Future<void> setDadosCadastraisDataNascimento(DateTime data) async {
    _setString(StorageKeys.chaveDadosCadastraisDataNascimento, data.toString());
  }

  Future<String> getDadosCadastraisDataNascimento() async {
    return _getString(StorageKeys.chaveDadosCadastraisDataNascimento);
  }

  Future<void> setDadosCadastraisNivelExperiencia(
      String nivelExperiencia) async {
    _setString(
        StorageKeys.chaveDadosCadastraisNivelExperiencia, nivelExperiencia);
  }

  Future<String> getDadosCadastraisNivelExperiencia() async {
    return _getString(StorageKeys.chaveDadosCadastraisNivelExperiencia);
  }

  Future<void> setDadosDadosCadastraisLinguagens(
      List<String> linguagens) async {
    _setStringList(StorageKeys.chaveDadosCadastraisLinguagens, linguagens);
  }

  Future<List<String>> getDadosDadosCadastraisLinguagens() async {
    return _getStringList(StorageKeys.chaveDadosCadastraisLinguagens);
  }

  Future<void> setDadosCadastraisTempoExperiencia(int tempoExperiencia) async {
    _setInt(StorageKeys.chaveDadosCadastraisTempoExperiencia, tempoExperiencia);
  }

  Future<int> getDadosCadastraisTempoExperiencia() async {
    return _getInt(StorageKeys.chaveDadosCadastraisTempoExperiencia);
  }

  Future<void> setDadosCadastraisSalario(double salario) async {
    _setDouble(StorageKeys.chaveDadosCadastraisSalario, salario);
  }

  Future<double> getDadosCadastraisSalario() async {
    return _getDouble(StorageKeys.chaveDadosCadastraisSalario);
  }

  Future<void> setConfigNomeUsuario(String nome) async {
    _setString(StorageKeys.chaveConfigNomeUsuario, nome);
  }

  Future<String> getConfigNomeUsuario() async {
    return _getString(StorageKeys.chaveConfigNomeUsuario);
  }

  Future<void> setConfigAltura(double altura) async {
    _setDouble(StorageKeys.chaveConfigAltura, altura);
  }

  Future<double> getConfigAltura() async {
    return _getDouble(StorageKeys.chaveConfigAltura);
  }

  Future<void> setConfigReceberNotificacoes(bool receberNotificacao) async {
    _setBool(StorageKeys.chaveConfigReceberNotificacoes, receberNotificacao);
  }

  Future<bool> getConfigReceberNotificacoes() async {
    return _getBool(StorageKeys.chaveConfigReceberNotificacoes);
  }

  Future<void> setConfigTemaEscuro(bool temaEscuro) async {
    _setBool(StorageKeys.chaveConfigTemaEscuro, temaEscuro);
  }

  Future<bool> getConfigTemaEscuro() async {
    return _getBool(StorageKeys.chaveConfigTemaEscuro);
  }

  Future<void> setNumeroAleatorio(int numero) async {
    _setInt(StorageKeys.chaveNumeroAleatorio, numero);
  }

  Future<int> getNumeroAleatorio() async {
    return _getInt(StorageKeys.chaveNumeroAleatorio);
  }

  Future<void> setQuantidadeCliques(int quantidade) async {
    _setInt(StorageKeys.chaveQuatidadeCliques, quantidade);
  }

  Future<int> getQuantidadeCliques() async {
    return _getInt(StorageKeys.chaveQuatidadeCliques);
  }

  void _setString(StorageKeys key, String value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(key.toString(), value);
  }

  Future<String> _getString(StorageKeys key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(key.toString()) ?? "";
  }

  void _setStringList(StorageKeys key, List<String> values) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setStringList(key.toString(), values);
  }

  Future<List<String>> _getStringList(StorageKeys key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(key.toString()) ?? [];
  }

  void _setInt(StorageKeys key, int value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setInt(key.toString(), value);
  }

  Future<int> _getInt(StorageKeys key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(key.toString()) ?? 0;
  }

  void _setDouble(StorageKeys key, double value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setDouble(key.toString(), value);
  }

  Future<double> _getDouble(StorageKeys key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(key.toString()) ?? 0.0;
  }

  void _setBool(StorageKeys key, bool value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(key.toString(), value);
  }

  Future<bool> _getBool(StorageKeys key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(key.toString()) ?? false;
  }
}
