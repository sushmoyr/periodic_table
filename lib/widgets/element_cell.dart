import 'package:flutter/material.dart';
import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/utils/constants.dart';

enum CellType {
  outlined,
  filled,
}

class ElementCell extends StatelessWidget {
  const ElementCell({
    Key? key,
    required this.size,
    required this.atom,
    this.type = CellType.outlined,
  }) : super(key: key);
  final Size size;
  final Atom atom;
  final CellType type;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: type == CellType.filled ? elementTextBorderColor : null,
        border: type == CellType.outlined
            ? Border.all(color: elementTextBorderColor)
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
                    color: type == CellType.outlined
                        ? elementTextBorderColor
                        : Colors.black),
              ),
              Text(
                atom.name!,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: type == CellType.outlined
                        ? elementTextBorderColor
                        : Colors.black),
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
}
