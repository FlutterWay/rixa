import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rixa/rixa.dart';

class CodeWrapperWidget extends StatefulWidget {
  final Widget child;
  final String text;

  const CodeWrapperWidget({Key? key, required this.child, required this.text})
      : super(key: key);

  @override
  State<CodeWrapperWidget> createState() => _PreWrapperState();
}

class _PreWrapperState extends State<CodeWrapperWidget> {
  bool hasCopied = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: hasCopied
                    ? Icon(Icons.check, color: Rixa.appColors.hintColor)
                    : Icon(Icons.copy_rounded, color: Rixa.appColors.hintColor),
              ),
              onTap: () async {
                if (hasCopied) return;
                await Clipboard.setData(ClipboardData(text: widget.text));
                hasCopied = true;
                refresh();
                Future.delayed(const Duration(seconds: 2), () {
                  hasCopied = false;
                  refresh();
                });
              },
            ),
          ),
        )
      ],
    );
  }

  void refresh() {
    if (mounted) setState(() {});
  }
}
