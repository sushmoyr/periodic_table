import 'package:flutter/material.dart';
import 'package:periodic_table/utils/constants.dart';
import 'package:periodic_table/widgets/element_text.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  final String title, subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: elevatedSurfaceColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        splashColor: surfaceColor,
        splashFactory: InkRipple.splashFactory,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ElementText(
                text: title,
                style: headerText,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: ElementText(
                  text: subtitle,
                  style: headerText,
                ),
              ),
              const Spacer(),
              const Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.lightBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
