import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/pages/home.dart';
import 'package:whisper_arts_tests/pages/basket/basket.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.teal[900],
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/basket': (context) => Basket(),
    },
  ));
}
