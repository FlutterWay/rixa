import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/rixa_fonts.dart';
import '../rixa.dart';

class RixaBuilder extends StatelessWidget {
  final String? name;
  final Widget Function(RixaProperties properties, RixaFonts fonts) builder;
  const RixaBuilder({Key? key, this.name, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppSettings>(
      builder: (controller) {
        return builder(Rixa.properties, RixaFonts(name));
      },
    );
  }
}
