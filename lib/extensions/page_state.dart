import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../states/page_manager.dart';

extension PageContext on BuildContext {
  Future<void> go(
      {required String route,
      dynamic Function()? quickDispose,
      Map<String, dynamic>? item}) async {
    await Get.find<PageManager>().go(
        route: route, item: item, quickDispose: quickDispose, context: this);
  }

  Future<void> goNamed(
      {required String name,
      dynamic Function()? quickDispose,
      Map<String, dynamic>? item}) async {
    await Get.find<PageManager>().goNamed(
        name: name, item: item, quickDispose: quickDispose, context: this);
  }

  Future<void> push({
    required String route,
    Map<String, dynamic>? item,
    dynamic Function()? onPop,
  }) async {
    await Get.find<PageManager>()
        .push(route: route, item: item, context: this, onPop: onPop);
  }

  Future<void> pushNamed({
    required String name,
    Map<String, dynamic>? item,
    dynamic Function()? onPop,
  }) async {
    await Get.find<PageManager>()
        .pushNamed(name: name, item: item, context: this, onPop: onPop);
  }

  void pushReplacement({required String route, Map<String, dynamic>? item}) {
    Get.find<PageManager>()
        .pushReplacement(route: route, item: item, context: this);
  }

  void pushReplacementNamed(
      {required String name, Map<String, dynamic>? item}) {
    Get.find<PageManager>()
        .pushReplacementNamed(name: name, item: item, context: this);
  }

  Future<bool> goToPreviousPage(
      {dynamic Function()? quickDispose, Map<String, dynamic>? item}) async {
    return (await Get.find<PageManager>().goToPreviousPage(
        context: this, quickDispose: quickDispose, item: item));
  }

  void pop() async {
    Get.find<PageManager>().pop(this);
  }

  bool canPop() {
    return Get.find<PageManager>().canPop(this);
  }
}
