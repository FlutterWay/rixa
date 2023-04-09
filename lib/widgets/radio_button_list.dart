import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rixa/rixa.dart';

class RadioButtonList extends StatefulWidget {
  final List<RadioButtonItem> items;
  final dynamic Function(dynamic value)? onChanged;
  final String? title;
  final bool isVertical;
  final bool isExpanded;
  final int flex;
  final TextStyle? textStyle;
  final Color? activeColor, focusColor, hoverColor, unselectedColor;
  final MaterialStateProperty<Color?>? fillColor, overlayColor;

  RadioButtonList(this.items,
      {super.key,
      this.onChanged,
      this.title,
      this.isVertical = false,
      this.isExpanded = false,
      this.activeColor,
      this.fillColor,
      this.focusColor,
      this.hoverColor,
      this.overlayColor,
      TextStyle? textStyle,
      this.flex = 1,
      this.unselectedColor})
      : textStyle = textStyle ?? Get.find<AppFonts>().S();
  @override
  State<RadioButtonList> createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {
  dynamic groupValue;
  @override
  Widget build(BuildContext context) {
    return widget.isExpanded == true
        ? Expanded(flex: widget.flex, child: getRadioButtons())
        : getRadioButtons();
  }

  Widget getRadioButtons() {
    return widget.isVertical == true
        ? Column(
            children: radioButtons(),
          )
        : Row(
            children: radioButtons(),
          );
  }

  List<Widget> radioButtons() {
    List<Widget> radios = [];
    if (widget.title != null) {
      radios.add(Text(
        "${widget.title!} : ",
        style: widget.textStyle,
      ));
    }
    for (int i = 0; i < widget.items.length; i++) {
      radios.add(radioItem(i));
    }
    return radios;
  }

  Widget radioItem(int index) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: widget.unselectedColor),
      child: Row(
        children: [
          Radio(
            value: widget.items[index].value,
            groupValue: groupValue,
            activeColor: widget.activeColor,
            fillColor: widget.fillColor,
            focusColor: widget.focusColor,
            hoverColor: widget.hoverColor,
            overlayColor: widget.overlayColor,
            onChanged: (dynamic value) {
              setState(() {
                groupValue = value!;
              });
              if (widget.onChanged != null) widget.onChanged!(value);
            },
          ),
          Text(
            widget.items[index].text,
            style: widget.textStyle,
          )
        ],
      ),
    );
  }
}

class RadioButtonItem {
  String text;
  dynamic value;
  bool isSelected = false;
  RadioButtonItem({required this.text, required this.value});
}
