import 'package:flutter/material.dart';
import 'package:medstack/stack.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var MED_STACK;

  // String MED_STACK;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new MaterialApp(initialRoute: '/', routes: <String, WidgetBuilder>{
        MED_STACK: (BuildContext context) => new Second(),
      }),
    );
  }

  // @override
  // First createState() => First();
}

// class First extends State<MyApp> {

// }
