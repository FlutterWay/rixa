import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import '../../texts/app_text.dart';
import '/main.dart';

class LeftMenu extends StatelessWidget {
  LeftMenu({Key? key})
      : pageNames = [
          AppTexts.page,
          AppTexts.page,
          AppTexts.settings,
          AppTexts.widgets,
          AppTexts.signout
        ],
        super(key: key);
  final List<String> pageNames;
  final List<String> pageRoutes = [
    "page1",
    "page2",
    "settings",
    "widgets",
    "login"
  ];
  final List<Widget> pageIcons = [
    Icon(Icons.last_page,
        size: appFonts.icon_small5(), color: appColors.secondaryIconColor),
    Icon(Icons.last_page,
        size: appFonts.icon_small5(), color: appColors.secondaryIconColor),
    Icon(Icons.settings,
        size: appFonts.icon_small5(), color: appColors.secondaryIconColor),
    Icon(Icons.widgets,
        size: appFonts.icon_small5(), color: appColors.secondaryIconColor),
    Icon(Icons.logout_outlined,
        size: appFonts.icon_small5(), color: appColors.secondaryIconColor)
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColors.secondaryBackgroundColor,
      child: ListView(
        children: [
          for (int i = 0; i < pageNames.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () {
                  String route = pageRoutes[i];
                  Rixa.pageManager.goNamed(name: route, context: context);
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    pageIcons[i],
                    if (Rixa.properties.screenMode == ScreenMode.desktopLarge)
                      const SizedBox(
                        width: 10,
                      ),
                    if (Rixa.properties.screenMode == ScreenMode.desktopLarge)
                      Text(
                        "${pageNames[i]} ${i < 2 ? (i + 1) : ""}",
                        style: appFonts.small5(
                            color: appColors.secondaryTextColor),
                      )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
