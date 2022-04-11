import 'package:flutter/cupertino.dart';

class ElementSearchState {
  final String searchTerm;

  ElementSearchState({required this.searchTerm});

  factory ElementSearchState.initial() => ElementSearchState(searchTerm: '');

  ElementSearchState copyWith({String? searchTerm}) =>
      ElementSearchState(searchTerm: searchTerm ?? this.searchTerm);
}

class ElementSearch with ChangeNotifier {
  ElementSearchState _state = ElementSearchState.initial();
  ElementSearchState get state => _state;

  void setSearchTerm(String newSearchTerm) {
    _state = _state.copyWith(searchTerm: newSearchTerm);
    notifyListeners();
  }
}
