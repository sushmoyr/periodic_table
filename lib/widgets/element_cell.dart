import 'package:flutter/material.dart';
import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/providers/element_list.dart';
import 'package:periodic_table/utils/constants.dart';
import 'package:periodic_table/utils/helpers.dart';
import 'package:provider/provider.dart';

enum CellType {
  outlined,
  filled,
}

enum CellFilterType {
  none,
  normal,
  boilingPoint,
  meltingPoint,
  electronNegativity,
  electronAffinity,
}

Map<CellFilterType, String> cellFilterName = {
  CellFilterType.none: "None",
  CellFilterType.normal: "Normal",
  CellFilterType.boilingPoint: "Boiling Point",
  CellFilterType.meltingPoint: "Melting Point",
  CellFilterType.electronNegativity: "Electron Negativity",
  CellFilterType.electronAffinity: "Electron Affinity",
};

class ElementCell extends StatelessWidget {
  const ElementCell({
    Key? key,
    required this.size,
    required this.atom,
    this.type = CellType.outlined,
    this.filterType = CellFilterType.none,
  }) : super(key: key);
  final Size size;
  final Atom atom;
  final CellType type;
  final CellFilterType filterType;

  @override
  Widget build(BuildContext context) {
    ElementListState elementListState = context.read<ElementList>().state;

    _convertToOpacity(
      Colors.blue,
      elementListState.minElectronAffinity,
      elementListState.maxElectronAffinity,
      atom.electronAffinity,
    );

    Color borderColor = ColorScheme.fromSeed(
      seedColor: hexToColor(atom.cpkHex),
    ).primaryContainer;

    Color? cellColor;

    switch (filterType) {
      case CellFilterType.none:
        cellColor = null;
        break;
      case CellFilterType.normal:
        cellColor = null;
        break;
      case CellFilterType.boilingPoint:
        cellColor = Colors.deepOrange.shade900.withOpacity(0.5);
        break;
      case CellFilterType.meltingPoint:
        cellColor = Colors.orange;
        break;
      case CellFilterType.electronNegativity:
        cellColor = Colors.green;
        break;
      case CellFilterType.electronAffinity:
        cellColor = Colors.blue;
        break;
    }

    bool canHaveBorder = type == CellType.outlined &&
        (filterType == CellFilterType.none ||
            filterType == CellFilterType.normal);

    return AnimatedContainer(
      duration: defaultDuration,
      decoration: BoxDecoration(
        color: cellColor,
        border: canHaveBorder
            ? Border.all(
                color: (filterType == CellFilterType.none)
                    ? elementTextBorderColor
                    : borderColor,
                width: 2,
              )
            : null,
      ),
      child: SizedBox.fromSize(
        size: size,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  atom.number.toString(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Text(
                atom.symbol!,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: canHaveBorder ? borderColor : Colors.white,
                    ),
              ),
              Text(
                atom.name!,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: canHaveBorder ? borderColor : Colors.white,
                    ),
              ),
              Text(
                atom.atomicMass!.toStringAsFixed(2),
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
      ),
    );
  }

  Color? _convertToOpacity(Color? color, double min, double max, num? value) {
    if (color != null && value != null) {
      double range = max - min;
      double offset = range * 0.1;
      double newMin = min - offset;
      double newRange = max - newMin;
      double percent = value / newRange;
      print(percent);
    }
  }
}
