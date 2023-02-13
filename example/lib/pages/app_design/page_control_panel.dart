import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import '../../main.dart';
import 'app_bar.dart';
import 'drawer.dart';
import 'left_menu.dart';

class PageControlPanel extends StatefulWidget {
  const PageControlPanel({Key? key}) : super(key: key);

  @override
  State<PageControlPanel> createState() => _PageControlPanelState();
}

class _PageControlPanelState extends State<PageControlPanel> {
  @override
  void initState() {
    appSettings.onConnectionChange = (connection) {
      if (kDebugMode) {
        print("Current Conneciton:$connection");
      }
    };
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Rixa.build(context);
    return Scaffold(
        backgroundColor: appColors.backgroundColor,
        appBar: const MyAppbar(),
        drawer: Rixa.properties.anyMobile ? MyDrawer() : null,
        body: Row(
          children: [
            if (!Rixa.properties.anyMobile)
              SizedBox(
                height: double.infinity,
                width: Rixa.properties.screenMode == ScreenMode.desktopLarge
                    ? 200
                    : 70,
                child: LeftMenu(),
              ),
            const Expanded(
              child: RixaDynamicArea(),
            ),
          ],
        ));
  }
}
