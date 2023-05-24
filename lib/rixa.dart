library rixa;

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_gif_picker/flutter_emoji_gif_picker.dart'
    as flutter_emoji_gif_picker;
import 'package:get/get.dart';

import 'package:rixa/models/page_base.dart';
import 'package:rixa/models/route_properties.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/mode.dart';
import 'models/rixa_properties.dart';
import 'models/screen_mode_limits.dart';
import 'models/unknown_route_page.dart';
import 'states/app_colors.dart';
import 'states/app_fonts.dart';
import 'states/app_settings.dart';
import 'states/page_manager.dart';
import 'widgets/crop_image.dart' as crop_image;

export 'package:flutter_emoji_gif_picker/views/emoji_gif_menu_stack.dart';
export 'package:flutter_emoji_gif_picker/views/emoji_gif_picker_icon.dart';
export 'package:flutter_emoji_gif_picker/views/emoji_gif_picker_builder.dart';
export 'package:flutter_emoji_gif_picker/models/menu_design.dart';
export 'package:flutter_emoji_gif_picker/views/emoji_gif_menu_layout.dart';
export 'package:flutter_emoji_gif_picker/views/emoji_gif_textfield.dart';
export 'package:flutter_emoji_gif_picker/models/layout_mode.dart';
export 'models/emoji_gif_picker_panel.dart';
import 'models/emoji_gif_picker_config.dart';

export 'package:file_picker/file_picker.dart';
export 'extensions/page_state.dart';
export 'extensions/string.dart';
export 'models/connection_status.dart';
export 'models/nested_page.dart';
export 'models/device_type.dart';
export 'models/rixa_page.dart';
export 'models/page_fonts.dart';
export 'models/unknown_route_page.dart';
export 'models/page_transition.dart';
export 'models/rixa_properties.dart';
export 'models/screen_mode_limits.dart';
export 'state_widgets/rixa_builder.dart';
export 'state_widgets/rixa_material.dart';
export 'state_widgets/rixa_text.dart';
export 'states/app_colors.dart';
export 'states/app_fonts.dart';
export 'states/app_settings.dart';
export 'states/page_manager.dart';
export 'variables/time_variables.dart';
export 'widgets/check_box.dart';
export 'widgets/checkbox_list.dart';
export 'widgets/child_expanded.dart';
export 'widgets/expanded_widget.dart';
export 'widgets/crop_image.dart';
export 'widgets/download_btn.dart';
export 'widgets/drop_down.dart';
export 'widgets/expanded_container.dart';
export 'widgets/expanded_text.dart';
export 'widgets/expanded_text_button.dart';
export 'widgets/file_icon.dart';
export 'widgets/file_type.dart';
export 'widgets/glass_morphism.dart';
export 'widgets/icon_of_file.dart';
export 'widgets/image_avatar.dart';
export 'widgets/inf_container.dart';
export 'widgets/line_chart.dart';
export 'widgets/liquid_loading_bar.dart';
export 'widgets/middle_of_expanded.dart';
export 'widgets/passwordfield.dart';
export 'widgets/profile_avatar.dart';
export 'widgets/radio_button_list.dart';
export 'widgets/region_bar.dart';
export 'widgets/rixa_textfield.dart';
export 'widgets/rixa_player/rixa_player.dart';
export 'widgets/sized_button.dart';
export 'widgets/textfield_chat.dart';
export 'widgets/markdown/markdown_widget.dart';
export 'widgets/markdown/models/code_config.dart';
export 'widgets/markdown/models/image_config.dart';
export 'widgets/markdown/models/latex_config.dart';
export 'widgets/markdown/models/link_config.dart';
export 'widgets/markdown/models/text_config.dart';

class Rixa {
  static Future<void> setup(
      {required AppPages pages,
      AppAppearances? appearances,
      AppLanguages? languages,
      ScreenModeLimits? screenModeLimits,
      EmojiGifPickerConfig? emojiGifPickerConfig,
      bool? staticFonts,
      String? fontFamily}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('rixa-language');
    String? appearance = prefs.getString('rixa-appearance');
    screenModeLimits ??=
        ScreenModeLimits(mobile: 900, landScape: 1200, desktopMini: 1600);
    Get.put(AppSettings());
    if (languages != null) {
      if (language != null &&
          languages.languages.any((element) => element == language)) {
        languages.initLanguge = language;
      } else if (language == null) {
        await prefs.setString('rixa-language', languages.initLanguge);
      }
      Get.find<AppSettings>().setAppLanguages = languages;
    }
    Get.put(AppFonts());
    if (appearances != null) {
      if (appearance != null &&
          appearances.appearances
              .any((element) => element.name == appearance)) {
        appearances.initAppearance = appearances.appearances
            .singleWhere((element) => element.name == appearance);
      } else if (appearance == null) {
        await prefs.setString(
            'rixa-appearance', appearances.initAppearance.name);
      }
      Get.put(AppColors.withAppearances(appearances));
    }
    Get.put(PageManager());
    Get.find<PageManager>().setAppPages = pages;
    Get.find<AppFonts>().defaultFontFamily = fontFamily ?? 'Lato';
    Get.find<AppFonts>().isStaticDefault = staticFonts;
    Get.find<PageManager>().defaultLimits = screenModeLimits;
    late flutter_emoji_gif_picker.Mode emojiMode;
    if (emojiGifPickerConfig != null) {
      emojiMode = emojiGifPickerConfig.mode == Mode.dark
          ? flutter_emoji_gif_picker.Mode.dark
          : flutter_emoji_gif_picker.Mode.light;
    } else {
      emojiMode = flutter_emoji_gif_picker.Mode.light;
    }
    flutter_emoji_gif_picker.EmojiGifPickerPanel.setup(
      giphyApiKey: emojiGifPickerConfig?.giphyApiKey,
      mode: emojiMode,
      sizes: emojiGifPickerConfig?.sizes,
      texts: emojiGifPickerConfig?.texts,
      colors: emojiGifPickerConfig?.colors,
      styles: emojiGifPickerConfig?.styles,
    );
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
  static RouteProperties? get route => Get.find<PageManager>().route;

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
                      Get.find<AppFonts>().small4(
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
                        Get.find<AppFonts>().small3(
                            color: Get.find<AppColors>().dialogHintColor)),
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

  static Future<List<PlatformFile>?> pickFile({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    dynamic Function(FilePickerStatus)? onFileLoading,
    bool allowCompression = true,
    bool allowMultiple = false,
    bool withData = false,
    bool withReadStream = false,
    bool lockParentWindow = false,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    return result?.files;
  }

  static void cropImage({
    required BuildContext context,
    required Uint8List mainImage,
    String? text,
    String saveText = "Save",
    String resetText = "Reset",
    String previewText = "Preview",
    String title = "Crop image as 1/1 ratio",
    void Function(Uint8List)? onChanged,
  }) {
    crop_image.cropImage(
        context: context,
        mainImage: mainImage,
        text: text,
        saveText: saveText,
        resetText: resetText,
        previewText: previewText,
        title: title,
        onChanged: onChanged);
  }
  //static Future<List<gallery_picker.MediaFile>?> pickMedia({
  //  required BuildContext context,
  //  gallery_picker.Config? config,
  //  bool startWithRecent = false,
  //  bool singleMedia = false,
  //  gallery_picker.PageTransitionType pageTransitionType =
  //      gallery_picker.PageTransitionType.rightToLeft,
  //  List<gallery_picker.MediaFile>? initSelectedMedia,
  //  List<gallery_picker.MediaFile>? extraRecentMedia,
  //}) async {
  //  return await gallery_picker.GalleryPicker.pickMedia(
  //      context: context,
  //      config: config,
  //      singleMedia: singleMedia,
  //      startWithRecent: startWithRecent,
  //      pageTransitionType: pageTransitionType,
  //      extraRecentMedia: extraRecentMedia,
  //      initSelectedMedia: initSelectedMedia);
  //}
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
  List<PageBase> pages;
  UnknownRoutePage? unknownRoutePage;
  String initialRoute;

  AppPages(
      {required this.pages, required this.initialRoute, this.unknownRoutePage});
}
