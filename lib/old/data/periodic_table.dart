import 'elements.dart';

class PeriodicTable {
  List<Atom>? elements;

  PeriodicTable({this.elements});

  PeriodicTable.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = <Atom>[];
      json['elements'].forEach((v) {
        elements!.add(Atom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (elements != null) {
      data['elements'] = elements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
