import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'imc_calculator.dart';

class GeneralCalculators extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GeneralCalculatorsState();
}

class _GeneralCalculatorsState extends State<GeneralCalculators> {
  @override
  Widget build(BuildContext context) {
    var data = [
      'images/image.jpg',

      ""
    ];
    var pages = [MyCalculator()];
    var myGridView = new GridView.builder(
      itemCount: data.length,
      gridDelegate:
      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.centerLeft,
              child: new Image.asset('images/image$index.jpg'),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return (pages[index]);
            }));
          },
        );
      },
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter GridView"),
      ),
      body: myGridView,
    );
  }
}
