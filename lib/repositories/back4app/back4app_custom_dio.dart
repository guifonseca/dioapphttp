import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trilhaapp/repositories/back4app/back4app_dio_interceptor.dart';

class Back4appCustomDio {
  late Dio _dio;

  Back4appCustomDio() {
    _dio = Dio();
    _dio.options.headers["content-type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
    _dio.interceptors.add(Back4appDioInterceptor());
  }

  Dio get dio => _dio;
}
