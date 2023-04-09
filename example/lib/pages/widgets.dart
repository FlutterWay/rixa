import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import '../main.dart';
import '../texts/app_text.dart';

class Widgets extends StatefulWidget {
  const Widgets({Key? key}) : super(key: key);

  @override
  State<Widgets> createState() => _WidgetsState();
}

class _WidgetsState extends State<Widgets> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var textEditingController = TextEditingController();
  var chatController = TextEditingController();
  var passwordController = TextEditingController();
  List<CheckBoxItem> checkboxes = [
    CheckBoxItem(
      child: Text(
        "item1",
        style: appFonts.S(),
      ),
    ),
    CheckBoxItem(child: Text("item2", style: appFonts.S()))
  ];
  double percent = 0;
  DownloadStatus status = DownloadStatus.notDownloaded;
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    return RixaBuilder(builder: (properties, fonts) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: appFonts.appWidth * 0.03),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  AppTexts.widgets,
                  style: appFonts.large5(),
                )),
                spacer(),
                Text(
                  "Chat",
                  style: appFonts.medium5(),
                ),
                spacer(),
                ChatTextField(
                    send: (text) {
                      if (kDebugMode) {
                        print(text);
                      }
                    },
                    onChanged: (text) {
                      if (kDebugMode) {
                        print(text);
                      }
                    },
                    controller: chatController,
                    viewEmojis: true,
                    backgroundColor: appColors.btnColor),
                spacer(),
                SizedBox(
                    width: 200,
                    height: 150,
                    child:
                        CheckBoxList(items: checkboxes, onChange: (items) {})),
                spacer(),
                RadioButtonList(
                  [
                    RadioButtonItem(text: "item1", value: "value1"),
                    RadioButtonItem(text: "item2", value: 2),
                    RadioButtonItem(text: "item3", value: "value3")
                  ],
                  onChanged: (value) {
                    if (kDebugMode) {
                      print(value);
                    }
                  },
                  title: "RadioButtonList",
                ),
                spacer(),
                RixaTextField(
                  hintText: "Type...",
                  controller: textEditingController,
                  radius: 30,
                  width: appFonts.appWidth * 0.5,
                  isUnderline: false,
                  onChanged: (value) {
                    if (kDebugMode) {
                      print(value);
                    }
                  },
                ),
                spacer(),
                PasswordField(
                  controller: passwordController,
                  radius: 30,
                  width: appFonts.appWidth * 0.5,
                  height: 50,
                  isUnderline: false,
                  onChanged: (value) {
                    if (kDebugMode) {
                      print(value);
                    }
                  },
                ),
                spacer(),
                DropDown(
                  itemsData: [
                    DropDownItem(item: "item1", value: "value1"),
                    DropDownItem(item: "item2", value: "value2")
                  ],
                  width: 100,
                  height: 60,
                  onChange: (value) {
                    if (kDebugMode) {
                      print(value);
                    }
                  },
                  hintText: "waiting",
                  color: appColors.btnColor,
                  radius: 30,
                ),
                spacer(),
                DownloadButton(
                    width: 60,
                    status: status,
                    downloadProgress: percent,
                    onDownload: () {
                      timer = Timer.periodic(const Duration(milliseconds: 500),
                          (Timer time) {
                        percent += 0.05;
                        if (kDebugMode) {
                          print(percent);
                        }
                        if (percent >= 1) {
                          status = DownloadStatus.downloaded;
                          time.cancel();
                        }
                        setState(() {});
                      });

                      status = DownloadStatus.downloading;
                      setState(() {});
                    },
                    onCancel: () {
                      percent = 0;
                      status = DownloadStatus.notDownloaded;
                      timer!.cancel();
                      setState(() {});
                    },
                    onOpen: () {}),
                RegionBar(
                  onChanged: (index) {
                    if (kDebugMode) {
                      print(index);
                    }
                  },
                  menuTexts: const ["Menu1", "Menu2", "Menu3"],
                ),
                spacer(),
                TextButton(
                    onPressed: () {
                      Rixa.openDialog(
                          title: "Dialog Title",
                          child: Text(
                            "My Dialog Content",
                            style: appFonts.S(color: appColors.dialogTextColor),
                          ),
                          context: context);
                    },
                    child: Text(
                      "Dialog Btn",
                      style: appFonts.medium5(),
                    )),
                spacer(),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget spacer() {
    return const SizedBox(
      height: 15,
    );
  }
}
