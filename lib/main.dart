import 'package:flutter/material.dart';

/* import 'parsing_json/json_parsing.dart'; */
import 'parsing_json/json_parsing_map.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JsonParsingMap(),
    );
  }
}
