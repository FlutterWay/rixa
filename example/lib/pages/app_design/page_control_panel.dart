import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import '../../main.dart';
import 'app_bar.dart';
import 'drawer.dart';
import 'left_menu.dart';

class MyNestedPage extends StatefulWidget {
  final Widget child;
  const MyNestedPage({Key? key, required this.child}) : super(key: key);

  @override
  State<MyNestedPage> createState() => _MyNestedPageState();
}

class _MyNestedPageState extends State<MyNestedPage> {
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
    return RixaBuilder(builder: (properties, fonts) {
      return Scaffold(
          backgroundColor: Rixa.appColors.backgroundColor,
          // ignore: prefer_const_constructors
          appBar: MyAppbar(),
          drawer: properties.anyMobile ? MyDrawer() : null,
          body: Row(
            children: [
              if (!properties.anyMobile)
                SizedBox(
                  height: double.infinity,
                  width: properties.screenMode == ScreenMode.desktopLarge
                      ? 200
                      : 70,
                  child: LeftMenu(),
                ),
              Expanded(
                child: widget.child,
              ),
            ],
          ));
    });
  }
}
