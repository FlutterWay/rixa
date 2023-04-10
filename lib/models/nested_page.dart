import 'package:flutter/material.dart';
import 'package:rixa/models/page_base.dart';
import '../rixa.dart';
import 'route_properties.dart';

// ignore: must_be_immutable
class NestedPage extends PageBase {
  @override
  final List<RixaPage> children;
  final GlobalKey<NavigatorState>? _navigatorKey;
  final Widget Function(
      BuildContext context, RouteProperties properties, Widget child) builder;

  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  NestedPage(
      {super.screenModeLimits,
      this.children = const <RixaPage>[],
      GlobalKey<NavigatorState>? navigatorKey,
      super.fonts,
      required this.builder})
      : _navigatorKey = navigatorKey {
    for (var child in children) {
      child.setParent = this;
    }
  }
}
