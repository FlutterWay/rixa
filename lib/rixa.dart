library rixa;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rixa/models/route_properties.dart';
import 'models/rixa_properties.dart';
import 'models/screen_mode_limits.dart';
import 'states/app_colors.dart';
import 'states/app_fonts.dart';
import 'states/app_settings.dart';
import 'states/page_manager.dart';
import 'models/rixa_pages.dart';

export 'states/app_colors.dart';
export 'states/app_fonts.dart';
export 'states/app_settings.dart';
export 'states/page_manager.dart';
export 'state_widgets/rixa_text.dart';
export 'widgets/sized_button.dart';
export 'widgets/checkbox_list.dart';
export 'widgets/textfield_chat.dart';
export 'widgets/expanded_container.dart';
export 'widgets/inf_container.dart';
export 'widgets/check_box.dart';
export 'widgets/child_expanded.dart';
export 'widgets/crop_image.dart';
export 'widgets/download_btn.dart';
export 'widgets/drop_down.dart';
export 'widgets/rixa_textfield.dart';
export 'widgets/file_icon.dart';
export 'widgets/passwordfield.dart';
export 'widgets/file_type.dart';
export 'widgets/icon_of_file.dart';
export 'widgets/glass_morphism.dart';
export 'widgets/line_chart.dart';
export 'widgets/liquid_loading_bar.dart';
export 'widgets/middle_of_expanded.dart';
export 'widgets/radio_button_list.dart';
export 'widgets/region_bar.dart';
export 'widgets/expanded_text.dart';
export 'widgets/expanded_text_button.dart';
export 'variables/time_variables.dart';
export 'widgets/profile_avatar.dart';
export 'widgets/image_avatar.dart';
export 'extensions/page_state.dart';
export 'extensions/string.dart';
export 'state_widgets/rixa_dynamic_area.dart';
export 'state_widgets/rixa_material.dart';
export 'state_widgets/rixa_builder.dart';
export 'models/rixa_pages.dart';
export 'models/rixa_properties.dart';
export 'models/device_type.dart';
export 'models/screen_mode_limits.dart';
export 'models/connection_status.dart';

class Rixa {
  static void setup({
    required AppPages pages,
    AppAppearances? appearances,
    AppLanguages? languages,
    ScreenModeLimits? screenModeLimits,
  }) {
    screenModeLimits ??=
        ScreenModeLimits(mobile: 900, landScape: 1200, desktopMini: 1600);
    Get.put(AppSettings());
    if (languages != null) {
      Get.find<AppSettings>().setAppLanguages = languages;
    }
    Get.put(AppFonts());
    if (appearances != null) {
      Get.put(AppColors.withAppearances(appearances));
    }
    Get.put(PageManager());
    Get.find<PageManager>().setAppPages = pages;
    Get.find<PageManager>().defaultLimits = screenModeLimits;
  }

  static void build(BuildContext context, {bool? staticSize}) {
    Get.find<AppFonts>().updateFonts(context, staticSize: staticSize);
  }

  static AppColors setAppAppearances(AppAppearances appearances) {
    if (GetInstance().isRegistered<AppColors>()) {
      Get.find<AppColors>().setAppAppearances = appearances;
      return Get.find<AppColors>();
    } else {
      return Get.put(AppColors.withAppearances(appearances));
    }
  }

  static PageManager setAppPages(AppPages pages) {
    if (GetInstance().isRegistered<PageManager>()) {
      Get.find<PageManager>().setAppPages = pages;
      return Get.find<PageManager>();
    } else {
      var pageManager = Get.put(PageManager());
      pageManager.setAppPages = pages;
      return pageManager;
    }
  }

  static AppSettings get appSettings => Get.find<AppSettings>();
  static AppFonts get appFonts => Get.find<AppFonts>();
  static AppColors get appColors => Get.find<AppColors>();
  static PageManager get pageManager => Get.find<PageManager>();
  static RixaProperties get properties => Get.find<AppSettings>().properties;
  static RouteProperties get route => Get.find<PageManager>().route;

  static Future<dynamic> openDialog(
      {required Widget child,
      String title = "",
      String hideText = "Hide",
      bool noAction = false,
      bool zeroPadding = false,
      bool barrierDismissible = true,
      TextStyle? titleStyle,
      TextStyle? hideTextStyle,
      Color? bgColor,
      required BuildContext context}) {
    return showDialog(
        context: context,
        barrierDismissible: barrierDismissible, // user must tap button!
        builder: (BuildContext context) {
          Widget? titleWidget = title != ""
              ? Text(
                  title,
                  style: titleStyle ??
                      Get.find<AppFonts>().L(
                          isBold: true,
                          color: Get.find<AppColors>().dialogTextColor),
                )
              : null;
          List<Widget>? actions;
          if (noAction == false) {
            actions = [
              TextButton(
                child: Text(hideText,
                    style: hideTextStyle ??
                        Get.find<AppFonts>()
                            .M(color: Get.find<AppColors>().dialogHintColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ];
          }
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              contentPadding: zeroPadding
                  ? EdgeInsets.zero
                  : const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
              title: titleWidget,
              backgroundColor:
                  bgColor ?? Get.find<AppColors>().dialogBackgroundColor,
              content: SingleChildScrollView(
                child: ListBody(children: <Widget>[child]),
              ),
              actions: actions,
            );
          });
        });
  }
}

class AppLanguages {
  List<String> languages;

  String initLanguge;
  AppLanguages({required this.languages, required this.initLanguge});
}

class AppAppearances {
  List<Appearance> appearances;

  Appearance initAppearance;
  AppAppearances({required this.appearances, required this.initAppearance});
}

class AppPages {
  List<RixaPage> pages;
  Widget? errorPage;
  String initPage;

  AppPages({required this.pages, required this.initPage, this.errorPage}) {
    int index = pages.indexWhere((element) => element.name == initPage);
    if (pages[index].redirectFrom == null) {
      pages[index].redirectFrom = ["/"];
    } else {
      if (!pages[index].redirectFrom!.any((element) => element == "/")) {
        pages[index].redirectFrom!.add("/");
      }
    }
  }
}
