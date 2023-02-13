import 'package:flutter/material.dart';

import '../models/rixa_pages.dart';

void Function() updateState(State state) {
  return () {
    // ignore: invalid_use_of_protected_member
    if (state.mounted) state.setState(() {});
  };
}

String paramsConverter(
    {required String path, required Map<String, String> params}) {
  List<String> paths = path
      .split("/")
      .where((element) => element != "" && element[0] == ":")
      .toList();
  for (var param in paths) {
    path = path.replaceFirst(param, params[param.replaceFirst(":", "")]!);
  }
  return path;
}

void setParentsPath(
    {required ChildPage child, required Map<String, String> params}) {
  for (var parent in child.fathers) {
    parent.route = paramsConverter(path: parent.route, params: params);
  }
}


