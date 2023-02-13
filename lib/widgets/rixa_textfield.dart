import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rixa/rixa.dart';

class RixaTextField extends StatelessWidget {
  String hintText;
  String? labelText;
  TextEditingController controller;
  TextStyle? textStyle, labelStyle;
  TextStyle? hintStyle;
  double radius, borderWidth;
  int maxLines;
  int? minLines;
  Color? color, borderColor;
  Color? enabledColor;
  double? width;
  Color? focusedColor, backgroundColor;
  dynamic onChanged;
  bool isUnderline, expands, noBorder;
  TextInputType textInputType;
  Widget? prefixIcon;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? innerPadding;
  RixaTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.minLines,
    this.textStyle,
    this.hintStyle,
    this.color,
    this.borderColor,
    this.borderWidth = 1,
    this.radius = 10.0,
    this.onChanged,
    this.enabledColor,
    this.focusedColor,
    this.labelText,
    this.width,
    this.labelStyle,
    this.isUnderline = true,
    this.expands = false,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
    this.innerPadding,
    this.noBorder = false,
  }) : super(key: key) {
    innerPadding ??= EdgeInsets.symmetric(horizontal: 10);
    textStyle ??= Get.find<AppFonts>().M();
    labelStyle ??= Get.find<AppFonts>().M();
    hintStyle ??=
        Get.find<AppFonts>().M(color: Get.find<AppColors>().hintColor);
    enabledColor ??= Get.find<AppColors>().textColor;
    focusedColor ??= Colors.cyan;
    if (!noBorder) {
      if (isUnderline) {
        enabledBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: enabledColor!),
        );
        focusedBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: focusedColor!),
        );
      } else {
        enabledBorder = OutlineInputBorder(
            borderSide: BorderSide(color: enabledColor!),
            borderRadius: BorderRadius.circular(radius));
        focusedBorder = OutlineInputBorder(
            borderSide: BorderSide(color: focusedColor!),
            borderRadius: BorderRadius.circular(radius));
      }
    }
    border = borderColor != null
        ? Border.all(width: borderWidth, color: borderColor!)
        : null;
  }
  dynamic enabledBorder, focusedBorder;
  BoxBorder? border;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: border),
      padding: padding,
      child: TextField(
        controller: controller,
        maxLines: !expands ? maxLines : null,
        minLines: minLines,
        expands: expands,
        style: textStyle,
        scrollPadding: EdgeInsets.zero,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: expands ? TextInputType.multiline : textInputType,
        inputFormatters: <TextInputFormatter>[
          if (textInputType == TextInputType.number)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: innerPadding,
            hintStyle: hintStyle,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
            border: noBorder ? InputBorder.none : null,
            prefixIcon: prefixIcon,
            labelText: labelText,
            labelStyle: labelStyle),
        onChanged: (text) {
          if (onChanged != null) onChanged(text);
        },
      ),
    );
  }
}

class RixaTextFieldFull extends StatelessWidget {
  String hintText;
  String? labelText;
  int flex;
  TextEditingController controller;
  TextStyle? textStyle, labelStyle;
  double? width;
  TextStyle? titleStyle, hintStyle, errorStyle;
  double radius, borderWidth;
  Color? color, borderColor;
  Color? enabledColor;
  Color? focusedColor, backgroundColor;
  dynamic onChanged;
  int maxLines;
  int? minLines;
  bool isUnderline, noBorder, expands;
  TextInputType textInputType;
  Widget? prefixIcon;
  EdgeInsetsGeometry? padding, innerPadding;
  String? errorText;
  double paddingLeft;
  bool error;
  RixaTextFieldFull({
    required this.controller,
    this.hintText = "",
    this.labelText,
    this.flex = 1,
    this.textStyle,
    this.labelStyle,
    this.expands = false,
    this.maxLines = 1,
    this.titleStyle,
    this.hintStyle,
    this.radius = 10,
    this.width,
    this.borderWidth = 1,
    this.color,
    this.innerPadding,
    this.borderColor,
    this.enabledColor,
    this.focusedColor,
    this.errorStyle,
    this.backgroundColor,
    this.error = false,
    this.onChanged,
    this.minLines,
    this.isUnderline = true,
    this.noBorder = false,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.padding,
    this.errorText,
    this.paddingLeft = 0,
  }) {
    errorStyle ??= Get.find<AppFonts>().S(color: Colors.red);
  }
  @override
  Widget build(BuildContext context) {
    return expands
        ? Expanded(
            flex: flex,
            child: view(),
          )
        : view();
  }

  Widget view() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RixaTextField(
          hintText: hintText,
          labelText: labelText,
          controller: controller,
          maxLines: maxLines,
          textStyle: textStyle,
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          radius: radius,
          borderWidth: borderWidth,
          minLines: minLines,
          color: color,
          borderColor: borderColor,
          enabledColor: enabledColor,
          innerPadding: innerPadding,
          width: width,
          focusedColor: focusedColor,
          backgroundColor: backgroundColor,
          onChanged: onChanged,
          isUnderline: isUnderline,
          noBorder: noBorder,
          textInputType: textInputType,
          prefixIcon: prefixIcon,
          padding: padding,
          expands: expands,
        ),
        if (errorText != null && error) Text(errorText!, style: errorStyle)
      ],
    );
  }
}
