import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';

import '../main.dart';
import '../texts/app_text.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RixaBuilder(builder: (properties, fonts) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${AppTexts.page} 2",
              style: appFonts.large5(),
            ),
            SizedButton(
              width: 600,
              height: 60,
              alignment: Alignment.center,
              borderColor: appColors.textColor,
              child: Text(
                AppTexts.goToNested,
                style: fonts.small5(),
              ),
              onPressed: () {
                context.goNamed(name: "page2nested");
              },
            )
          ],
        ),
      );
    });
  }
}
