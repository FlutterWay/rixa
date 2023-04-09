import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rixa/rixa.dart';

class PasswordField extends StatefulWidget {
  final String text;
  final String hintText;
  final String? labelText;
  final int flex;
  final TextEditingController controller;
  final bool singleLine;
  final TextStyle? textStyle, labelStyle, errorStyle;
  final TextStyle? titleStyle, hintStyle;
  final double radius;
  final double? borderWidth;
  final Color? color, borderColor;
  final Color enabledColor, focusedColor;
  final Color? iconColor;
  final Color? bacgroundColor;
  final dynamic Function(String)? onChanged;
  final bool isUnderline, expands, noInputBorder;
  final double? width, height;
  final TextInputType textInputType;
  final bool error;
  final String? errorText;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? innerPadding;
  PasswordField(
      {super.key,
      this.text = "",
      required this.controller,
      this.hintText = "",
      this.singleLine = true,
      TextStyle? titleStyle,
      TextStyle? textStyle,
      TextStyle? hintStyle,
      this.color,
      this.borderColor,
      this.borderWidth,
      this.radius = 10.0,
      TextStyle? errorStyle,
      Color? iconColor,
      this.error = false,
      this.errorText,
      this.onChanged,
      Color? enabledColor,
      Color? focusedColor,
      this.labelText,
      TextStyle? labelStyle,
      this.isUnderline = true,
      this.expands = false,
      this.width,
      this.height,
      this.textInputType = TextInputType.text,
      this.bacgroundColor,
      this.padding = EdgeInsets.zero,
      EdgeInsetsGeometry? innerPadding,
      this.noInputBorder = false,
      this.flex = 1})
      : innerPadding =
            innerPadding ?? const EdgeInsets.symmetric(horizontal: 10),
        titleStyle = titleStyle ??
            (Rixa.properties.anyMobile
                ? Get.find<AppFonts>().S(fontWeight: FontWeight.w600)
                : Get.find<AppFonts>().S(fontWeight: FontWeight.w600)),
        iconColor = iconColor ?? Get.find<AppColors>().iconColor,
        textStyle = textStyle ?? Get.find<AppFonts>().S(),
        labelStyle = labelStyle ?? Get.find<AppFonts>().S(),
        errorStyle = errorStyle ?? Get.find<AppFonts>().xS(color: Colors.red),
        hintStyle = hintStyle ??
            Get.find<AppFonts>().xS(color: Get.find<AppColors>().hintColor),
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
  final InputBorder? enabledBorder, focusedBorder;
  final BoxBorder? border;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool showPw = false;

  @override
  Widget build(BuildContext context) {
    return widget.expands
        ? Expanded(
            flex: widget.flex,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: viewTextField(),
            ),
          )
        : SizedBox(
            width: widget.width,
            height: widget.height,
            child: viewTextField(),
          );
  }

  Widget viewTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.text != "")
          Text(
            widget.text,
            style: widget.titleStyle,
          ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: widget.bacgroundColor,
                        borderRadius: BorderRadius.circular(widget.radius),
                        border: widget.border),
                    child: TextField(
                      controller: widget.controller,
                      maxLines: widget.singleLine ? 1 : null,
                      expands: widget.singleLine ? false : true,
                      style: widget.textStyle,
                      scrollPadding: EdgeInsets.zero,
                      obscureText: showPw ? false : true,
                      textAlignVertical: TextAlignVertical.top,
                      keyboardType: widget.singleLine == false
                          ? TextInputType.multiline
                          : widget.textInputType,
                      inputFormatters: <TextInputFormatter>[
                        if (widget.textInputType == TextInputType.number)
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                          hintText: widget.hintText,
                          contentPadding: widget.innerPadding,
                          hintStyle: widget.hintStyle,
                          enabledBorder: widget.enabledBorder,
                          focusedBorder: widget.focusedBorder,
                          border:
                              widget.noInputBorder ? InputBorder.none : null,
                          labelText: widget.labelText,
                          labelStyle: widget.labelStyle),
                      onChanged: (text) {
                        if (widget.onChanged != null) widget.onChanged!(text);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            showPw = !showPw;
                          });
                        },
                        icon: Icon(
                          showPw ? Icons.visibility_off : Icons.visibility,
                          color: widget.iconColor,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
        if (widget.errorText != null && widget.error)
          Text(widget.errorText!, style: widget.errorStyle)
      ],
    );
  }
}
