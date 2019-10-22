import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quizs/quiz1.dart';
class QuizTema1 extends StatefulWidget {
  QuizTema1(this.userUID);
    final String userUID;
  @override
  State<StatefulWidget> createState() {
    return new QuizTema1State();
  }
}

class QuizTema1State extends State<QuizTema1> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Quiz'),
      ),
      body: new Container(
        margin: const EdgeInsets.all(15.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new MaterialButton(
              height: 50.0,
              color: Colors.cyan,
              onPressed: StartQuiz,
              child: new Text(
                'Test tema 1',
                style: new TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            new Padding(padding: EdgeInsets.only(top: 10)),
            new MaterialButton(
              height: 50.0,
              color: Colors.cyan,
              onPressed: StartQuiz,
              child: new Text(
                'Test tema 2',
                style: new TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
  void StartQuiz(){
    setState(() {
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new Quiz1(widget.userUID)));
    });
  }
}
