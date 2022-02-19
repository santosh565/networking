import 'package:counter_with_bloc/model/post.dart';
import 'package:counter_with_bloc/repository/api_client.dart';
import 'package:counter_with_bloc/repository/api_result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../helper_functions/error_handler.dart';
import '../response/get_all_post_response.dart';

class PlaceHolderRepository {
  final Dio _dio = ApiClient().dio;
  factory PlaceHolderRepository() {
    return _instance;
  }
  PlaceHolderRepository._internal();

  static final PlaceHolderRepository _instance =
      PlaceHolderRepository._internal();

  Future<ApiResult<List<Post>>> getAllPosts() async {
    try {
      final response = await _dio.get('posts');
      List<Post> posts = AllPostsResponse.fromJson(response.data).posts;
      return ApiResult.success(posts);
    } catch (error, stackTrace) {
      debugPrint("error occured $error stackTrace:$stackTrace");
      return ApiResult.failure(errorHandler(error));
    }
  }
}
