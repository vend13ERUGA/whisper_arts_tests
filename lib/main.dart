import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/pages/home.dart';
import 'package:whisper_arts_tests/parser/json_parser.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.teal[900],
    ),
    home: Home(),
  ));
}
