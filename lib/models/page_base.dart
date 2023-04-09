// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'nested_page.dart';
import 'page_fonts.dart';
import 'screen_mode_limits.dart';

@immutable
abstract class PageBase {
  PageBase({
    // ignore: unused_element
    List<PageBase> children = const <PageBase>[],
    ScreenModeLimits? screenModeLimits,
    PageFonts? fonts,
  })  : _children = children,
        _screenModeLimits = screenModeLimits,
        _fonts = fonts;

  final ScreenModeLimits? _screenModeLimits;
  PageBase? _parent;
  final PageFonts? _fonts;

  /// The list of child pages associated with this page.
  final List<PageBase> _children;

  set setParent(PageBase parent) {
    _parent = parent;
  }

  NestedPage? get firstNestedParent {
    if (parent != null && parent is NestedPage) {
      return parent! as NestedPage;
    } else if (parent != null) {
      return parent!.firstNestedParent;
    } else {
      return null;
    }
  }

  ScreenModeLimits? get screenModeLimits => _screenModeLimits;
  PageBase? get parent => _parent;
  PageFonts? get fonts => _fonts;
  List<PageBase> get children => _children;
}
