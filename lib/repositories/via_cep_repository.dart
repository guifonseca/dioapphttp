import 'dart:convert';

import 'package:trilhaapp/model/via_cep_model.dart';
import 'package:http/http.dart' as http;

class ViaCepRepository {
  Future<ViaCEPModel> consultarCEP(String cep) async {
    final response =
        await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ViaCEPModel.fromJson(json);
    }
    return ViaCEPModel();
  }
}
