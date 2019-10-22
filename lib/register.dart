import 'package:flutter/material.dart';
import 'auth.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthMethods auth;
  String emailUser;
  String surname1;
  String surname2;
  String userName;
  String password;
  final _formKey = GlobalKey<FormState>();

  final crtlEmail = new TextEditingController();
  final crtlapellido1 = new TextEditingController();
  final crtlapellido2 = new TextEditingController();
  final crtlusername= new TextEditingController();
  final crtlPassword = new TextEditingController();

  String userUID;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(

        title: Text("Registro"),
      ),
      body: new Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              FlutterLogo(style: FlutterLogoStyle.horizontal, size: 200),
              Text("Datos personales"),
              new TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Escribe";
                  }
                return null;
                },
                controller: crtlusername,
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 30),
                    hintText: "Nombre",
                    labelText: "Nombre"),
                ),
              new TextFormField(
                controller: crtlapellido1,
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(
                    hintText: "Appelido 1", labelText: "Apellido 1"),
              ),
              new TextFormField(
                controller: crtlapellido2,
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(
                  hintText: "Apellido 2",
                  labelText: "Apellido 2",
                ),
              ),

              new TextFormField(
                controller: crtlEmail,
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

              RaisedButton(
                color: Colors.cyan,
                textColor: Colors.black,
                child: Text(
                  "Entrar",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () async{
                    print("Bien");
                    String email = crtlEmail.text;
                    String username = crtlusername.text;
                    String password = crtlPassword.text;
                    String surname1 = crtlapellido1.text;
                    String surname2 = crtlapellido2.text;
                    try{
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((data){
                       userUID= data.user.uid;
                        createProfile(userUID,username,surname1,surname2,email);
                      });

                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return LoginPage(userUID);
                      }));
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
          ),

          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return MyApp();}));
          },
          child: Text("Tengo ya una cuenta"),
        )
      ],
    );
  }

  void signUp() async{

      try{
        String email = crtlEmail.text;
        String username = crtlusername.text;
        String password = crtlPassword.text;
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return LoginPage(userUID);
        }));

      } catch(e){
        print(e.message);
      }

  }

  ///Crea el Perfil de Usuario
  Future<void> createProfile(String userUID,String username, String surname1,String surname2,String email) async {


    Firestore.instance
        .collection('Perfiles')
        .document(userUID)
        .setData({
      "Nombre": username,
      "Surname1": surname1,
      "Surname2": surname2,
      "Email": email,
      "ScoreTema1": 0,

    }).catchError((e) {
      print(e);
    });

    print('Create Profile: ' + userUID);


  }

}
