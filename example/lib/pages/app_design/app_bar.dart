import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import '../../main.dart';
import '../../texts/app_text.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Icon(Icons.label_important,
              color: appColors.appBarIconColor, size: appFonts.icon_small5()),
          Text(AppTexts.appbar_title,
              style: appFonts.small5(color: appColors.appBarTextColor))
        ],
      ),
      backgroundColor: appColors.appBarBackgroundColor,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Internet",
              style: appFonts.S(color: appColors.appBarTextColor),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.wifi,
              color: Rixa.properties.status == null
                  ? Colors.grey
                  : Rixa.properties.status == InternetConnectionStatus.connected
                      ? Colors.green
                      : Colors.red,
            ),
            SizedBox(
              width: appFonts.appWidth * 0.01,
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
