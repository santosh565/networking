import 'dart:io';

import 'package:dio/dio.dart';

class ApiClient {
  static const String _baseUrl = "https://jsonplaceholder.typicode.com";
  static const String _appUrl = "$_baseUrl/";

  late Dio _dio;
  get dio => _dio;

  ApiClient() {
    BaseOptions options = BaseOptions(
      receiveTimeout: 5000,
      connectTimeout: 30000,
      baseUrl: _appUrl,
      headers: {
        HttpHeaders.acceptHeader: ContentType.json,
      },
    );

    _dio = Dio(options);

    _dio.interceptors.addAll([
      // InterceptorsWrapper(onRequest: (requestOptions, handler) {
      //   _dio.lock();
      //   requestOptions.headers[HttpHeaders.authorizationHeader] = '';

      //   _dio.unlock();
      // }),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }
}

final apiClient = ApiClient();
