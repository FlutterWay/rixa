import 'package:flutter/material.dart';

class MiddleOfExpanded extends StatelessWidget {
  final Widget child;
  final int flex;
  final int childFlex;
  final Axis scrollDirection;
  const MiddleOfExpanded(
      {Key? key,
      required this.child,
      this.flex = 1,
      this.childFlex = 1,
      this.scrollDirection = Axis.horizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: scrollDirection == Axis.horizontal
          ? Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  flex: childFlex,
                  child: child,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            )
          : Column(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  flex: childFlex,
                  child: child,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
    );
  }
}
