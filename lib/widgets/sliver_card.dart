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
  }) : super(key: key);

  final SliverCardType type;
  final double cornerRadius;
  final Color? fillColor;
  final Widget child;

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
      child: Card(
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          side: (type == SliverCardType.outlined)
              ? const BorderSide(color: elementTextBorderColor)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        color: fillColor,
        child: child,
      ),
    );
  }
}
