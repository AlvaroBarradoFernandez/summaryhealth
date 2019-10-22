import 'dart:io';

import 'package:flutter/material.dart';

import 'register.dart';
import 'login2.dart';
import 'package:firebase_auth/firebase_auth.dart';

  void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'EnfermerApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = new TextEditingController();
  String email;
  String password;
  final crtlusername= new TextEditingController();
  final crtlPassword = new TextEditingController();

  String userUID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.addListener(printSomeValues);
  }

  printSomeValues() {
    print("Controller values $textController");
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: ()async{
          exit(0);
        },
        child:
        Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              FlutterLogo(style: FlutterLogoStyle.horizontal, size: 200),
              new TextFormField(
                controller: crtlusername,
                keyboardType: TextInputType.emailAddress,
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(
                    hintText: "Correo", labelText: "Correo"),
              ),
              new TextFormField(
                controller: crtlPassword,
                obscureText: true,

                decoration: new InputDecoration(

                    hintText: "Contraseña", labelText: "Contraseña"),

              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              ),
              RaisedButton(

                color: Colors.cyan,
                textColor: Colors.black,

                child: Text(
                  "Entrar",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () async {
                  String email = crtlusername.text;
                  String password = crtlPassword.text;
                  try{
                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((data){
                      userUID = data.user.uid;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(userUID)));
                  } catch(e){
                    print(e.message);
                  }

                },

              ),

              //Padding(
              //padding: EdgeInsets.symmetric(vertical: 20.0),
              //child: Text("He olvidado mi contraseña", style: TextStyle(color: Color.fromRGBO(255, 0, 0, 1))),
              //)
            ],
          )),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RegisterPage();
            }));
          },
          child: Text("¿No tienes una cuenta?"),
        )
      ],
      // This trailing comma makes auto-formatting nicer for build methods.
    ));


  }








}
