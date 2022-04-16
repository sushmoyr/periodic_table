import 'package:flutter/material.dart';

enum PageTransitionType {
  slide,
  fade,
}

buildPage({
  required Widget page,
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
  PageTransitionType type = PageTransitionType.slide,
}) {
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) {
      return page;
    },
    transitionsBuilder: type == PageTransitionType.slide
        ? _slideTransitionBuilder
        : _fadeTransitionBuilder,
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    reverseTransitionDuration:
        reverseTransitionDuration ?? const Duration(milliseconds: 300),
  );
}

Widget _slideTransitionBuilder(context, animation, secondaryAnimation, child) {
  const begin = Offset(1, 0);
  const end = Offset.zero;
  final tween = Tween(begin: begin, end: end);
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

Widget _fadeTransitionBuilder(context, animation, secondaryAnimation, child) {
  const begin = 0.0;
  const end = 1.0;
  final tween = Tween(begin: begin, end: end);
  final offsetAnimation = animation.drive(tween);

  return FadeTransition(
    opacity: offsetAnimation,
    child: child,
  );
}

Color hexToColor(String? code) {
  if (code == null) {
    return Colors.black;
  }
  return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
}

Color hexToM3Color(String? code) {
  return ColorScheme.fromSeed(
    seedColor: hexToColor(code),
  ).primaryContainer;
}

extension StringExtension on String {
  String toUpperCaseFirst() {
    String s = this;
    return (s[0].toUpperCase() + s.substring(1)).replaceAll('-', ' ');
  }
}
