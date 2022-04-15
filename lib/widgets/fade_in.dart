import 'package:flutter/material.dart';
import 'package:periodic_table/utils/constants.dart';

class FadeIn extends StatefulWidget {
  const FadeIn(
      {Key? key, this.duration, this.delay, this.curve, required this.child})
      : super(key: key);

  final Duration? duration;
  final Duration? delay;
  final Curve? curve;
  final Widget child;

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: widget.duration ?? defaultDuration);

    _initAnimation();

    super.initState();
  }

  void _initAnimation() async {
    var fadeCurveAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve ?? Curves.fastOutSlowIn,
    );

    Tween<double> fadeTween = Tween(begin: 0, end: 1);
    fadeAnimation = fadeTween.animate(fadeCurveAnimation);

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
    return FadeTransition(
      opacity: fadeAnimation,
      child: widget.child,
    );
  }
}
