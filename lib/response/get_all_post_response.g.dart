// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPostsResponse _$AllPostsResponseFromJson(Map<String, dynamic> json) =>
    AllPostsResponse(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPostsResponseToJson(AllPostsResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts.map((e) => e.toJson()).toList(),
    };
