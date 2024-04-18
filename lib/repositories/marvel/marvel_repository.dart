import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trilhaapp/model/characters_model.dart';
import 'package:crypto/crypto.dart';

class MarvelRepository {
  Future<CharactersModel> getCharacters(int offset) async {
    final dio = Dio();
    final ts = DateTime.now().microsecondsSinceEpoch.toString();
    final publicKey = dotenv.get("MARVELPUBLICKEY");
    final privateKey = dotenv.get("MARVELAPIKEY");
    final hash = _generateMD5(ts + privateKey + publicKey);
    final query = "offset=$offset&ts=$ts&apikey=$publicKey&hash=$hash";
    final result =
        await dio.get("https://gateway.marvel.com/v1/public/characters?$query");
    if (result.statusCode == 200) {
      return CharactersModel.fromJson(result.data);
    }
    return CharactersModel();
  }

  String _generateMD5(String data) {
    final content = const Utf8Encoder().convert(data);
    final digest = md5.convert(content);
    return digest.toString();
  }
}
