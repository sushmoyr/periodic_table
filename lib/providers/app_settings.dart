import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:periodic_table/data/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsState {
  final Settings? settings;

  AppSettingsState({this.settings});

  factory AppSettingsState.initial() {
    return AppSettingsState(
      settings: null,
    );
  }

  AppSettingsState copyWith(Settings? settings) =>
      AppSettingsState(settings: settings ?? this.settings);
}

class AppSettings with ChangeNotifier {
  AppSettingsState _state = AppSettingsState.initial();
  AppSettingsState get state => _state;

  static const settingsKey = 'SETTINGS_KEY';

  AppSettings() {
    readSettings();
  }

  void readSettings() {
    final sharedPreference = SharedPreferences.getInstance();
    sharedPreference.then(
      (prefs) {
        String? settingsJson = prefs.getString(settingsKey);
        if (settingsJson != null) {
          Settings settings = Settings.fromJson(jsonDecode(settingsJson)!);
          _state = _state.copyWith(settings);
        }

        notifyListeners();
      },
    );
  }

  void _save() {
    Settings settings = _state.settings!;

    String json = jsonEncode(settings.toJson());
    final sharedPreferences = SharedPreferences.getInstance();
    sharedPreferences.then(
      (pref) {
        pref.setString(settingsKey, json);
      },
    );
  }

  void setName(String name) {
    print('Set name to $name');
    //TODO call _save()
  }
}
