import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rixa/rixa.dart';

class RixaTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController controller;
  final TextStyle? textStyle, labelStyle;
  final TextStyle? hintStyle;
  final double radius;
  final double? borderWidth;
  final int maxLines;
  final int? minLines;
  final Color? color, borderColor;
  final Color? enabledColor;
  final double? width;
  final Color? focusedColor, backgroundColor;
  final dynamic Function(String)? onChanged;
  final bool isUnderline, expands, noInputBorder;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? innerPadding;
  final InputBorder? enabledBorder, focusedBorder;
  final BoxBorder? border;
  RixaTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.minLines,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.radius = 10.0,
    this.onChanged,
    Color? enabledColor,
    Color? focusedColor,
    this.labelText,
    this.width,
    TextStyle? labelStyle,
    this.isUnderline = true,
    this.expands = false,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
    EdgeInsetsGeometry? innerPadding,
    this.noInputBorder = false,
  })  : innerPadding =
            innerPadding ?? const EdgeInsets.symmetric(horizontal: 10),
        textStyle = textStyle ?? Get.find<AppFonts>().S(),
        labelStyle = labelStyle ?? Get.find<AppFonts>().S(),
        hintStyle = hintStyle ??
            Get.find<AppFonts>().S(color: Get.find<AppColors>().hintColor),
        enabledColor = enabledColor ?? Get.find<AppColors>().textColor,
        focusedColor = focusedColor ?? Colors.cyan,
        enabledBorder = !noInputBorder && isUnderline
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color: enabledColor ?? Get.find<AppColors>().textColor),
              )
            : !noInputBorder && !isUnderline
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                        color: enabledColor ?? Get.find<AppColors>().textColor),
                    borderRadius: BorderRadius.circular(radius))
                : null,
        focusedBorder = !noInputBorder && isUnderline
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: focusedColor ?? Colors.cyan),
              )
            : !noInputBorder && !isUnderline
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: focusedColor ?? Colors.cyan),
                    borderRadius: BorderRadius.circular(radius))
                : null,
        border = borderColor != null || borderWidth != null
            ? Border.all(
                width: borderWidth ?? 1,
                color: borderColor ?? Get.find<AppColors>().textColor)
            : null;
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
            border: noInputBorder ? InputBorder.none : null,
            prefixIcon: prefixIcon,
            labelText: labelText,
            labelStyle: labelStyle),
        onChanged: (text) {
          if (onChanged != null) onChanged!(text);
        },
      ),
    );
  }
}

class RixaTextFieldFull extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final int flex;
  final TextEditingController controller;
  final TextStyle? textStyle, labelStyle;
  final double? width;
  final TextStyle? titleStyle, hintStyle, errorStyle;
  final double radius;
  final double? borderWidth;
  final Color? color, borderColor;
  final Color? enabledColor;
  final Color? focusedColor, backgroundColor;
  final dynamic onChanged;
  final int maxLines;
  final int? minLines;
  final bool isUnderline, noInputBorder, expands;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? padding, innerPadding;
  final String? errorText;
  final double paddingLeft;
  final bool error;
  RixaTextFieldFull({
    super.key,
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
    this.borderWidth,
    this.color,
    this.innerPadding,
    this.borderColor,
    this.enabledColor,
    this.focusedColor,
    TextStyle? errorStyle,
    this.backgroundColor,
    this.error = false,
    this.onChanged,
    this.minLines,
    this.isUnderline = true,
    this.noInputBorder = false,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.padding,
    this.errorText,
    this.paddingLeft = 0,
  }) : errorStyle = errorStyle ?? Get.find<AppFonts>().xS(color: Colors.red);
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
          noInputBorder: noInputBorder,
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
