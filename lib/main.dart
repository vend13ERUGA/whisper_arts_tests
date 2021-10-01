import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/pages/home.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.teal[900],
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
    },
  ));
}
