import 'package:flutter/material.dart';

class Second extends StatefulWidget {
  Second({Key key}) : super(key: key);
  @override
  Mstack createState() => new Mstack();
}

class Mstack extends State<Second> {
  final List<String> items = <String>["one", 'two'];
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void additem() {
    setState(() {
      items.insert(0, nameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Dynamic List"),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Medicine Name',
            ),
          ),
        ),
        FloatingActionButton(
            child: Icon(Icons.add), onPressed: () => additem()),
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    margin: EdgeInsets.all(8),
                    color: Colors.amber,
                    child: Center(
                        child: Text(
                      '${items[index]}',
                      style: TextStyle(fontSize: 20),
                    )),
                  );
                })),
      ]),
    );
  }
}
