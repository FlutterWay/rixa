import 'package:get/get.dart';
import '../states/app_colors.dart';
import 'package:flutter/material.dart';

import 'checkbox_list.dart';

class CheckBoxSingle extends StatefulWidget {
  final CheckBoxItem item;
  final void Function(bool value) onChanged;
  final Color? unselectedColor, selectedColor;
  CheckBoxSingle({
    super.key,
    required this.item,
    required this.onChanged,
    Color? unselectedColor,
    Color? selectedColor,
  })  : unselectedColor = unselectedColor ?? Get.find<AppColors>().textColor,
        selectedColor = selectedColor ?? const Color(0xFF6200EE);
  @override
  State<CheckBoxSingle> createState() => _CheckBoxSingleState();
}

class _CheckBoxSingleState extends State<CheckBoxSingle> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onChanged(widget.item.isSelected);
        setState(() {
          widget.item.isSelected = !widget.item.isSelected;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: widget.unselectedColor),
            child: Checkbox(
              onChanged: (bool? value) {
                widget.onChanged(widget.item.isSelected);
                setState(() {
                  widget.item.isSelected = value!;
                });
              },
              value: widget.item.isSelected,
              activeColor: widget.selectedColor,
            ),
          ),
          widget.item.child
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
