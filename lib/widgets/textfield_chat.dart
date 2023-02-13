import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rixa/rixa.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatTextField extends StatefulWidget {
  Function(String text) send;
  Function(String text)? onChanged;
  TextEditingController controller;
  Color? backgroundColor;
  TextStyle? textStyle;
  TextStyle? hintStyle;
  String hintText;
  double radius;
  int maxLines;
  Widget? prefixIcon, suffixIcon;
  bool viewEmojis;
  ChatTextField(
      {Key? key,
      required this.send,
      required this.controller,
      this.onChanged,
      this.backgroundColor,
      this.maxLines = 5,
      this.textStyle,
      this.radius = 10,
      this.hintText = "Type...",
      this.viewEmojis = false,
      this.hintStyle})
      : super(key: key) {
    textStyle ??= Get.find<AppFonts>().S();
    hintStyle ??=
        Get.find<AppFonts>().S(color: Get.find<AppColors>().hintColor);
  }

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  var appFonts = Get.find<AppFonts>();
  var appColors = Get.find<AppColors>();
  ScrollController scrollController = ScrollController();
  RawKeyEvent? beforeEvent;
  bool emojiMenuOpened = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.radius)),
          child: RawKeyboardListener(
            focusNode: FocusNode(onKey: (node, event) {
              if (event.isKeyPressed(LogicalKeyboardKey.enter) ||
                  event.isKeyPressed(LogicalKeyboardKey.shiftLeft)) {
                return KeyEventResult.handled;
              }
              return KeyEventResult.ignored;
            }),
            onKey: (event) {
              if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                if (beforeEvent == null ||
                    !beforeEvent!.isKeyPressed(LogicalKeyboardKey.shiftLeft)) {
                  widget.send(widget.controller.text);
                  widget.controller.clear();
                } else if (beforeEvent != null ||
                    beforeEvent!.isKeyPressed(LogicalKeyboardKey.shiftLeft)) {
                  //int len = widget.controller.text.split("\n").length;
                  widget.controller.text += " \n";
                  widget.controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: widget.controller.text.length));
                  scrollController.animateTo(2000,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeIn);
                }
              }
              beforeEvent = event;
            },
            child: TextField(
              controller: widget.controller,
              style: widget.textStyle,
              textAlign: TextAlign.left,
              maxLines: widget.maxLines,
              minLines: 1,
              scrollController: scrollController,
              showCursor: true,
              readOnly: emojiMenuOpened,
              decoration: InputDecoration(
                  //prefixIcon: EmojiButton(
                  //  onPressed: () {
                  //    setState(() {
                  //      emojiMenuOpened = !emojiMenuOpened;
                  //    });
                  //  },
                  //  icon: Icon(
                  //    Icons.emoji_emotions,
                  //    color: appColors.textColor,
                  //    size: appFonts.icon_S,
                  //  ),
                  //),
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle,
                  border: InputBorder.none),
              onChanged: (text) {
                if (widget.onChanged != null) {
                  widget.onChanged!(text);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
