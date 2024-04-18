import 'package:dio/dio.dart';

class JsonPlaceHolderCustomDio {
  final _dio = Dio();

  JsonPlaceHolderCustomDio() {
    _dio.options.baseUrl = "https://jsonplaceholder.typicode.com";
  }

  Dio get dio => _dio;
}
