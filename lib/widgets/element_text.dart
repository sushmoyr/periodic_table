import 'package:flutter/material.dart';
import 'package:periodic_table/utils/constants.dart';

class ElementText extends StatelessWidget {
  const ElementText({
    Key? key,
    required this.text,
    this.style,
    this.boxPadding = 4,
    this.letterSpacing = 0,
    this.borderColor,
  }) : super(key: key);
  final String text;
  final double boxPadding;
  final double letterSpacing;
  final TextStyle? style;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    String first = text.characters.first;
    String rest = text.substring(1);
    return [
      _getElementLetter(first),
      SizedBox(width: letterSpacing),
      Text(
        rest,
        style: style,
      )
    ];
  }

  _getElementLetter(String letter) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? elementTextBorderColor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: boxPadding + 2, vertical: boxPadding),
        child: Text(
          letter.toUpperCase(),
          style: style?.copyWith(
            height: 1,
            color: borderColor ?? elementTextBorderColor,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
