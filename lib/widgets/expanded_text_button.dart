import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../states/app_fonts.dart';
import 'expanded_button.dart';

class ExpandedTextButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Alignment alignment;
  final dynamic Function() onPressed;
  final int flex;
  ExpandedTextButton(this.text,
      {super.key,
      TextStyle? style,
      this.alignment = Alignment.centerLeft,
      this.flex = 1,
      required this.onPressed})
      : style = style ?? Get.find<AppFonts>().S();

  @override
  Widget build(BuildContext context) {
    return ExpandedButton(
        onPressed: onPressed,
        flex: flex,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: alignment,
          child: Text(
            text,
            style: style,
          ),
        ));
  }
}
