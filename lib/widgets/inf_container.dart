import 'package:flutter/material.dart';

class InfContainer extends StatelessWidget {
  final Widget? child;
  final Alignment alignment;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? foregroundDecoration;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  const InfContainer(
      {super.key,
      required this.child,
      this.alignment = Alignment.center,
      this.decoration,
      this.padding,
      this.color,
      this.foregroundDecoration,
      this.constraints,
      this.margin,
      this.transform,
      this.transformAlignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      decoration: decoration,
      width: double.infinity,
      height: double.infinity,
      padding: padding,
      color: color,
      foregroundDecoration: foregroundDecoration,
      constraints: constraints,
      margin: margin,
      transform: transform,
      transformAlignment: transformAlignment,
      child: child,
    );
  }
}
