import 'dart:math';

import 'package:flutter/material.dart';
import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/periodic_table_json.dart';

class ElementListState {
  final List<Atom> atoms;
  double maxElectronAffinity = double.negativeInfinity;
  double minElectronAffinity = double.infinity;

  ElementListState({
    required this.atoms,
  });

  calculateMinMax() {
    for (Atom atom in atoms) {
      maxElectronAffinity = max<num>(
        maxElectronAffinity,
        atom.electronAffinity ?? double.negativeInfinity,
      ).toDouble();

      minElectronAffinity = min<num>(
        minElectronAffinity,
        atom.electronAffinity ?? double.infinity,
      ).toDouble();
    }
  }

  factory ElementListState.initial() {
    List<Atom> elements = <Atom>[];
    List<Map<String, dynamic>> json = periodicTableJson['elements'];
    for (var element in json) {
      elements.add(Atom.fromJson(element));
    }

    return ElementListState(atoms: elements)..calculateMinMax();
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
