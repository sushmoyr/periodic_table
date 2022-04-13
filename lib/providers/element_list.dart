import 'package:flutter/material.dart';
import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/periodic_table_json.dart';

class ElementListState {
  final List<Atom> atoms;

  ElementListState({
    required this.atoms,
  });

  factory ElementListState.initial() {
    List<Atom> elements = <Atom>[];
    List<Map<String, dynamic>> json = periodicTableJson['elements'];
    for (var element in json) {
      elements.add(Atom.fromJson(element));
    }

    print(elements.length);
    return ElementListState(atoms: elements);
  }

  ElementListState copyWith({
    List<Atom>? elements,
  }) =>
      ElementListState(atoms: elements ?? atoms);
}

class ElementList with ChangeNotifier {
  final ElementListState _state = ElementListState.initial();
  ElementListState get state => _state;
}
