import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:efermera_app/login2.dart';
class Tema1Quiz {
  var images = ['iconos0.png', 'iconos1.png', 'iconos2.png', 'iconos3.png'];
  var questions = [
    'icono0 prueba',
    'icono1 prueba',
    'icono2 prueba',
    'icono3 prueba'
  ];
  var choices = [
    ['00', '01', '02', '03'],
    ['10', '11', '12', '13'],
    ['20', '21', '22', '23'],
    ['30', '31', '32', '33']
  ];

  var correctAnswers = ['01', '12', '21', '33'];
}

var finalScore = 0;
var questionNumber = 0;
var quiz = new Tema1Quiz();

class Quiz1 extends StatefulWidget {
  Quiz1(this.userUID);
   final  String userUID;

  @override
  State<StatefulWidget> createState() {
    return new Quiz1State();
  }
}

class Quiz1State extends State<Quiz1> {



  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text('Quiz'),
        ),
        body: new Container(
          margin: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new Padding(padding: EdgeInsets.all(20.0)),
              new Container(
                alignment: Alignment.centerRight,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      "Question ${questionNumber + 1} of ${quiz.questions.length}",
                      style: new TextStyle(fontSize: 22.0),
                    ),
                    new Text("Score $finalScore",
                        style: new TextStyle(fontSize: 22.0))
                  ],
                ),
              ),
              new Padding(padding: EdgeInsets.all(10.0)),
              new Image.asset("images/${quiz.images[questionNumber]}"),
              new Text(quiz.questions[questionNumber],
                  style: TextStyle(fontSize: 20.0)),
              Padding(padding: EdgeInsets.all(10.0)),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new MaterialButton(
                    minWidth: 120.0,
                    onPressed: () {
                      if (quiz.choices[questionNumber][0] ==
                          quiz.correctAnswers[questionNumber]) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context)
                            {
                              return AlertDialog(
                                title: new Text("Alert title"),
                                content: new Text("Alert content"),
                                actions: <Widget>[
                                  RaisedButton(
                                    child: new Text("Close", style: TextStyle(color: Colors.white),),
                                    onPressed: (){
                                      Navigator.pop(context, 'Cancel');
                                    },
                                  ),
                                ],
                              );
                            }
                        );
                        debugPrint('correcto');
                        finalScore++;
                      } else {
                        debugPrint('incirrectoo');
                      }
                      updateQuestion();
                    },
                    child: new Text(quiz.choices[questionNumber][0]),
                    color: Colors.cyan,
                  )
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new MaterialButton(
                    minWidth: 120.0,
                    onPressed: () {
                      if (quiz.choices[questionNumber][1] ==
                          quiz.correctAnswers[questionNumber]) {
                        debugPrint('correcto');
                        finalScore++;
                      } else {
                        debugPrint('incirrectoo');
                      }
                      updateQuestion();
                    },
                    child: new Text(quiz.choices[questionNumber][1]),
                    color: Colors.cyan,
                  )
                ],
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new MaterialButton(
                    minWidth: 120.0,
                    onPressed: () {
                      if (quiz.choices[questionNumber][2] ==
                          quiz.correctAnswers[questionNumber]) {
                        debugPrint('correcto');
                        finalScore++;
                      } else {
                        debugPrint('incirrectoo');
                      }
                      updateQuestion();
                    },
                    child: new Text(quiz.choices[questionNumber][2]),
                    color: Colors.cyan,
                  )
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new MaterialButton(
                    minWidth: 120.0,
                    onPressed: () {
                      if (quiz.choices[questionNumber][3] ==
                          quiz.correctAnswers[questionNumber]) {
                        debugPrint('correcto');

                        finalScore++;
                      } else {
                        debugPrint('incirrectoo');
                      }
                      updateQuestion();
                    },
                    child: new Text(quiz.choices[questionNumber][3]),
                    color: Colors.cyan,
                  )
                ],
              ),
              new Container(
                  alignment: Alignment.bottomCenter,
                  child: new MaterialButton(
                      onPressed: resetQuiz, child: new Text('salir')))
            ],
          ),
        ),
      ),
    );
  }

  void resetQuiz() {
    setState(() {
      Navigator.pop(context);
      finalScore = 0;
      questionNumber = 0;
    });
  }

  void updateQuestion() {
    setState(() {
      if (questionNumber == quiz.questions.length - 1) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Summary(score: finalScore,userUID: widget.userUID, )));
      } else {
        questionNumber++;
      }
    });
  }
}

class Summary extends StatelessWidget {
  final int score;

  final userUID;

  Summary({Key key, @required this.score, this.userUID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
        child: Scaffold(
            body: new Container(
              color: Colors.cyan[50],
          child: new Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(padding:  EdgeInsets.only(left: 1000)),
              new Text('Puntuacion: $score', style: new TextStyle(fontSize: 40,),),
              new Padding(padding: EdgeInsets.only(top: 100),),
              new MaterialButton(color: Colors.red,
              child: new Text('Guardar y salir'),
              onPressed: (){
                uploadScore(finalScore);
                questionNumber = 0;
                finalScore = 0;


                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return (LoginPage(userUID));
                }));
              })],
          ),
        )),
        onWillPop: () async => false);

  }


void uploadScore(finalScore) async{
    Firestore db = Firestore.instance;
    int mScore;
   await db.collection('Perfiles').document(userUID).get().then((data){

       mScore= data.data['ScoreTema1'];
       print(mScore);

    });

    if(mScore>finalScore){
        print('No actualizo');
    }else{
      await db.collection('Perfiles').document(userUID).updateData({'ScoreTema1': finalScore});
    }

}

}