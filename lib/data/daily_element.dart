import 'dart:convert';
import 'dart:math';

import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/periodic_table_json.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyElement {
  final DateTime date;
  final Atom element;

  DailyElement({required this.date, required this.element});

  factory DailyElement.fromJson(Map<String, dynamic> json) {
    var rawDay = json['date'];
    var rawElement = json['element'];

    DateTime day = DateTime.parse(rawDay);
    Atom element = Atom.fromJson(rawElement);

    return DailyElement(date: day, element: element);
  }

  static DailyElement fromRawJson(String json) => DailyElement.fromJson(
        jsonDecode(json),
      );

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'element': element.toJson(),
    };
  }

  String toRawJson() => jsonEncode(toJson());

  static const String _dailyElementKey = 'DailyElementGeneratorKey';

  static Future<Atom> getElementOfTheDay() async {
    var prefs = await SharedPreferences.getInstance();
    var rawElementData = prefs.getString(_dailyElementKey);

    if (rawElementData == null) {
      var dailyElement = await _updateDailyElement();
      return dailyElement.element;
    } else {
      DailyElement dailyElement = DailyElement.fromRawJson(rawElementData);
      DateTime today = DateTime.now();
      if (today.day != dailyElement.date.day) {
        var dailyElement = await _updateDailyElement();
        return dailyElement.element;
      } else {
        return dailyElement.element;
      }
    }
  }

  static Future<DailyElement> _updateDailyElement() async {
    while (true) {
      DailyElement dailyElement = _refreshElement();
      bool saved = await _save(dailyElement);
      if (saved) {
        return dailyElement;
      }
    }
  }

  static DailyElement _refreshElement() {
    List<Atom> elements = getElementList();
    var totalElements = elements.length;
    var randomElement = Random().nextInt(totalElements);
    Atom currentElement = elements[randomElement];
    DateTime currentTime = DateTime.now();

    DailyElement dailyElement =
        DailyElement(date: currentTime, element: currentElement);

    return dailyElement;
  }

  static Future<bool> _save(DailyElement dailyElement) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.setString(_dailyElementKey, dailyElement.toRawJson());
  }
}

getElementList() {
  List<Atom> elements = <Atom>[];
  List<Map<String, dynamic>> json = periodicTableJson['elements'];
  for (var element in json) {
    elements.add(Atom.fromJson(element));
  }

  print(elements.length);
  return elements;
}
