import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../states/page_manager.dart';

extension PageContext on BuildContext {
  Future<void> go({required String route, dynamic item}) async {
    await Get.find<PageManager>().go(route: route, item: item, context: this);
  }

  Future<void> goNamed({required String name, dynamic item}) async {
    await Get.find<PageManager>().goNamed(name: name, item: item, context: this);
  }
}
