import 'package:flutter/material.dart';
import 'package:periodic_table/utils/constants.dart';

enum SliverCardType {
  filled,
  outlined,
}

class SliverCard extends StatelessWidget {
  const SliverCard({
    Key? key,
    this.type = SliverCardType.filled,
    this.cornerRadius = 0,
    this.fillColor,
    required this.child,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final SliverCardType type;
  final double cornerRadius;
  final Color? fillColor;
  final Widget child;
  final Alignment alignment;

  factory SliverCard.outlined({
    Key? key,
    double cornerRadius = 0,
    Color? fillColor,
    required Widget child,
  }) {
    return SliverCard(
      key: key,
      type: SliverCardType.outlined,
      cornerRadius: cornerRadius,
      fillColor: fillColor,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: alignment,
        child: Container(
          decoration: BoxDecoration(
            border: (type == SliverCardType.outlined)
                ? Border.all(color: elementTextBorderColor)
                : null,
            color: fillColor ?? Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
