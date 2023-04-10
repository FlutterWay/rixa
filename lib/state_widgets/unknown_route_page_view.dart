import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';

class UnknownRoutePageView extends StatelessWidget {
  const UnknownRoutePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Rixa.appColors.backgroundColor,
      body: Column(
        children: [
          const Spacer(),
          ExpandedText(
            "404",
            alignment: Alignment.center,
            style: Rixa.appFonts.M(color: const Color(0xFF82b7ff)),
          ),
          ExpandedText(
            "Sorry, we couldn’t find that page…",
            alignment: Alignment.center,
            style: Rixa.appFonts.S(color: const Color(0xFF82b7ff)),
          ),
          ExpandedText(
            "But Dash is here to help - maybe one of these will point you in the right direction?",
            alignment: Alignment.center,
            style: Rixa.appFonts.S(color: const Color(0xFF82b7ff)),
          ),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
