import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rixa/models/route_properties.dart';
import 'package:rixa/rixa.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart' as go_router;

class PageManager extends GetxController {
  List<RixaPage> _pages = [];

  String? _currentPage;
  String? _currentRoute;
  ChildPage? _childPage;
  RixaPage? _mainRoute;
  List<String> pageQue = [];
  Widget? _errorPage;
  late ScreenModeLimits defaultLimits;
  List<dynamic Function()> _disposeFuncs = [];
  List<void Function()> _stateListeners = [];
  Map<String, dynamic>? _deliveringItem;
  Map<String, String>? _params;

  RouteProperties get route => RouteProperties(
      route: _currentRoute, name: _currentPage, params: _params);

  ScreenModeLimits get currentPageLimits =>
      (_mainRoute != null && _mainRoute!.screenModeLimits != null)
          ? _mainRoute!.screenModeLimits!
          : defaultLimits;

  get deliverinItem => _deliveringItem;

  set setDispose(dynamic Function() dispose) {
    _disposeFuncs.add(dispose);
  }

  //set setStateUpdater(void Function() stateUpdater) {
  //  _stateListeners.add(stateUpdater);
  //}

  void setChildRoutes(
      {required List<ChildPage> pages,
      required String route,
      required List<dynamic> fathers}) {
    for (var page in pages) {
      int index = pages.indexOf(page);
      String path = route + page.route;
      if (index != 0) {
        page.setBehind = pages[index - 1];
      }
      if (index != (pages.length - 1)) {
        page.setForward = pages[index + 1];
      }
      page.setFullRoute = path;
      page.setFathers = fathers;
      if (page.children != null) {
        setChildRoutes(
            pages: page.children!, route: path, fathers: [...fathers, page]);
      }
    }
  }

  bool pageChanged = false;
  void initRoute(
      {required String? route,
      required String? pageRoute,
      Map<String, String>? params}) {
    String pageName = "";
    RixaPage? mainRoute;
    ChildPage? childPage;
    if (_currentRoute != route) {
      disposeFunc();
    }
    if (pageRoute != null) {
      for (var page in _pages) {
        if (page.route == pageRoute) {
          mainRoute = page;
          pageName = page.name;
        } else if (page.children != null) {
          ChildPage? routeItem = searchChildRoute(
              pages: page.children!, searchRoute: pageRoute, route: page.route);
          if (routeItem != null) {
            pageName = routeItem.name;
            mainRoute = page;
            childPage = routeItem;
          }
        }
      }
    }
    if (_currentPage != null && _currentPage != pageName) {
      pageChanged = true;
    } else {
      pageChanged = false;
    }
    _currentRoute = route;
    _currentPage = pageName;
    _childPage = childPage;
    _mainRoute = mainRoute;
    _params = params;
  }

  ChildPage? searchChildRoute(
      {required List<ChildPage> pages,
      required String searchRoute,
      required String route}) {
    ChildPage? routeItem;
    for (var page in pages) {
      String path = route + page.route;
      if (path == searchRoute) {
        routeItem = page;
        return routeItem;
      } else if (page.children != null) {
        routeItem = searchChildRoute(
            pages: page.children!, searchRoute: searchRoute, route: path);
      }
    }
    return routeItem;
  }

  set setAppPages(AppPages pages) {
    _pages = pages.pages;
    _currentPage = pages.initPage;
    _errorPage = pages.errorPage;
    for (var page in _pages) {
      if (page.children != null) {
        setChildRoutes(
            pages: page.children!,
            route: page.route,
            fathers: page.redirect == null ? [page] : []);
      }
    }
  }

  List<RixaPage> get pages => _pages;

  Future<void> disposeFunc() async {
    if (_disposeFuncs.isNotEmpty) {
      for (var func in _disposeFuncs) {
        await func();
      }
      _disposeFuncs.clear();
    }
  }

  Future<void> goNamed({
    required String name,
    Map<String, dynamic>? item,
    required BuildContext context,
  }) async {
    if (name != _currentPage) {
      _deliveringItem = item;
      if (_currentRoute != null) pageQue.add(_currentRoute!);
      await disposeFunc();
      GoRouterHelper(context).goNamed(name);
    }
  }

  Future<void> go({
    required String route,
    dynamic item,
    required BuildContext context,
  }) async {
    if (route != _currentRoute) {
      _deliveringItem = item;
      if (_currentRoute != null) pageQue.add(_currentRoute!);
      await disposeFunc();
      GoRouterHelper(context).go(route);
    }
  }

  Future<bool> back(BuildContext context) async {
    if (pageQue.isNotEmpty) {
      String route = pageQue.removeLast();
      await go(route: route, context: context);
      return false;
    } else {
      return true;
    }
  }

  Widget get page {
    if (_mainRoute != null) {
      return _mainRoute!.page();
    } else {
      return _errorPage!;
    }
  }
}
