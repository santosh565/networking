class AllPostsResponse {
  List<Post> posts;

  AllPostsResponse({required this.posts});

  AllPostsResponse.fromJson(List<dynamic> json)
      : posts = json.map((post) => Post.fromJson(post)).toList();
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post(this.userId, this.id, this.title, this.body);

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'],
        body = json['body'];
}
