import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final Widget? child;
  final double radius;
  final double borderWith;
  final Color? borderColor;
  final Color? color;
  final Alignment alignment;
  final Function() onPressed;
  final int flex;
  final bool isCircle;
  final EdgeInsetsGeometry padding;
  const ExpandedButton(
      {super.key,
      this.child,
      this.radius = 10,
      this.alignment = Alignment.center,
      this.flex = 1,
      this.borderColor,
      this.color,
      this.isCircle = false,
      this.borderWith = 1,
      this.padding = EdgeInsets.zero,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    BoxBorder? border = borderColor != null
        ? Border.all(width: borderWith, color: borderColor!)
        : null;
    BoxDecoration decoration = isCircle
        ? BoxDecoration(color: color, shape: BoxShape.circle, border: border)
        : BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: color,
            border: border);
    return Expanded(
      flex: flex,
      child: Padding(
        padding: padding,
        child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: onPressed,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: alignment,
            decoration: decoration,
            child: child,
          ),
        ),
      ),
    );
  }
}
