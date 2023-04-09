import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class OnHover extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  final bool doTransform;
  const OnHover({
    super.key,
    required this.builder,
    this.doTransform = true,
  });
  @override
  State<OnHover> createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {
  bool isHovered = false;
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    final hovered = Matrix4Transform().translate(x: 5).matrix4;
    Matrix4? transform;
    if (widget.doTransform) {
      if (isHovered) transform = hovered;
      if (!isHovered || isFinished) transform = Matrix4.identity();
    }
    return MouseRegion(
      onEnter: (_) => onEntered(true),
      onExit: (_) => onEntered(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: widget.doTransform ? transform : Matrix4.identity(),
        onEnd: () {
          setState(() {
            isFinished = true;
          });
        },
        child:
            widget.builder(isHovered), // build the widget passed from main.dart
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  //used to set bool isHovered to true/false
  void onEntered(bool isHovered) {
    setState(() {
      if (isHovered == true) isFinished = false;
      this.isHovered = isHovered;
    });
  }
}
