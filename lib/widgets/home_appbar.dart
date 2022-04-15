import 'package:flutter/material.dart';
import 'package:periodic_table/utils/constants.dart';
import 'package:periodic_table/widgets/element_text.dart';
import 'package:periodic_table/widgets/fade_in_slider.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    Key? key,
    required this.title,
    this.subtitle,
    this.style,
    this.designTitle = false,
    this.designSubtitle = true,
    this.letterSpacing = 4,
    this.action,
    this.onActionClicked,
    this.animationDuration,
    this.padding,
  }) : super(key: key);
  final String title;
  final String? subtitle;
  final TextStyle? style;
  final bool designTitle;
  final bool designSubtitle;
  final double letterSpacing;
  final Widget? action;
  final VoidCallback? onActionClicked;
  final Duration? animationDuration;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(
            top: 16,
            bottom: 8,
            left: 16,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FadeInSlider(
                  child: selectWidget(designTitle, title),
                  duration: animationDuration,
                  curve: const Interval(
                    0,
                    0.8,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                const SizedBox(height: 8),
                if (subtitle != null)
                  FadeInSlider(
                    child: selectWidget(designSubtitle, subtitle!),
                    duration: animationDuration,
                    curve: const Interval(
                      0.6,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
              ],
            ),
          ),
          if (action != null)
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 8),
              child: InkWell(
                child: action,
                onTap: onActionClicked,
              ),
            ),
        ],
      ),
    );
  }

  selectWidget(bool condition, String text) {
    return condition
        ? ElementText(
            text: text,
            style: style,
            letterSpacing: 4,
          )
        : Text(
            text,
            style: style,
          );
  }
}
/*

class HomeAppbarDelegate extends SliverPersistentHeaderDelegate {
  final double toolbarHeight;


  HomeAppbarDelegate({
    required this.title,
    this.subtitle,
    this.designTitle = false,
    this.designSubtitle = true,
    this.style,
    required this.toolbarHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(toolbarHeight.ceilToDouble());

    return
  }



  @override
  double get minExtent => toolbarHeight.ceilToDouble();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => toolbarHeight.ceilToDouble();
}
*/
