//import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as connection;
import 'package:rixa/rixa.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends GetxController {
  InternetConnectionStatus? _status;
  String? _language;
  List<String>? _languages;
  late ScreenMode _screenMode;
  late DeviceType _deviceType;
  RixaProperties get properties => RixaProperties(
      deviceType: _deviceType,
      screenMode: _screenMode,
      appSize: Get.find<AppFonts>().appSize,
      language: _language,
      status: _status);
  String? giphyApiKey;
  void Function(InternetConnectionStatus status)? _afterConnectionFunc;
  final Map<String, void Function()> _specificSettings = {};
  final Map<String, dynamic> specificVariables = {};

  void screenConfiguration(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //double width = window.physicalSize.width;
    //double height = window.physicalSize.height;
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.android ||
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.fuchsia) {
      _deviceType = DeviceType.mobile;
    } else {
      _deviceType = DeviceType.desktop;
    }
    if (_deviceType == DeviceType.mobile && width > height) {
      _screenMode = ScreenMode.landScape;
    } else if (_deviceType == DeviceType.mobile && height > width) {
      _screenMode = ScreenMode.mobile;
    } else if (_deviceType == DeviceType.desktop &&
        width <= Get.find<PageManager>().currentPageLimits.mobile) {
      _screenMode = ScreenMode.mobile;
    } else if (_deviceType == DeviceType.desktop &&
        width <= Get.find<PageManager>().currentPageLimits.landScape &&
        width > Get.find<PageManager>().currentPageLimits.mobile) {
      _screenMode = ScreenMode.landScape;
    } else if (_deviceType == DeviceType.desktop &&
        width <= Get.find<PageManager>().currentPageLimits.desktopMini &&
        width > Get.find<PageManager>().currentPageLimits.landScape) {
      _screenMode = ScreenMode.desktopMini;
    } else {
      _screenMode = ScreenMode.desktopLarge;
    }
  }

  set setPlatform(TargetPlatform platform) {}

  AppSettings() {
    if (!kIsWeb) {
      connection.InternetConnectionCheckerPlus()
          .onStatusChange
          .listen((status) async {
        switch (status) {
          case connection.InternetConnectionStatus.connected:
            _status = InternetConnectionStatus.connected;
            if (_afterConnectionFunc != null) {
              _afterConnectionFunc!(InternetConnectionStatus.connected);
            }
            break;
          case connection.InternetConnectionStatus.disconnected:
            _status = InternetConnectionStatus.disconnected;
            if (_afterConnectionFunc != null) {
              _afterConnectionFunc!(InternetConnectionStatus.disconnected);
            }
            break;
        }
      });
    }
  }

  set setAppLanguages(AppLanguages appLanguages) {
    _languages = appLanguages.languages;
    _language = appLanguages.initLanguge;
  }

  //void listenState(State state) {
  //  print(state.widget.runtimeType);
  //  void Function() setState = updateState(state);
  //  addListener(setState);
  //  Get.find<PageManager>().setStateUpdater = () {
  //    print("removeListener");
  //    removeListener(setState);
  //  };
  //}

  int getIndexOfLang() {
    return _languages!.indexOf(_language!);
  }

  dynamic specificSetting(String name) {
    return _specificSettings[name]!;
  }

  void addSpecificSetting(
      {required void Function() function, required String name}) {
    _specificSettings[name] = () {
      function();
      update();
    };
  }

  void removeSpecificSetting(String name) {
    _specificSettings.removeWhere((key, value) => key == name);
  }

  void addSpecificVariable({required var variable, required String name}) {
    specificVariables[name] = variable;
  }

  void removeSpecificVariable(String name) {
    specificVariables.removeWhere((key, value) => key == name);
  }

  set changeLanguage(String language) {
    _language = language;
    SharedPreferences.getInstance()
        .then((value) => value.setString("rixa-language", language));
    update();
  }

  set onConnectionChange(Function(InternetConnectionStatus status) function) {
    _afterConnectionFunc = function;
  }
}
