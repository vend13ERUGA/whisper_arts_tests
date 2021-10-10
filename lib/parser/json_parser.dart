import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';

Future<String> _loadJSON() async {
  return await rootBundle.loadString('source/json/clock_json.json');
}

Future<List<ClockData>> loadJSON([Iterable<int>? listID]) async {
  String jsonString = await _loadJSON();
  // print(jsonString);
  List<dynamic> decoded = jsonDecode(jsonString);
  List<ClockData> clock = [];

  if (listID == null) {
    for (var key in decoded) {
      clock.add(ClockData(key['id'], key['name'], key['url'],
          key['description'], key['price']));
    }
  } else {
    for (var id in listID) {
      for (var key in decoded) {
        if (key['id'] == id) {
          clock.add(ClockData(key['id'], key['name'], key['url'],
              key['description'], key['price']));
        }
      }
    }
  }

  return clock;
  // для проверки
  // return Future.delayed(Duration(seconds: 20), () => clock);
}
