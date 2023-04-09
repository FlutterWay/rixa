import 'package:get/get.dart';

import '../states/app_fonts.dart';
import 'package:flutter/material.dart';

class ExpandedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Alignment alignment;
  final int flex;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final Decoration? decoration;
  final EdgeInsetsGeometry textPadding;
  ExpandedText(this.text,
      {super.key,
      TextStyle? style,
      this.alignment = Alignment.centerLeft,
      this.flex = 1,
      this.backgroundColor,
      this.decoration,
      this.padding = EdgeInsets.zero,
      this.textPadding = EdgeInsets.zero})
      : style = style ?? Get.find<AppFonts>().S();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Padding(
          padding: padding,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: decoration,
            color: backgroundColor,
            alignment: alignment,
            child: Padding(
              padding: textPadding,
              child: Text(
                text,
                style: style,
              ),
            ),
          ),
        ));
  }
}
