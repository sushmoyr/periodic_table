import 'dart:math';

import 'package:flutter/material.dart';
import 'package:periodic_table/utils/constants.dart';

enum FadeInSliderDirection {
  fromTop,
  fromBottom,
  fromLeft,
  fromRight,
}

class FadeInSlider extends StatefulWidget {
  const FadeInSlider({
    Key? key,
    this.duration,
    this.delay,
    this.curve,
    required this.child,
    this.direction = FadeInSliderDirection.fromLeft,
    this.slideOffset,
  }) : super(key: key);

  final Duration? duration;
  final Duration? delay;
  final Curve? curve;
  final Widget child;
  final FadeInSliderDirection direction;
  final Offset? slideOffset;

  @override
  _FadeInSliderState createState() => _FadeInSliderState();
}

class _FadeInSliderState extends State<FadeInSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: widget.duration ?? defaultDuration);

    _initAnimation();

    super.initState();
  }

  void _initAnimation() async {
    var curveAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve ?? Curves.fastOutSlowIn,
    );

    var fadeCurveAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.4, 1, curve: widget.curve ?? Curves.fastOutSlowIn),
    );

    Tween<Offset> slideTween = Tween(
      begin: widget.slideOffset ?? Offset.fromDirection(_getDirection()),
      end: Offset.zero,
    );
    slideAnimation = slideTween.animate(curveAnimation);

    Tween<double> fadeTween = Tween(begin: 0, end: 1);
    fadeAnimation = fadeTween.animate(fadeCurveAnimation);

    await Future.delayed(widget.delay ?? Duration.zero);
    _controller.forward();
  }

  double _getDirection() {
    switch (widget.direction) {
      case FadeInSliderDirection.fromRight:
        return 0;
      case FadeInSliderDirection.fromBottom:
        return pi / 2;
      case FadeInSliderDirection.fromLeft:
        return pi;
      case FadeInSliderDirection.fromTop:
        return (pi * 3) / 2;
      default:
        return pi;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: widget.child,
      ),
    );
  }
}
