import 'package:counter_with_bloc/helper_functions/error_handler.dart';
import 'package:counter_with_bloc/model/post.dart';
import 'package:counter_with_bloc/repository/api_client.dart';
import 'package:counter_with_bloc/response/get_all_post_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlaceHolderRepository {
  final Dio _dio = ApiClient().dio;
  factory PlaceHolderRepository() {
    return _instance;
  }
  PlaceHolderRepository._internal();

  static final PlaceHolderRepository _instance =
      PlaceHolderRepository._internal();

  Future<List<Post>> fetchPosts([int startIndex = 0]) async {
    try {
      final response = await _dio.get(
        '/posts',
        queryParameters: {
          '_start': '$startIndex',
          '_limit': '10',
        },
      );
      List<Post> posts = AllPostsResponse.fromJson(response.data).posts;
      return posts;
    } catch (error ) {
      debugPrint(error.toString());
      throw errorHandler(error);
    }
  }
}
