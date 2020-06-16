import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:networking/model/post.dart';

class JsonParsingMap extends StatefulWidget {
  @override
  _JsonParsingMapState createState() => _JsonParsingMapState();
}

class _JsonParsingMapState extends State<JsonParsingMap> {
  Future<PostList> data;

  @override
  void initState() {
    super.initState();
    Network network = Network('https://jsonplaceholder.typicode.com/posts');
    data = network.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PODO'),
      ),
      body: Center(
        child: FutureBuilder(
          future: data,
          builder: (context, AsyncSnapshot<PostList> snapShot) {
            List<Post> allPosts;
            if (snapShot.hasData) {
              allPosts = snapShot.data.posts;

              return createListView(context, allPosts);
             /*  return Text('${allPosts[0].title}'); */
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class Network {
  final String url;

  Network(this.url);

  Future<PostList> loadPosts() async {
    final response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      return PostList.fromJson(jsonDecode(response.body));
    } else
      throw Exception('failed to load posts');
  }
}

Widget createListView(BuildContext context, List<Post> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, int index) {
        return Column(
          children: <Widget>[
            Divider(
              thickness: 2,
              height: 2,
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 20,
                child: Text(
                  '${data[index].id}',
                ),
              ),
              title: Text('${data[index].title}'),
              subtitle: Text('${data[index].body}'),
            ),
          ],
        );
      },
    );
  }
