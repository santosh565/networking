import 'package:counter_with_bloc/model/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_post_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AllPostsResponse {
  List<Post> posts;

  AllPostsResponse({required this.posts});

  factory AllPostsResponse.fromJson(Map<String, dynamic> json) =>
      _$AllPostsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllPostsResponseToJson(this);
 
}


