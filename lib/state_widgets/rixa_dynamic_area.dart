import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../states/page_manager.dart';

class RixaDynamicArea extends StatelessWidget {
  const RixaDynamicArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Get.find<PageManager>().page;
  }
}
