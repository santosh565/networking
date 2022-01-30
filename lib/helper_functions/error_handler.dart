import 'dart:convert';

import 'package:dio/dio.dart';

String handleError(error) {
  String? errorDescription;
  if (error is DioError) {
    DioError dioError = error;
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        errorDescription = "No internet connection";
        break;
      case DioErrorType.receiveTimeout:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        errorDescription =
            "Received invalid status code: ${dioError.response?.statusCode}";
        switch (dioError.response?.statusCode) {
          case 401:
            errorDescription = "unauthenticated";
            break;
          case 422:
            if (dioError.response?.data["errors"] != null) {
              var errors = json.encode(dioError.response?.data["errors"]);
              errorDescription = json
                  .decode(errors)
                  .values
                  .toList()
                  .map((v) => v.join("\n"))
                  .join("\n");
            } else if (dioError.response?.data["message"] != null) {
              errorDescription = dioError.response?.data["message"];
            } else {
              errorDescription = dioError.response?.statusMessage;
            }
            break;
          case 500:
            if (dioError.response?.data["message"] != null) {
              errorDescription = dioError.response?.data["message"];
            } else {
              errorDescription = "something went wrong on server";
            }
            break;
        }
        break;
      case DioErrorType.sendTimeout:
        errorDescription = "Send timeout in connection with API server";
        break;
    }
  } else {
    errorDescription = "Unexpected error occurred";
  }
  return errorDescription!;
}
