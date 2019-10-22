import 'dart:math';
import 'dart:ui' as ui;

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class MyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC', //indice de masa corporal
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  State<StatefulWidget> createState() => Calculadora();
}

class Calculadora extends State<MyCalculator> {
  final controller_peso = TextEditingController();
  final controller_talla = TextEditingController();
  final my_form_key = GlobalKey<FormState>();
  final d = Decimal;

  String muestreImc = "";

  void IMC() {
    int pesoidealm = 21;
    int decimals = 2;
    int fad = pow(10, decimals);

    //realizamos las validaciones si algun campo este vacio
    if (my_form_key.currentState.validate()) {
      double peso = double.parse(controller_peso.text);
      double altura = double.parse(controller_talla.text);
      double rtaAltura = (altura) / 100;
      double alturapordos = rtaAltura * rtaAltura;
      double result = peso / alturapordos;

      double d = result;
      d = (d * fad).round() / fad;

      //formula para sugerir el peso de la persona
      double sugerido = (pesoidealm * peso) / d;
      sugerido = (sugerido * fad).round() / fad;

      setState(() {
        muestreImc = "Tu IMC es de: $d";
      });
    }
  }

//ahora realizaremos el layout o diseño de nuestra calculadora
//de indice de masa corporal
  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _height = logicalSize.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Calculadora IMC'),
      ),
      body: Form(
          key: my_form_key,
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 500,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Color(0xFFf01DFD7),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(80),
                          bottomLeft: Radius.circular(80)),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: new Image(
                            width: 200.0,
                            height: 150.0,
                            image: new AssetImage('assets/images/scale.png'),
                          ),
                        )
                      ],
                    ),
                  ),

                  //agregamos un Container
                  Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 50,
                          padding: EdgeInsets.all(7),
                          child: TextFormField(
                            controller: controller_peso,
                            validator: (value) {
                              if (value.isEmpty) return "Campo vacío";
                            },
                            decoration: InputDecoration(
                                hintText: "Peso Kg",
                                icon: Icon(Icons.call_to_action)),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          padding: EdgeInsets.all(7),
                          child: TextFormField(
                            controller: controller_talla,
                            validator: (value) {
                              if (value.isEmpty) return "Campo vacío";
                            },
                            decoration: InputDecoration(
                                hintText: "Altura Cm",
                                icon: Icon(Icons.arrow_upward)),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: IMC,
                        color: Colors.blue,
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[Text('Resultado')],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  //caja de resultado
                  Container(
                    height: 50.0,
                    width: 300,
                    //creamos resultado del TextFormField
                    child: Center(
                      child: Text(
                        muestreImc,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Table(
                    children: [
                      TableRow(children: [
                        Text(
                          'IMC',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Percentil',
                          textAlign: TextAlign.center,
                        )
                      ]),
                      TableRow(children: [
                        Text(
                          '<16.0',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Infrapeso',
                          textAlign: TextAlign.center,
                        )
                      ]),
                      TableRow(children: [
                        Text('16.0 - 16.99',
                            textAlign: TextAlign.center
                        ),
                        Text(
                          'Infrapeso',
                          textAlign: TextAlign.center,
                        )
                      ]),
                      TableRow(children: [
                        Text(
                          '17.0 - 18.4',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Infrapeso',
                          textAlign: TextAlign.center,
                        )
                      ]),
                    ],
                  ),
                ],
              ))),
    );
  }
}
