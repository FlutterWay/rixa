import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';

class TextConfig {
  final TextStyle p, h1, h2, h3, h4, h5, h6;

  TextConfig({
    TextStyle? p,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? h5,
    TextStyle? h6,
  })  : p = p ?? Rixa.appFonts.small3(),
        h1 = h1 ?? Rixa.appFonts.small9(),
        h2 = h2 ?? Rixa.appFonts.small8(),
        h3 = h3 ?? Rixa.appFonts.small7(),
        h4 = h4 ?? Rixa.appFonts.small6(),
        h5 = h5 ?? Rixa.appFonts.small5(),
        h6 = h6 ?? Rixa.appFonts.small4();
}
