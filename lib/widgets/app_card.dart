import 'package:flutter/material.dart';
import 'package:periodic_table/utils/constants.dart';

enum AppCardType {
  filled,
  outlined,
}

class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    this.type = AppCardType.filled,
    this.cornerRadius = 0,
    this.fillColor,
    required this.child,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final AppCardType type;
  final double cornerRadius;
  final Color? fillColor;
  final Widget child;
  final Alignment alignment;

  factory AppCard.outlined({
    Key? key,
    double cornerRadius = 0,
    Color? fillColor,
    required Widget child,
  }) {
    return AppCard(
      key: key,
      type: AppCardType.outlined,
      cornerRadius: cornerRadius,
      fillColor: fillColor,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        decoration: BoxDecoration(
          border: (type == AppCardType.outlined)
              ? Border.all(color: elementTextBorderColor)
              : null,
          color: fillColor ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        child: child,
      ),
    );
  }
}
