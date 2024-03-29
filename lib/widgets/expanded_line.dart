import 'package:flutter/material.dart';

class ExpandedLine extends StatelessWidget {
  final double width, height;
  final bool isVertical;
  final Color? color;
  const ExpandedLine(
      {Key? key,
      this.width = 1,
      this.height = 1,
      this.isVertical = false,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isVertical ? width : double.infinity,
      height: isVertical ? double.infinity : height,
      color: color,
    );
  }
}
