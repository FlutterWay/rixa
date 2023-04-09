import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../states/page_manager.dart';

extension PageContext on BuildContext {
  Future<void> go(
      {required String route,
      dynamic Function()? quickDispose,
      dynamic item}) async {
    await Get.find<PageManager>().go(
        route: route, item: item, quickDispose: quickDispose, context: this);
  }

  Future<void> back({dynamic Function()? quickDispose}) async {
    await Get.find<PageManager>()
        .back(context: this, quickDispose: quickDispose);
  }

  Future<void> goNamed(
      {required String name,
      dynamic Function()? quickDispose,
      dynamic item}) async {
    await Get.find<PageManager>().goNamed(
        name: name, item: item, quickDispose: quickDispose, context: this);
  }
}
