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

  Future<bool> _save() async {
    Settings settings = _state.settings!;

    String json = jsonEncode(settings.toJson());
    final pref = await SharedPreferences.getInstance();
    bool complete = await pref.setString(settingsKey, json);
    return complete;
  }

  bool loading = false;

  void changeLoadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }

  Future<bool> setName(String name) async {
    changeLoadingStatus(true);
    if (_state.settings == null) {
      Settings settings = Settings(name: name, lang: 'en');
      _state = _state.copyWith(settings);
    } else {
      _state = _state.copyWith(
        _state.settings?.copyWith(
          name: name,
        ),
      );
    }

    changeLoadingStatus(false);

    return _save();
  }
}
