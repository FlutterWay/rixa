import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import '../texts/app_text.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
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
    return RixaBuilder(
        name: "page1",
        builder: (properties, fonts) {
          return Center(
            child: Text(
              "${AppTexts.page} 1",
              style: Rixa.appFonts.medium3(pageName: "page1"),
            ),
          );
        });
  }
}
