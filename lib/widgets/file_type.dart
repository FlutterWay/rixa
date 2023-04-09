import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';

enum TypeOfFile { image, video, file, dicom }

class FileTypeIcon extends StatelessWidget {
  final double size;
  final TypeOfFile type;
  late final dynamic icon;
  late final int typeIndex;
  final List<Color> fileTypesColor = [
    const Color(0xFF6370fd),
    const Color(0xFFff6760),
    const Color(0xFFfdbe00),
  ];
  final List<Color> fileTypesBgColor = [
    const Color(0xFFeff0fe),
    const Color(0xFFffefee),
    const Color(0xFFe6faf3)
  ];

  FileTypeIcon({
    super.key,
    required this.type,
    required this.size,
  }) {
    double iconSize = size * 0.6;
    switch (type) {
      case TypeOfFile.image:
        typeIndex = 0;
        icon = Icon(
          Icons.image_outlined,
          size: iconSize,
          color: fileTypesColor[0],
        );
        break;
      case TypeOfFile.video:
        typeIndex = 1;
        icon = Icon(
          Boxicons.bx_movie,
          size: iconSize,
          color: fileTypesColor[1],
        );
        break;
      case TypeOfFile.file:
        typeIndex = 2;
        icon = Icon(
          Boxicons.bx_file,
          size: iconSize,
          color: fileTypesColor[2],
        );
        break;
      case TypeOfFile.dicom:
        typeIndex = 2;
        icon = Icon(
          Boxicons.bx_file,
          size: iconSize,
          color: fileTypesColor[2],
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: fileTypesBgColor[typeIndex],
          borderRadius: BorderRadius.circular(7)),
      child: Center(
        child: icon,
      ),
    );
  }
}
