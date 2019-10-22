import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class ExampleTema extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExampleTema();
}

class _ExampleTema extends State<ExampleTema> {
  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L'];
  final List<int> colorCodes = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 900, 800, 700];
  final List<int> data = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];

  @override
  Widget build(BuildContext context) {
    var pages = [MyApp()];
    var myGridView = new ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          // ignore: missing_return
          return new GestureDetector(
            child: new Container(
              height: 50,
              color: Colors.cyan[colorCodes[index]],
              child: Center(child: Text('Tema ${data[index]}', style: new TextStyle(fontSize: 20),)),

            ),


            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return (pages[index]);
              }));
            },
          );
          {}

          return new Container(
            height: 50,
            color: Colors.amber[colorCodes[index]],
            child: Center(child: Text('Entry ${data[index]}')),
          );
        },   separatorBuilder: (BuildContext context, int index) => const Divider());

        return new Scaffold(
      appBar: new AppBar(
        title: new Text("Temas" + ' ' + data.length.toString()),
      ),
      body: myGridView,
    );
  }
}
