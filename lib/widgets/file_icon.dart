import 'package:flutter/material.dart';
import 'package:rixa/variables/time_variables.dart';

class FileIcon extends StatelessWidget {
  final String extension;
  final double size;
  final List<Color> fileTypesColor = [
    const Color(0xFF6370fd),
    const Color(0xFFff6760),
    const Color(0xFFfdbe00),
  ];
  late final int typeIndex;
  FileIcon({
    super.key,
    required this.extension,
    required this.size,
  }) {
    if (TimeVariables.imgExt
        .any((element) => element.toUpperCase() == extension.toUpperCase())) {
      typeIndex = 0;
    } else if (TimeVariables.vidExt
        .any((element) => element.toUpperCase() == extension.toUpperCase())) {
      typeIndex = 1;
    } else {
      typeIndex = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: fileTypesColor[typeIndex],
          borderRadius: BorderRadius.circular(7)),
      child: Center(
        child: Text(
          extension.toUpperCase(),
          style: TextStyle(
              color: Colors.white,
              fontSize: size / 3.5,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
