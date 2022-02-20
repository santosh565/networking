import 'dart:io';

import 'package:dio/dio.dart';

class ApiClient {
  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _dio = Dio(_options);

    _dio.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  static final ApiClient _instance = ApiClient._internal();

  static const String _baseUrl = "https://jsonplaceholder.typicode.com";
  static const String _appUrl = _baseUrl;

  late Dio _dio;
  get dio => _dio;

  final BaseOptions _options = BaseOptions(
    receiveTimeout: 5000,
    connectTimeout: 30000,
    baseUrl: _appUrl,
    headers: {
      HttpHeaders.acceptHeader: ContentType.json,
    },
  );
}
