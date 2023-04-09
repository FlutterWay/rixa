import 'package:flutter/material.dart';
import 'package:rixa/models/page_base.dart';
import '../rixa.dart';
import 'route_properties.dart';

// ignore: must_be_immutable
class NestedPage extends PageBase {
  @override
  final List<RixaPage> children;
  final Widget Function(
      BuildContext context, RouteProperties properties, Widget child) builder;

  NestedPage(
      {super.screenModeLimits,
      this.children = const <RixaPage>[],
      super.fonts,
      required this.builder}) {
    for (var child in children) {
      child.setParent = this;
    }
  }
}
