import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../states/page_manager.dart';
import 'connection_status.dart';
import 'device_type.dart';
import 'route_properties.dart';

class RixaProperties {
  final DeviceType _deviceType;
  final ScreenMode _screenMode;
  final Size _appSize;
  final String? _language;
  final InternetConnectionStatus? _status;
  const RixaProperties({
    required DeviceType deviceType,
    required ScreenMode screenMode,
    required Size appSize,
    required String? language,
    required InternetConnectionStatus? status,
  })  : _deviceType = deviceType,
        _screenMode = screenMode,
        _appSize = appSize,
        _language = language,
        _status = status;

  bool get anyMobile =>
      _deviceType == DeviceType.mobile ||
      _screenMode == ScreenMode.mobile ||
      _screenMode == ScreenMode.landScape;

  bool get isMobile => _deviceType == DeviceType.mobile;
  bool get isLandscaped => _screenMode == ScreenMode.landScape;
  bool get isDesktop => _deviceType == DeviceType.desktop;
  bool get isWeb => kIsWeb;
  ScreenMode get screenMode => _screenMode;
  String? get language => _language;
  Size get appSize => _appSize;
  double get appWidth => _appSize.width;
  double get appHeight => _appSize.height;
  DeviceType get deviceType => _deviceType;
  InternetConnectionStatus? get status => _status;
  RouteProperties? get route => Get.find<PageManager>().route;
}
