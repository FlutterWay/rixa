import 'package:flutter/material.dart';

void Function() updateState(State state) {
  return () {
    // ignore: invalid_use_of_protected_member
    if (state.mounted) state.setState(() {});
  };
}

String paramsConverter(
    {required String path, required Map<String, String?> params}) {
  List<String> paths = path
      .split("/")
      .where((element) => element != "" && element[0] == ":")
      .toList();
  for (var param in paths) {
    path =
        path.replaceFirst(param, params[param.replaceFirst(":", "")] ?? param);
  }
  return path;
}

String getShortOfName(String name) {
  name = name.trim();
  List<String> names = name.split(" ");
  String shortForm = "";
  shortForm += names.first[0].toUpperCase();
  if (names.length > 1) shortForm += names.last[0].toUpperCase();
  return shortForm;
}
