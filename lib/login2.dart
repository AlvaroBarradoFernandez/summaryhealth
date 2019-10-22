import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'calculators/general_calculators.dart';
import 'main.dart';
import 'register.dart';
import 'exampleTema.dart';
import 'quizTema1.dart';
class LoginPage extends StatefulWidget {


  LoginPage(this.userUID);
      final String userUID;


  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  Firestore db = Firestore.instance;

  String username;
  String email;
  String surname1;
  String surname2;
  @override
  void initState() {
    getUserData();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var data = [
      'Temario',
      "Técnicas",
      "Nanda nic noc",
      "Busq. Bibliografia",
      "Técnicas",
      "Casos Clinicos",
      "Temario Test",
      "Esqueleto",
      "Calculadora",
      "Investigación",
      "Busq. Bibliografica",
      "Procedimientos",
      "Unimecum",
      "Noticias",
      "PRH",
      "Consejos Practicas",
      "Telf. Interes",
      "Nuestra profesion"
    ];
    var pages = [ExampleTema(), RegisterPage(), GeneralCalculators(), QuizTema1(widget.userUID)];
    var co = [
      Color.fromRGBO(255, 255, 255, 1),
      Color.fromRGBO(44, 0, 62, 1),
      Color.fromRGBO(81, 218, 207, 1),
      Color.fromRGBO(210, 250, 251, 1),
      Color.fromRGBO(81, 218, 207, 1),
      Color.fromRGBO(65, 170, 168, 1),
      Color.fromRGBO(44, 0, 62, 1),
      Color.fromRGBO(65, 170, 168, 1),
      Color.fromRGBO(255, 255, 255, 1),
      Color.fromRGBO(255, 255, 255, 1),
      Color.fromRGBO(210, 250, 251, 1),
      Color.fromRGBO(44, 0, 62, 1),
      Color.fromRGBO(65, 170, 168, 1),
      Color.fromRGBO(255, 255, 255, 1),
      Color.fromRGBO(210, 250, 251, 1),
      Color.fromRGBO(255, 255, 255, 1),
      Color.fromRGBO(65, 170, 168, 1),
      Color.fromRGBO(44, 0, 62, 1)
    ];






      //debugPrint(mail);

    var myGridView = new GridView.builder(
      itemCount: data.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(40), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
            color: co[index],
            elevation: 10.0,
            child: new Container(
            decoration: new BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(120))),
                alignment: Alignment.center,
                //child: new Image.asset('images/image$index.jpg'),
                child: new Column(

                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Image.asset(
                      'images/iconos$index.png',
                      height: 80,

                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                    ),
                    Container(
                      height: 17,
                    width: 200,
                      decoration: new BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(120), topRight: Radius.circular(120), bottomLeft: Radius.circular(120), bottomRight: Radius.circular(120)), color: Colors.black),
                    child: Text(
                      data[index],
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color.fromRGBO(255, 255, 255, 1)),
                      textAlign: TextAlign.center,
                    ),
                    ),
                  ],
                )),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return (pages[index]);
            }));
          },
        );
      },
    );
    return new WillPopScope(
      onWillPop: exitApp,
        child: Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return (pages[1]);
                    }));
                  },
                  child: Text("Perfil"),
                ),
                value: 1,
              ),
              PopupMenuItem(
                value: 2,
                child: GestureDetector(
                  onTap: () {
                    exitApp();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return (MyApp());
                        }));
                  },
                  child: Text("Logout"),
                ),

              ),
            ],

          ),

        ],
        title: new Text("Flutter GridView"),
      ),
      body: myGridView,
        ),
    );


  }
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;




  getUserData() async{
    await db.collection('Perfiles').document(widget.userUID).get().then((datasnapshot) {

      if (datasnapshot.exists) {
        username =  datasnapshot.data['Nombre'];
        email = datasnapshot.data['Email'];
        surname1 = datasnapshot.data['Surname1'];
        surname2= datasnapshot.data['Surname2'];

        print(username);
        print(email);
        print(surname1);
        print(surname2);

      }
    }).catchError((e) {
      print(e);
    });

  }

  Future<bool> exitApp() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('¿Quieres Salir?'),
          actions: <Widget>[
            FlatButton(color: Colors.red, disabledColor: Colors.red, onPressed: (){
              Navigator.of(context).pop();

            },
                child: Text('No')),
            FlatButton(onPressed: (){
              exit(0);
            }, child: Text('Si')),
          ],
        );
      },
    );

  }
}

 _willPopCallback() async {
  // await showDialog or Show add banners or whatever
  // then
  return exit(0); // return true if the route to be popped
}


//then pass the callback to WillPopScope
