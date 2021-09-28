import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';

Future<String> _loadJSON() async {
  return await rootBundle.loadString('source/json/clock_json.json');
}

Future<Clock> loadJSON() async {
  String jsonString = await _loadJSON();
  Clock clock = _parseJson(jsonString);
  return clock;
  //для проверки
  // return Future.delayed(Duration(seconds: 20), () => clock);
}

Clock _parseJson(String jsonString) {
  Map decoded = jsonDecode(jsonString);
  List<Word> words = [];
  for (var word in decoded['clock']) {
    words.add(new Word(word['id'], word['name'], word['url'],
        word['description'], word['price']));
  }
  return new Clock(words);
}
