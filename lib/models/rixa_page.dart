import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rixa/models/page_base.dart';
import 'package:rixa/models/route_properties.dart';
import '../functions/functions.dart';

// ignore: must_be_immutable
class RixaPage extends PageBase {
  final String _name;
  final String _route;
  final GlobalKey<NavigatorState>? _parentNavigatorKey;
  final Widget Function(BuildContext context, RouteProperties properties)?
      _builder;
  final Map<String, String>? _params;
  final String? _title;
  final FutureOr<String?> Function(RouteProperties properties)? _redirect;
  final FutureOr<String?> Function(RouteProperties properties)?
      _redirectedChild;
  final FutureOr<String> Function(RouteProperties properties)? _description;

  String get name => _name;
  String get route => _route;
  GlobalKey<NavigatorState>? get parentNavigatorKey => _parentNavigatorKey;
  FutureOr<String> Function(RouteProperties properties)? get description =>
      _description;
  Widget Function(BuildContext context, RouteProperties properties)?
      get builder => _builder;
  Map<String, String>? get params => _params;
  String? get title => _title;

  FutureOr<String?> Function(RouteProperties properties)? get redirect =>
      _redirect;
  FutureOr<String?> Function(RouteProperties properties)? get redirectedChild =>
      _redirectedChild;

  String get fullRoute {
    return parent == null ? _route : _addParentRoute(_route, parent!);
  }

  String _addParentRoute(String route, PageBase parent) {
    String newPath = parent is RixaPage ? parent.route + route : route;
    if (parent.parent != null) {
      return newPath = _addParentRoute(newPath, parent.parent!);
    } else {
      return newPath;
    }
  }

  FutureOr<String?> redirectRoute(Map<String, String?> params, String route) {
    bool isValid = paramsConverter(path: route, params: params) ==
        paramsConverter(path: fullRoute, params: params);
    if (isValid && _redirect != null) {
      FutureOr<String?> Function(RouteProperties)? func = _redirect;
      if (func is Future<String?> Function(RouteProperties)?) {
        return func!(RouteProperties(
                route: paramsConverter(path: route, params: params),
                name: _name,
                params: _params))
            .then((value) => value);
      } else if (func is String? Function(RouteProperties)?) {
        String? path = func(RouteProperties(
            route: paramsConverter(path: route, params: params),
            name: _name,
            params: _params)) as String?;
        if (path != null) return path;
      }
    }
    if (isValid && _redirectedChild != null) {
      FutureOr<String?> Function(RouteProperties)? func = _redirectedChild;
      if (func is Future<String?> Function(RouteProperties)?) {
        return func!(RouteProperties(
                route: paramsConverter(path: route, params: params),
                name: _name,
                params: _params))
            .then((value) => value != null ? "$fullRoute$value" : null);
      } else if (func is String? Function(RouteProperties)?) {
        String? path = func(RouteProperties(
            route: paramsConverter(path: route, params: params),
            name: _name,
            params: _params)) as String?;
        if (path != null) return "$fullRoute$path";
      }
    } else {
      return null;
    }
    return null;
  }

  RixaPage({
    required String name,
    GlobalKey<NavigatorState>? parentNavigatorKey,
    String? route,
    FutureOr<String> Function(RouteProperties properties)? description,
    Widget Function(BuildContext context, RouteProperties properties)? builder,
    FutureOr<String?> Function(RouteProperties properties)? redirect,
    FutureOr<String?> Function(RouteProperties properties)? redirectedChild,
    Map<String, String>? params,
    String? title,
    super.children,
    super.screenModeLimits,
    super.fonts,
  })  : _name = name,
        _builder = builder,
        _redirect = redirect,
        _description = description,
        _parentNavigatorKey = parentNavigatorKey,
        _redirectedChild = redirectedChild,
        _params = params,
        _title = title,
        _route = route ?? "/$name" {
    for (var child in children) {
      child.setParent = this;
    }
  }
}
