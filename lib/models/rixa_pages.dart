import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rixa/models/screen_mode_limits.dart';

class RixaPage {
  String name;
  ScreenModeLimits? screenModeLimits;
  late String route;
  Widget Function() page;
  List<String>? redirectFrom;
  Map<String, String>? params;
  String? redirect, title;
  String? Function(String route)? checkRedirect;
  List<ChildPage>? children;
  RixaPage(
      {required this.name,
      String? route,
      required this.page,
      this.checkRedirect,
      this.redirect,
      this.screenModeLimits,
      this.title,
      this.children,
      this.redirectFrom}) {
    if (route == null) {
      this.route = "/" + name;
    } else {
      this.route = route;
    }
  }
}

class ChildPage {
  String name;
  String route;
  Map<String, String>? params;

  List<dynamic>? _fathers;
  ChildPage? _forward;
  ChildPage? _behind;
  List<ChildPage>? children;
  String? redirect, title, _fullRoute;
  String? Function()? checkRedirect;
  Widget? childPage;

  get fullRoute => _fullRoute;
  get fathers => _fathers;
  get forward => _forward;
  get behind => _behind;

  set setFullRoute(String route) {
    _fullRoute = route;
  }

  set setFathers(List<dynamic> fathers) {
    _fathers = fathers;
  }

  set setForward(ChildPage forward) {
    _forward = forward;
  }

  set setBehind(ChildPage behind) {
    _behind = behind;
  }

  ChildPage(
      {required this.route,
      required this.name,
      this.redirect,
      this.children,
      this.checkRedirect,
      this.title,
      this.childPage});
}
