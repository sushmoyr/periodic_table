import 'package:flutter/material.dart';

buildPage({
  required Widget page,
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
}) {
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) {
      const begin = Offset.zero;
      const end = Offset(0.2, 0);
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return page;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
      ;
    },
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    reverseTransitionDuration:
        reverseTransitionDuration ?? const Duration(milliseconds: 300),
  );
}

Color hexToColor(String? code) {
  if (code == null) {
    return Colors.black;
  }
  return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
}
