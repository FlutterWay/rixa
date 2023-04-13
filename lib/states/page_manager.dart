// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rixa/functions/functions.dart';
import 'package:rixa/models/page_base.dart';
import 'package:rixa/models/route_properties.dart';
import 'package:rixa/rixa.dart';
import 'package:go_router/go_router.dart';
import '../models/font_size.dart';
import '../models/que_route.dart';

class PageManager extends GetxController {
  List<PageBase> _pages = [];
  RixaPage? _mainPage;
  RixaPage? _currentPage;
  List<QueRoute> pageQue = [];
  UnknownRoutePage? _unknownRoutePage;
  late ScreenModeLimits defaultLimits;
  Map<String, dynamic>? _deliveringItem;
  late final String _initialRoute;
  //int routedPageCounts = 0;

  String get initialRoute => _initialRoute;

  RouteProperties? _route;

  UnknownRoutePage? get unknownRoutePage => _unknownRoutePage;

  RouteProperties? get route => _route;
  RixaPage? get currentPage => _currentPage;

  ScreenModeLimits get currentPageLimits =>
      (_mainPage != null && _mainPage!.screenModeLimits != null)
          ? _mainPage!.screenModeLimits!
          : defaultLimits;

  get deliverinItem => _deliveringItem;
  FutureOr<String?> get currentPageDescription {
    if (_currentPage != null && _currentPage!.description != null) {
      FutureOr<String> func = _currentPage!.description!(_route!);
      if (func is Future<String>) {
        return func.then((value) => value);
      }
      return func;
    } else {
      return null;
    }
  }
  //set setStateUpdater(void Function() stateUpdater) {
  //  _stateListeners.add(stateUpdater);
  //}

  bool pageChanged = false;
  void initRoute(
      {required String? route,
      required RixaPage mainPage,
      required BuildContext context,
      required RixaPage currentPage,
      Map<String, String?>? params}) {
    _route =
        RouteProperties(route: route, name: currentPage.name, params: params);
    if (pageQue.isNotEmpty && pageQue.last.route == route) {
      pageQue.removeLast();
    }
    _currentPage = currentPage;

    if (kIsWeb && currentPage.description != null) {
      FutureOr<String?> func = currentPage.description!(_route!);
      if (func is Future<String?>) {
        func.then((value) {
          if (_currentPage == currentPage && value != null) {
            _updatePageDescription(value, context);
          }
        });
      } else {
        if (func != null) {
          _updatePageDescription(func, context);
        }
      }
    }
    //routedPageCounts++;
  }

  void _updatePageDescription(String description, BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: description,
      primaryColor:
          Theme.of(context).primaryColor.value, // This line is required
    ));
  }

  void initErrorPage(
      {required String? route,
      required Map<String, String?>? params,
      required BuildContext context}) {
    //routedPageCounts++;
    _currentPage = null;
    _route = RouteProperties(route: route, name: null, params: params);
    if (kIsWeb &&
        _unknownRoutePage != null &&
        _unknownRoutePage!.description != null) {
      FutureOr<String?> func = _unknownRoutePage!.description!(_route!);
      if (func is Future<String?>) {
        func.then((value) {
          if (_currentPage == currentPage && value != null) {
            _updatePageDescription(value, context);
          }
        });
      } else {
        if (func != null) {
          _updatePageDescription(func, context);
        }
      }
    }
  }

  set setAppPages(AppPages pages) {
    _pages = pages.pages;
    _initialRoute = pages.initialRoute;
    _unknownRoutePage = pages.unknownRoutePage;
  }

  List<PageBase> get pages => _pages;

  ScreenModeLimits? getPageScreenModeLimits(String name) {
    RixaPage? page = searchPage(name);
    if (page != null) {
      ScreenModeLimits? screenModeLimits = page.screenModeLimits;
      if (screenModeLimits == null && page.parent != null) {
        screenModeLimits = _searchParentLimits(page.parent!);
      }
      return screenModeLimits ?? defaultLimits;
    }
    return null;
  }

  ScreenModeLimits? _searchParentLimits(PageBase parent) {
    if (parent.screenModeLimits != null) {
      return parent.screenModeLimits;
    } else if (parent.parent != null) {
      return _searchParentLimits(parent.parent!);
    } else {
      return null;
    }
  }

  String getPageFontFamily(String name, SizeType type) {
    RixaPage? page = searchPage(name);
    if (page != null) {
      switch (type) {
        case SizeType.small:
          String? fontFamily;
          if (page.fonts != null) {
            fontFamily = page.fonts!.fontFamily_small ??
                (page.parent != null
                    ? _searchParentFontFamily(page.parent!, SizeType.small)
                    : null);
          }
          return fontFamily ?? Get.find<AppFonts>().defaultFontFamily;
        case SizeType.medium:
          String? fontFamily;
          if (page.fonts != null) {
            fontFamily = page.fonts!.fontFamily_medium ??
                (page.parent != null
                    ? _searchParentFontFamily(page.parent!, SizeType.medium)
                    : null);
          }
          return fontFamily ?? Get.find<AppFonts>().defaultFontFamily;
        case SizeType.large:
          String? fontFamily;
          if (page.fonts != null) {
            fontFamily = page.fonts!.fontFamily_large ??
                (page.parent != null
                    ? _searchParentFontFamily(page.parent!, SizeType.large)
                    : null);
          }
          return fontFamily ?? Get.find<AppFonts>().defaultFontFamily;
        case SizeType.mega:
          String? fontFamily;
          if (page.fonts != null) {
            fontFamily = page.fonts!.fontFamily_mega ??
                (page.parent != null
                    ? _searchParentFontFamily(page.parent!, SizeType.mega)
                    : null);
          }
          return fontFamily ?? Get.find<AppFonts>().defaultFontFamily;
      }
    }
    return Get.find<AppFonts>().defaultFontFamily;
  }

  String? _searchParentFontFamily(PageBase parent, SizeType type) {
    switch (type) {
      case SizeType.small:
        return parent.fonts != null
            ? parent.fonts!.fontFamily_small ??
                (parent.parent != null
                    ? _searchParentFontFamily(parent.parent!, type)
                    : null)
            : null;
      case SizeType.medium:
        return parent.fonts != null
            ? parent.fonts!.fontFamily_medium ??
                (parent.parent != null
                    ? _searchParentFontFamily(parent.parent!, type)
                    : null)
            : null;
      case SizeType.large:
        return parent.fonts != null
            ? parent.fonts!.fontFamily_large ??
                (parent.parent != null
                    ? _searchParentFontFamily(parent.parent!, type)
                    : null)
            : null;
      case SizeType.mega:
        return parent.fonts != null
            ? parent.fonts!.fontFamily_mega ??
                (parent.parent != null
                    ? _searchParentFontFamily(parent.parent!, type)
                    : null)
            : null;
    }
  }

  Map<String, String>? getParamsOfRoute(String route) {
    return null;
  }

  RixaPage? searchGetxRoute(String route) {
    for (var page in pages) {
      if (page is RixaPage &&
          paramsConverter(path: page.fullRoute, params: Get.parameters) ==
              route) {
        return page;
      } else {
        RixaPage? tmp = searchChildrenRoute(page, route);
        if (tmp != null) {
          return tmp;
        }
      }
    }
    return null;
  }

  RixaPage? searchChildrenRoute(PageBase page, String route) {
    for (var child in page.children) {
      if (child is RixaPage &&
          paramsConverter(path: child.fullRoute, params: Get.parameters) ==
              route) {
        return child;
      } else {
        RixaPage? tmp = searchChildrenRoute(child, route);
        if (tmp != null) {
          return tmp;
        }
      }
    }
    return null;
  }

  PageFonts? getPageFonts(String name) {
    RixaPage? page = searchPage(name);
    if (page != null) {
      PageFonts fonts = page.fonts ?? PageFonts();
      if (page.parent != null) {
        fonts = _searchParentFonts(fonts, page.parent!);
      }
      return fonts;
    }
    return null;
  }

  PageFonts _searchParentFonts(PageFonts fonts, PageBase parent) {
    PageFonts fontsTmp = PageFonts(
      font_coeff: fonts.font_coeff ??
          (parent.fonts != null ? parent.fonts!.font_coeff : null),
      text_small: fonts.text_small ??
          (parent.fonts != null ? parent.fonts!.text_small : null),
      text_medium: fonts.text_medium ??
          (parent.fonts != null ? parent.fonts!.text_medium : null),
      text_large: fonts.text_large ??
          (parent.fonts != null ? parent.fonts!.text_large : null),
      text_mega: fonts.text_mega ??
          (parent.fonts != null ? parent.fonts!.text_mega : null),
      text_small_ratio: fonts.text_small_ratio ??
          (parent.fonts != null ? parent.fonts!.text_small_ratio : null),
      text_medium_ratio: fonts.text_medium_ratio ??
          (parent.fonts != null ? parent.fonts!.text_medium_ratio : null),
      text_large_ratio: fonts.text_large_ratio ??
          (parent.fonts != null ? parent.fonts!.text_large_ratio : null),
      text_mega_ratio: fonts.text_mega_ratio ??
          (parent.fonts != null ? parent.fonts!.text_mega_ratio : null),
      fontFamily: fonts.fontFamily ??
          (parent.fonts != null ? parent.fonts!.fontFamily : null),
      fontFamily_small: fonts.fontFamily_small ??
          (parent.fonts != null ? parent.fonts!.fontFamily_small : null),
      fontFamily_medium: fonts.fontFamily_medium ??
          (parent.fonts != null ? parent.fonts!.fontFamily_medium : null),
      fontFamily_large: fonts.fontFamily_large ??
          (parent.fonts != null ? parent.fonts!.fontFamily_large : null),
      fontFamily_mega: fonts.fontFamily_mega ??
          (parent.fonts != null ? parent.fonts!.fontFamily_mega : null),
      icon_small: fonts.icon_small ??
          (parent.fonts != null ? parent.fonts!.icon_small : null),
      icon_medium: fonts.icon_medium ??
          (parent.fonts != null ? parent.fonts!.icon_medium : null),
      icon_large: fonts.icon_large ??
          (parent.fonts != null ? parent.fonts!.icon_large : null),
      icon_mega: fonts.icon_mega ??
          (parent.fonts != null ? parent.fonts!.icon_mega : null),
      icon_small_ratio: fonts.icon_small_ratio ??
          (parent.fonts != null ? parent.fonts!.icon_small_ratio : null),
      icon_medium_ratio: fonts.icon_medium_ratio ??
          (parent.fonts != null ? parent.fonts!.icon_medium_ratio : null),
      icon_large_ratio: fonts.icon_large_ratio ??
          (parent.fonts != null ? parent.fonts!.icon_large_ratio : null),
      icon_mega_ratio: fonts.icon_mega_ratio ??
          (parent.fonts != null ? parent.fonts!.icon_mega_ratio : null),
    );
    if (parent.parent != null) {
      return _searchParentFonts(fontsTmp, parent.parent!);
    } else {
      return fontsTmp;
    }
  }

  RixaPage? searchPage(String name) {
    for (var page in _pages) {
      if (page is RixaPage && name == page.name) {
        return page;
      } else {
        RixaPage? tmp = _searchPageInChildren(page.children, name);
        if (tmp != null) {
          return tmp;
        }
      }
    }
    return null;
  }

  RixaPage? _searchPageInChildren(List<PageBase> children, String name) {
    for (var page in children) {
      if (page is RixaPage && name == page.name) {
        return page;
      } else {
        RixaPage? tmp = _searchPageInChildren(page.children, name);
        if (tmp != null) {
          return tmp;
        }
      }
    }
    return null;
  }

  Future<void> goNamed({
    required String name,
    Map<String, dynamic>? item,
    dynamic Function()? quickDispose,
    required BuildContext context,
  }) async {
    if (_route != null) {
      _deliveringItem = item;
      pageQue.add(QueRoute(route: _route!.route!, type: NavigationType.go));
      if (quickDispose != null) {
        await quickDispose();
      }
      GoRouter.of(context).goNamed(name);
      //if (kIsWeb) {
      //} else {
      //  Get.rootDelegate.toNamed(searchPage(name)!.fullRoute);
      //}
    }
  }

  Future<void> go({
    required String route,
    Map<String, dynamic>? item,
    dynamic Function()? quickDispose,
    required BuildContext context,
  }) async {
    if (_route != null) {
      _deliveringItem = item;
      pageQue.add(QueRoute(route: _route!.route!, type: NavigationType.go));
      if (quickDispose != null) {
        await quickDispose();
      }
      GoRouter.of(context).go(route);
      //if (kIsWeb) {
      //} else {
      //  Get.rootDelegate.toNamed(route);
      //}
    }
  }

  Future<void> push({
    required String route,
    Map<String, dynamic>? item,
    dynamic Function()? onPop,
    required BuildContext context,
  }) async {
    if (_route != null) {
      _deliveringItem = item;
      pageQue.add(QueRoute(route: _route!.route!, type: NavigationType.push));
      await GoRouter.of(context).push(route);
      if (onPop != null) onPop();
    }
  }

  Future<void> pushNamed({
    required String name,
    Map<String, dynamic>? item,
    dynamic Function()? onPop,
    required BuildContext context,
  }) async {
    if (_route != null) {
      _deliveringItem = item;
      pageQue.add(QueRoute(route: _route!.route!, type: NavigationType.push));
      await GoRouter.of(context).pushNamed(name);
      if (onPop != null) onPop();
    }
  }

  void pushReplacement({
    required String route,
    Map<String, dynamic>? item,
    required BuildContext context,
  }) {
    if (_route != null) {
      _deliveringItem = item;
      pageQue.add(QueRoute(
          route: _route!.route!, type: NavigationType.pushReplacement));
      GoRouter.of(context).pushReplacement(route);
    }
  }

  void pushReplacementNamed({
    required String name,
    Map<String, dynamic>? item,
    required BuildContext context,
  }) {
    if (_route != null) {
      _deliveringItem = item;
      pageQue.add(QueRoute(
          route: _route!.route!, type: NavigationType.pushReplacement));
      GoRouter.of(context).pushReplacementNamed(name);
    }
  }

  void pop(BuildContext context) async {
    GoRouter.of(context).pop();
  }

  bool canPop(BuildContext context) {
    return GoRouter.of(context).canPop();
  }

  Future<bool> goToPreviousPage(
      {required BuildContext context,
      Map<String, dynamic>? item,
      dynamic Function()? quickDispose}) async {
    if (pageQue.isNotEmpty) {
      _deliveringItem = item;
      QueRoute queRoute = pageQue.removeLast();
      if (quickDispose != null) {
        await quickDispose();
      }
      switch (queRoute.type) {
        case NavigationType.go:
          GoRouter.of(context).go(queRoute.route);
          break;
        case NavigationType.push:
          Navigator.pop(context, item);
          break;
        case NavigationType.pushReplacement:
          Navigator.pop(context, item);
          break;
      }
      return false;
    } else {
      return true;
    }
  }
}
