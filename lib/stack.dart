import 'package:flutter/material.dart';
import 'package:medstack/database_helper.dart';

class Second extends StatefulWidget {
  // Second({Key key}) : super(key: key);
  @override
  Mstack createState() => new Mstack();
}

class Mstack extends State<Second> {
  final List<String> items = <String>[];
  final List<String> quantity = <String>[];
  TextEditingController nameController = TextEditingController();
  TextEditingController quantController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _read() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int rowId = 1;
    Word word = await helper.queryWord(rowId);
    if (word == null) {
      print('read row $rowId: empty');
    } else {
      print('read row $rowId: ${word.med} ${word.frequency}');
    }
  }

  _save() async {
    Word word = Word();
    word.med = items.first;
    word.frequency = int.parse(quantity.first);
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(word);
    print('inserted row: $id');
  }

  void append() {
    items.insert(0, nameController.text);
    quantity.insert(0, quantController.text);
    _read();
    _save();
  }

  void additem() {
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Add Medicine"),
            content: Container(
                height: 150,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          // hintText: 'ParaCetamol',
                          labelText: 'Medicine Name',
                        ),
                      ),
                      Spacer(),
                      TextField(
                        controller: quantController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          // hintText: '5',
                          labelText: 'Medicine Quant',
                        ),
                      )
                    ])),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Add"),
                onPressed: () {
                  append();
                  setState(() {});
                  Navigator.of(context).pop();
                },
              ),

              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text("Cancel"))
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Dynamic List"),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    margin: EdgeInsets.all(8),
                    color: Colors.amber,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            '${items[index]}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '${quantity[index]}',
                            style: TextStyle(fontSize: 20),
                          )
                        ]),
                  );
                })),
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => additem()),
    );
  }
}
