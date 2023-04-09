import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';

class CodeConfig {
  final EdgeInsetsGeometry padding;
  final Decoration? decoration;
  final EdgeInsetsGeometry margin;
  final TextStyle textStyle;
  final Widget Function(Widget, String)? wrapper;
  final String language;

  CodeConfig({
    this.padding = const EdgeInsets.all(16.0),
    this.decoration,
    this.margin = const EdgeInsets.symmetric(vertical: 8.0),
    TextStyle? textStyle,
    this.language = 'dart',
    this.wrapper,
  }) : textStyle =
            textStyle ?? TextStyle(fontSize: Rixa.appFonts.small3().fontSize);
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
