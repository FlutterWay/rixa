import 'package:flutter/material.dart';

import 'package:rixa/rixa.dart';

import '../../main.dart';
import '../../texts/app_text.dart';

class MyDrawer extends StatelessWidget {
  final List<Widget> pageIcons = [
    Icon(Icons.last_page,
        size: appFonts.icon_small5(), color: appColors.secondaryTextColor),
    Icon(Icons.last_page,
        size: appFonts.icon_small5(), color: appColors.secondaryTextColor),
    Icon(Icons.settings,
        size: appFonts.icon_small5(), color: appColors.secondaryTextColor),
    Icon(Icons.widgets,
        size: appFonts.icon_small5(), color: appColors.secondaryTextColor),
  ];
  final List<String> routes = [
    "page1",
    "page2",
    "settings",
    "widgets",
  ];

  MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> pageNames = [
      AppTexts.page,
      AppTexts.page,
      AppTexts.settings,
      AppTexts.widgets
    ];
    return Drawer(
      backgroundColor: appColors.drawerBackgroundColor,
      child: Column(
        children: [
          SizedBox(
            height: appFonts.appHeight * 0.03,
          ),
          SizedButton(
            width: double.infinity,
            height: appFonts.appHeight * 0.06,
            onPressed: () {
              context.goNamed(name: "page1");
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(Icons.label_important,
                    color: appColors.appBarTextColor,
                    size: appFonts.icon_small5()),
                Text(AppTexts.appbar_title,
                    style: appFonts.medium5(color: appColors.appBarTextColor))
              ],
            ),
          ),
          for (int i = 0; i < pageNames.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () {
                  context.goNamed(name: routes[i]);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    pageIcons[i],
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${pageNames[i]} ${i < 2 ? (i + 1) : ""}",
                      style: appFonts.S(color: appColors.secondaryTextColor),
                    )
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: SizedButton(
              width: double.infinity,
              height: appFonts.appHeight * 0.06,
              color: appColors.drawerBtnColor,
              innerPadding: const EdgeInsets.symmetric(horizontal: 10),
              onPressed: () {
                context.goNamed(name: "login");
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.logout,
                      color: appColors.appBarBtnTextColor,
                      size: appFonts.icon_small5()),
                  Text(AppTexts.signout,
                      style:
                          appFonts.medium5(color: appColors.appBarBtnTextColor))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
