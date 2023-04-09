// ignore_for_file: non_constant_identifier_names

//import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rixa/models/font_size.dart';
import '../rixa.dart';

class AppFonts extends GetxController {
  double _appWidth = 0;
  double _appHeight = 0;
  bool? isStaticDefault;
  String defaultFontFamily = "Lato";
  late BuildContext _context;
  late double _totalSize;
  final Map<String, double> _sizeRatios = {
    "small": 0.013,
    "medium": 0.026,
    "large": 0.039,
    "mega": 0.052
  };
  final Map<String, double> _sizeIconRatios = {
    "small": 0.015,
    "medium": 0.03,
    "large": 0.045,
    "mega": 0.06
  };

  final Map<String, double> _staticSizes = {
    "small": 20,
    "medium": 40,
    "large": 60,
    "mega": 80,
  };

  final Map<String, double> _staticIconSizes = {
    "small": 30,
    "medium": 60,
    "large": 90,
    "mega": 120,
  };

  final Map<String, double> _specificSizes = {};
  BuildContext get context => _context;
  double get appWidth => _appWidth;
  double get appHeight => _appHeight;
  Size get appSize => Size(_appWidth, _appHeight);
  double get totalSize => _totalSize;
  double get keyboardHeight => _context.read<ScreenHeight>().keyboardHeight;
  bool get isKeyboardOpen => _context.read<ScreenHeight>().isOpen;
  double specificSize(String name) {
    return _specificSizes[name]!;
  }

  void updateFonts(BuildContext context, {bool? staticSize}) {
    _context = context;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //double width = window.physicalSize.width;
    //double height = window.physicalSize.height;
    Get.find<AppSettings>().screenConfiguration(context);
    _appWidth = width;
    _appHeight = height;
    _totalSize = _appWidth + _appHeight;
    if (!Get.find<PageManager>().pageChanged) {
      update();
      Get.find<AppSettings>().update();
    } else {
      Get.find<PageManager>().pageChanged = false;
    }
  }

  void changeStaticSize({required String name, required double size}) {
    _staticSizes[name] = size;
    update();
    Get.find<AppSettings>().update();
  }

  void changeStaticSizeRatio({required String name, required double ratio}) {
    _sizeRatios[name] = ratio;
    update();
    Get.find<AppSettings>().update();
  }

  void addSpecificSize({required double size, required String name}) {
    _specificSizes[name] = size;
  }

  void removeSpecificSize(String name) {
    _specificSizes.removeWhere((key, value) => key == name);
  }

  //void listenState(State state) {
  //  void Function() setState = updateState(state);
  //  addListener(setState);
  //}

  double icon_xS({String? pageName, bool? isStatic}) {
    return icon_small3(pageName: pageName, isStatic: isStatic);
  }

  double icon_S({String? pageName, bool? isStatic}) {
    return icon_small5(pageName: pageName, isStatic: isStatic);
  }

  double icon_M({String? pageName, bool? isStatic}) {
    return icon_medium5(pageName: pageName, isStatic: isStatic);
  }

  double icon_L({String? pageName, bool? isStatic}) {
    return icon_large5(pageName: pageName, isStatic: isStatic);
  }

  double icon_xL({String? pageName, bool? isStatic}) {
    return icon_large5(pageName: pageName, isStatic: isStatic);
  }

  double icon_mega({String? pageName, bool? isStatic}) {
    return icon_mega5(pageName: pageName, isStatic: isStatic);
  }

  double icon_giga({String? pageName, bool? isStatic}) {
    return icon_mega7(pageName: pageName, isStatic: isStatic);
  }

  double calculateRatio(double ratio, double dif, int number) {
    switch (number) {
      case 1:
        return (ratio - (dif / 5 * 4)) * _totalSize;
      case 2:
        return (ratio - (dif / 5 * 3)) * _totalSize;
      case 3:
        return (ratio - (dif / 5 * 2)) * _totalSize;
      case 4:
        return (ratio - (dif / 5)) * _totalSize;
      case 6:
        return (ratio + (dif / 5)) * _totalSize;
      case 7:
        return (ratio + (dif / 5 * 2)) * _totalSize;
      case 8:
        return (ratio + (dif / 5 * 3)) * _totalSize;
      case 9:
        return (ratio + (dif / 5 * 4)) * _totalSize;
      default:
        return ratio;
    }
  }

  double calculateFontsize(double fontSize, double dif, int number) {
    switch (number) {
      case 1:
        return (fontSize - (dif / 5 * 4));
      case 2:
        return (fontSize - (dif / 5 * 3));
      case 3:
        return (fontSize - (dif / 5 * 2));
      case 4:
        return (fontSize - (dif / 5));
      case 6:
        return (fontSize + (dif / 5));
      case 7:
        return (fontSize + (dif / 5 * 2));
      case 8:
        return (fontSize + (dif / 5 * 3));
      case 9:
        return (fontSize + (dif / 5 * 4));
      default:
        return fontSize;
    }
  }

  double icon_small1({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["small"]!
          : getPageDynamicIconSizes(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 1);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticIconSized(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 1);
    }

    return fontSize;
  }

  double icon_small2({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["small"]!
          : getPageDynamicIconSizes(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 2);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticIconSized(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 2);
    }

    return fontSize;
  }

  double icon_small3({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["small"]!
          : getPageDynamicIconSizes(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 3);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticIconSized(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 3);
    }

    return fontSize;
  }

  double icon_small4({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["small"]!
          : getPageDynamicIconSizes(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 4);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticIconSized(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 4);
    }

    return fontSize;
  }

  double icon_small5({String? pageName, bool? isStatic}) {
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      return (pageName == null
              ? _sizeIconRatios["small"]!
              : getPageDynamicIconSizes(pageName, SizeType.small)) *
          _totalSize;
    } else {
      return pageName == null
          ? _staticSizes["small"]!
          : getPageStaticIconSized(pageName, SizeType.small);
    }
  }

  double icon_small6({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["small"]!
          : getPageDynamicIconSizes(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 6);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticIconSized(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 6);
    }

    return fontSize;
  }

  double icon_small7({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["small"]!
          : getPageDynamicIconSizes(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 7);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticIconSized(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 7);
    }

    return fontSize;
  }

  double icon_small8({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["small"]!
          : getPageDynamicIconSizes(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 8);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticIconSized(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 8);
    }

    return fontSize;
  }

  double icon_small9({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["small"]!
          : getPageDynamicIconSizes(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 9);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticIconSized(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 9);
    }

    return fontSize;
  }

  double icon_medium1({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 1);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 1);
    }

    return fontSize;
  }

  double icon_medium2({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 2);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 2);
    }

    return fontSize;
  }

  double icon_medium3({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 3);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 3);
    }

    return fontSize;
  }

  double icon_medium4({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 4);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 4);
    }

    return fontSize;
  }

  double icon_medium5({String? pageName, bool? isStatic}) {
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      return (pageName == null
              ? _sizeIconRatios["medium"]!
              : getPageDynamicIconSizes(pageName, SizeType.medium)) *
          _totalSize;
    } else {
      return pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
    }
  }

  double icon_medium6({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 6);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 6);
    }

    return fontSize;
  }

  double icon_medium7({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 7);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 7);
    }

    return fontSize;
  }

  double icon_medium8({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 8);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 8);
    }

    return fontSize;
  }

  double icon_medium9({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["medium"]!
          : getPageDynamicIconSizes(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 9);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticIconSized(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 9);
    }

    return fontSize;
  }

  double icon_large1({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 1);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 1);
    }

    return fontSize;
  }

  double icon_large2({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 2);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 2);
    }

    return fontSize;
  }

  double icon_large3({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 3);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 3);
    }

    return fontSize;
  }

  double icon_large4({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 4);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 4);
    }

    return fontSize;
  }

  double icon_large5({String? pageName, bool? isStatic}) {
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      return (pageName == null
              ? _sizeIconRatios["large"]!
              : getPageDynamicIconSizes(pageName, SizeType.large)) *
          _totalSize;
    } else {
      return pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
    }
  }

  double icon_large6({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 6);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 6);
    }

    return fontSize;
  }

  double icon_large7({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 7);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 7);
    }

    return fontSize;
  }

  double icon_large8({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 8);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 8);
    }

    return fontSize;
  }

  double icon_large9({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 9);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 9);
    }

    return fontSize;
  }

  double icon_mega1({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 1);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 1);
    }

    return fontSize;
  }

  double icon_mega2({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 2);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 2);
    }

    return fontSize;
  }

  double icon_mega3({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 3);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 3);
    }

    return fontSize;
  }

  double icon_mega4({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 4);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 4);
    }

    return fontSize;
  }

  double icon_mega5({String? pageName, bool? isStatic}) {
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      return (pageName == null
              ? _sizeIconRatios["mega"]!
              : getPageDynamicIconSizes(pageName, SizeType.mega)) *
          _totalSize;
    } else {
      return pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
    }
  }

  double icon_mega6({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 6);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 6);
    }

    return fontSize;
  }

  double icon_mega7({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 7);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 7);
    }

    return fontSize;
  }

  double icon_mega8({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 8);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 8);
    }

    return fontSize;
  }

  double icon_mega9({String? pageName, bool? isStatic}) {
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeIconRatios["large"]!
          : getPageDynamicIconSizes(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeIconRatios["mega"]!
          : getPageDynamicIconSizes(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 9);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticIconSized(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticIconSized(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 9);
    }

    return fontSize;
  }

  double getPageDynamicIconSizes(String pageName, SizeType type) {
    switch (type) {
      case SizeType.small:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>()
                        .getPageFonts(pageName)!
                        .icon_small_ratio !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.icon_small_ratio!
            : _sizeIconRatios["small"]!;
      case SizeType.medium:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>()
                        .getPageFonts(pageName)!
                        .icon_medium_ratio !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.icon_medium_ratio!
            : _sizeIconRatios["medium"]!;
      case SizeType.large:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>()
                        .getPageFonts(pageName)!
                        .icon_large_ratio !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.icon_large_ratio!
            : _sizeIconRatios["large"]!;
      case SizeType.mega:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>()
                        .getPageFonts(pageName)!
                        .icon_mega_ratio !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.icon_mega_ratio!
            : _sizeIconRatios["mega"]!;
    }
  }

  double getPageStaticIconSized(String pageName, SizeType type) {
    switch (type) {
      case SizeType.small:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>().getPageFonts(pageName)!.icon_small !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.icon_small!
            : _staticIconSizes["small"]!;
      case SizeType.medium:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>().getPageFonts(pageName)!.icon_medium !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.icon_medium!
            : _staticIconSizes["medium"]!;
      case SizeType.large:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>().getPageFonts(pageName)!.icon_large !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.icon_large!
            : _staticIconSizes["large"]!;
      case SizeType.mega:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>().getPageFonts(pageName)!.icon_mega !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.icon_mega!
            : _staticIconSizes["mega"]!;
    }
  }

  double getPageDynamicFonts(String pageName, SizeType type) {
    switch (type) {
      case SizeType.small:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>()
                        .getPageFonts(pageName)!
                        .text_small_ratio !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.text_small_ratio!
            : _sizeRatios["small"]!;
      case SizeType.medium:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>()
                        .getPageFonts(pageName)!
                        .text_medium_ratio !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.text_medium_ratio!
            : _sizeRatios["medium"]!;
      case SizeType.large:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>()
                        .getPageFonts(pageName)!
                        .text_large_ratio !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.text_large_ratio!
            : _sizeRatios["large"]!;
      case SizeType.mega:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>()
                        .getPageFonts(pageName)!
                        .text_mega_ratio !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.text_mega_ratio!
            : _sizeRatios["mega"]!;
    }
  }

  double getPageStaticFonts(String pageName, SizeType type) {
    switch (type) {
      case SizeType.small:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>().getPageFonts(pageName)!.text_small !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.text_small!
            : _staticSizes["small"]!;
      case SizeType.medium:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>().getPageFonts(pageName)!.text_medium !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.text_medium!
            : _staticSizes["medium"]!;
      case SizeType.large:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>().getPageFonts(pageName)!.text_large !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.text_large!
            : _staticSizes["large"]!;
      case SizeType.mega:
        return Get.find<PageManager>().getPageFonts(pageName) != null &&
                Get.find<PageManager>().getPageFonts(pageName)!.text_mega !=
                    null
            ? Get.find<PageManager>().getPageFonts(pageName)!.text_mega!
            : _staticSizes["mega"]!;
    }
  }

  TextStyle specific(
      {required String specificType,
      Color? color,
      String? fontFamily,
      TextDecoration? decoration,
      Color? backgroundColor,
      bool? isBold,
      FontWeight fontWeight = FontWeight.normal}) {
    color ??= Get.find<AppColors>().textColor;
    return GoogleFonts.getFont(fontFamily ?? defaultFontFamily,
        fontSize: _specificSizes[specificType],
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle xS(
      {Color? color,
      bool? isBold,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      String? fontFamily,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    return small3(
        color: color,
        isBold: isBold,
        pageName: pageName,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        isStatic: isStatic);
  }

  TextStyle S(
      {Color? color,
      bool? isBold,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      String? fontFamily,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    return small5(
        color: color,
        isBold: isBold,
        pageName: pageName,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        isStatic: isStatic);
  }

  TextStyle M(
      {Color? color,
      bool? isBold,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      String? fontFamily,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    return medium5(
        color: color,
        isBold: isBold,
        pageName: pageName,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        isStatic: isStatic);
  }

  TextStyle L(
      {Color? color,
      bool? isBold,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      String? fontFamily,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    return large5(
        color: color,
        isBold: isBold,
        pageName: pageName,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        isStatic: isStatic);
  }

  TextStyle xL(
      {Color? color,
      bool? isBold,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      String? fontFamily,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    return large7(
        color: color,
        isBold: isBold,
        pageName: pageName,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        isStatic: isStatic);
  }

  TextStyle mega(
      {Color? color,
      bool? isBold,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      String? fontFamily,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    return mega5(
        color: color,
        isBold: isBold,
        pageName: pageName,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        isStatic: isStatic);
  }

  TextStyle giga(
      {Color? color,
      bool? isBold,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      String? fontFamily,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    return mega7(
        color: color,
        isBold: isBold,
        pageName: pageName,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        isStatic: isStatic);
  }

  TextStyle small1(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["small"]!
          : getPageDynamicFonts(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 1);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticFonts(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 1);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.small)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle small2(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["small"]!
          : getPageDynamicFonts(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 2);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticFonts(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 2);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.small)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle small3(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["small"]!
          : getPageDynamicFonts(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 3);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticFonts(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 3);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.small)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle small4(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["small"]!
          : getPageDynamicFonts(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 4);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticFonts(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 4);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.small)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle small5(
      {Color? color,
      bool? isBold,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      String? fontFamily,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio = pageName == null
          ? _sizeRatios["small"]!
          : getPageDynamicFonts(pageName, SizeType.small);
      fontSize = ratio * _totalSize;
    } else {
      fontSize = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticFonts(pageName, SizeType.small);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.small)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle small6(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["small"]!
          : getPageDynamicFonts(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 6);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticFonts(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 6);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.small)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle small7(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["small"]!
          : getPageDynamicFonts(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 7);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticFonts(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 7);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.small)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle small8(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["small"]!
          : getPageDynamicFonts(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 8);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticFonts(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 8);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.small)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle small9(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["small"]!
          : getPageDynamicFonts(pageName, SizeType.small);
      double ratio2 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 9);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["small"]!
          : getPageStaticFonts(pageName, SizeType.small);
      double fontSize2 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 9);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.small)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle medium1(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 1);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 1);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.medium)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle medium2(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 2);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 2);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.medium)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle medium3(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 3);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 3);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.medium)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle medium4(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 4);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 4);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.medium)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle medium5(
      {Color? color,
      bool? isBold,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      String? fontFamily,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      fontSize = ratio * _totalSize;
    } else {
      fontSize = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.medium)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle medium6(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 6);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 6);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.medium)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle medium7(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 7);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 7);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.medium)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle medium8(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 8);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 8);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.medium)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle medium9(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["medium"]!
          : getPageDynamicFonts(pageName, SizeType.medium);
      double ratio2 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 9);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["medium"]!
          : getPageStaticFonts(pageName, SizeType.medium);
      double fontSize2 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 9);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.medium)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle large1(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 1);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 1);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.large)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle large2(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 2);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 2);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.large)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle large3(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 3);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 3);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.large)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle large4(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 4);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 4);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.large)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle large5(
      {Color? color,
      bool? isBold,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      String? fontFamily,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      fontSize = ratio * _totalSize;
    } else {
      fontSize = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.large)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle large6(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 6);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 6);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.large)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle large7(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 7);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 7);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.large)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle large8(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 8);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 8);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.large)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle large9(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 9);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 9);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.large)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle mega1(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 1);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 1);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.mega)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle mega2(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 2);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 2);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.mega)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle mega3(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 3);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 3);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.mega)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle mega4(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 4);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 4);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.mega)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle mega5(
      {Color? color,
      bool? isBold,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      String? fontFamily,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      fontSize = ratio * _totalSize;
    } else {
      fontSize = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
    }

    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.mega)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle mega6(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 6);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 6);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.mega)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle mega7(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 7);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 7);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.mega)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle mega8(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 8);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 8);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.mega)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle mega9(
      {Color? color,
      bool? isBold,
      String? fontFamily,
      String? pageName,
      TextDecoration? decoration,
      Color? backgroundColor,
      FontWeight fontWeight = FontWeight.normal,
      bool? isStatic}) {
    color ??= Get.find<AppColors>().textColor;
    late double fontSize;
    if ((isStatic == null &&
            isStaticDefault == null &&
            Get.find<AppSettings>().properties.screenMode ==
                ScreenMode.mobile) ||
        (isStatic == null && isStaticDefault == false) ||
        isStatic == false) {
      double ratio1 = pageName == null
          ? _sizeRatios["large"]!
          : getPageDynamicFonts(pageName, SizeType.large);
      double ratio2 = pageName == null
          ? _sizeRatios["mega"]!
          : getPageDynamicFonts(pageName, SizeType.mega);
      double dif = (ratio2 - ratio1);
      if (dif > ratio1) {
        dif = ratio1;
      }
      fontSize = calculateRatio(ratio1, dif, 9);
    } else {
      double fontSize1 = pageName == null
          ? _staticSizes["large"]!
          : getPageStaticFonts(pageName, SizeType.large);
      double fontSize2 = pageName == null
          ? _staticSizes["mega"]!
          : getPageStaticFonts(pageName, SizeType.mega);
      double dif = (fontSize2 - fontSize1);
      if (dif > fontSize1) {
        dif = fontSize1;
      }
      fontSize = calculateFontsize(fontSize1, dif, 9);
    }
    return GoogleFonts.getFont(
        fontFamily ??
            (pageName != null
                ? Get.find<PageManager>()
                    .getPageFontFamily(pageName, SizeType.mega)
                : defaultFontFamily),
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        backgroundColor: backgroundColor,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }
}
