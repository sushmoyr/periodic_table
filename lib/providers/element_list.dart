import 'dart:math';

import 'package:flutter/material.dart';
import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/periodic_table_json.dart';

class ElementListState {
  final List<Atom> atoms;
  double maxElectronAffinity = double.negativeInfinity;
  double minElectronAffinity = double.infinity;

  Set<double> boilingPointsSet = {};
  Set<double> meltingPointSet = {};
  Set<double> electronNegativitySet = {};
  Set<double> electronAffinitySet = {};
  //Set<double> boilingPointsSet = {};

  ElementListState({
    required this.atoms,
  }) {
    setParameterSet();
  }

  setParameterSet() {
    for (Atom atom in atoms) {
      if (atom.boil != null) {
        boilingPointsSet.add(atom.boil!.toDouble());
      }

      if (atom.melt != null) {
        meltingPointSet.add(atom.melt!.toDouble());
      }

      if (atom.electronegativityPauling != null) {
        electronNegativitySet.add(atom.electronegativityPauling!.toDouble());
      }

      if (atom.electronAffinity != null) {
        electronAffinitySet.add(atom.electronAffinity!.toDouble());
      }
    }
  }

  factory ElementListState.initial() {
    List<Atom> elements = <Atom>[];
    List<Map<String, dynamic>> json = periodicTableJson['elements'];
    for (var element in json) {
      elements.add(Atom.fromJson(element));
    }

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
