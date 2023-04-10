import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import '../../main.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RixaBuilder(builder: (properties, fonts) {
      return Scaffold(
        backgroundColor: appColors.backgroundColor,
        body: Column(
          children: [
            const Spacer(),
            ExpandedText(
              "404",
              alignment: Alignment.center,
              style: appFonts.medium5(color: const Color(0xFF82b7ff)),
            ),
            ExpandedText(
              "Sorry, we couldn’t find that page…",
              alignment: Alignment.center,
              style: appFonts.small5(color: const Color(0xFF82b7ff)),
            ),
            const Expanded(
              flex: 5,
              child: Image(
                image: AssetImage("assets/confused.png"),
              ),
            ),
            ExpandedText(
              "But Dash is here to help - maybe one of these will point you in the right direction?",
              alignment: Alignment.center,
              style: appFonts.small5(color: const Color(0xFF82b7ff)),
            ),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      );
    });
  }
}
