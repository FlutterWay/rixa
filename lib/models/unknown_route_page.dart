import 'dart:async';

import 'package:flutter/material.dart';

import 'page_transition.dart';
import 'route_properties.dart';

class UnknownRoutePage {
  final Widget pageView;
  final PageTransition? pageTransition;
  final FutureOr<String> Function(RouteProperties properties)? description;

  UnknownRoutePage(
      {required this.pageView, this.pageTransition, this.description});
}
