import 'inf_container.dart';
import 'package:flutter/material.dart';

class ExpandedContainer extends StatelessWidget {
  final Widget child;
  final int flex;
  final Alignment alignment;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry padding, innerPadding;
  const ExpandedContainer(
      {super.key,
      required this.child,
      this.alignment = Alignment.center,
      this.flex = 1,
      this.padding = EdgeInsets.zero,
      this.innerPadding = EdgeInsets.zero,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Padding(
          padding: padding,
          child: InfContainer(
            decoration: decoration,
            alignment: alignment,
            padding: innerPadding,
            child: child,
          ),
        ));
  }
}
