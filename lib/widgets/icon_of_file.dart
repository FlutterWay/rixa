import 'package:get/get.dart';
import 'package:rixa/rixa.dart';
import 'package:flutter/material.dart';

class IconOfFile extends StatelessWidget {
  late final dynamic icon;

  IconOfFile(
    TypeOfFile type, {
    super.key,
    double? size,
    dynamic color,
  }) {
    IconData? iconData;
    size ??= Get.find<AppFonts>().icon_S();
    color ??= Get.find<AppColors>().textColor;
    if (type == TypeOfFile.image) {
      iconData = Icons.image_outlined;
    } else if (type == TypeOfFile.video) {
      iconData = Icons.movie_outlined;
    } else if (type == TypeOfFile.file) {
      iconData = Icons.file_present_outlined;
    }
    if (type != TypeOfFile.dicom) {
      icon = Icon(
        iconData!,
        size: size,
        color: color,
      );
    } else {
      icon = Image(
        image: const AssetImage("assets/images/dicom.png"),
        width: size,
        height: size,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return icon;
  }
}
