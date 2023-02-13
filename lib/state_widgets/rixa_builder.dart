import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../rixa.dart';

class RixaBuilder extends StatelessWidget {
  final Widget Function(RixaProperties properties, BuildContext context)
      builder;
  const RixaBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppSettings>(
      builder: (controller) {
        return builder(Rixa.properties, context);
      },
    );
  }
}
