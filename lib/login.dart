import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          crossAxisSpacing: 2.0,
          children: List.generate(8, (index) {
            return Image.asset(
              'images/Iconos$index.png',
              width: 200.0,
              height: 200.0,
              alignment: Alignment(0.0, 0.0),
              fit: BoxFit.fill,
            );
          }),
        );
      }),
    );
  }
}
