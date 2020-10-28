import 'package:flutter/material.dart';
import 'package:medstack/constant.dart';
import 'package:medstack/stack.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Second(),
      routes: <String, WidgetBuilder> {
        STACK: (BuildContext context) => Second()
      },
    );
  }

}
