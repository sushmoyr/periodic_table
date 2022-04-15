import 'dart:math';

import 'package:flutter/material.dart';
import 'package:periodic_table/utils/constants.dart';

class ScaleIn extends StatefulWidget {
  const ScaleIn(
      {Key? key, this.duration, this.delay, this.curve, required this.child})
      : super(key: key);

  final Duration? duration;
  final Duration? delay;
  final Curve? curve;
  final Widget child;

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<ScaleIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: widget.duration ?? defaultDuration);

    _initAnimation();

    super.initState();
  }

  void _initAnimation() async {
    double random = Random().nextDouble().clamp(0, 0.5);
    var scaleCurveAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        random,
        1,
        curve: widget.curve ?? Curves.fastOutSlowIn,
      ),
    );

    Tween<double> fadeTween = Tween(begin: 0, end: 1);
    scaleAnimation = fadeTween.animate(scaleCurveAnimation);

    await Future.delayed(widget.delay ?? Duration.zero);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: widget.child,
    );
  }
}
