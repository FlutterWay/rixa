import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';

class LinkConfig {
  final TextStyle textStyle;
  final void Function(String)? onTap;
  LinkConfig({TextStyle? textStyle, this.onTap})
      : textStyle = textStyle ??
            Rixa.appFonts.small3(decoration: TextDecoration.underline);
}
