class ApiResult<T> {
  T? data;
  String? error;

  ApiResult.success(T successData) : data = successData;
  ApiResult.failure(String errorValue) : error = errorValue;
}
