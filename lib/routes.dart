import 'package:flutter/material.dart';
import 'login.dart';
import 'main.dart';

Map<String, WidgetBuilder> buildAppRoutes(){
  return{
    '/login': (BuildContext context) => new LoginPage(),
  };
}