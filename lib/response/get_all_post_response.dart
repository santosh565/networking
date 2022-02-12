import '../model/post.dart';

class AllPostsResponse {
  List<Post> posts;

  AllPostsResponse({required this.posts});

  AllPostsResponse.fromJson(List<dynamic> json)
      : posts = json.map((post) => Post.fromJson(post)).toList();
}
