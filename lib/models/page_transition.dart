import 'package:flutter/material.dart';

class PageTransition {
  final Widget Function(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child)? transitionsBuilder;
  final Duration transitionDuration;
  final Duration reverseTransitionDuration;

  PageTransition(
      {required this.transitionsBuilder,
      this.transitionDuration = const Duration(milliseconds: 300),
      this.reverseTransitionDuration = const Duration(milliseconds: 300)});
}
