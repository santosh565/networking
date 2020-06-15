import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonParsingSimple extends StatefulWidget {
  @override
  _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {
  Future data;
  @override
  void initState() {
    super.initState();
    /* data = getData(); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json Parsing'),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot snapShot) {
              if (snapShot.hasData) {
                return createListView(context, snapShot.data);
                /*  return Text(
                                  snapShot.data[0]['userId'].toString(),
                                ); */
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Future getData() async {
    Future data;
    String url = 'https://jsonplaceholder.typicode.com/posts';
    Network network = Network(url);
    data = network.fetchData();
    /*  data.then((value) {
                      print(value[0]['title']);
                    }); */

    return data;
  }

  Widget createListView(BuildContext context, List data) {
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
                  '${data[index]['id']}',
                ),
              ),
              title: Text('${data[index]['title']}'),
              subtitle: Text('${data[index]['body']}'),
            ),
          ],
        );
      },
    );
  }
}

class Network {
  final String url;

  Network(this.url);

  Future fetchData() async {
    print('$url');

    Response response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
