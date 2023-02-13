import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../functions/functions.dart';
import '../rixa.dart';

class RixaMaterial extends StatelessWidget {
  late GoRouter router;
  Widget pageControlPanel;
  GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  RouteInformationProvider? routeInformationProvider;
  RouteInformationParser<Object>? routeInformationParser;
  RouterDelegate<Object>? routerDelegate;
  RouterConfig<Object>? routerConfig;
  BackButtonDispatcher? backButtonDispatcher;
  List<Widget>? widgetsInBuilder;
  String title = '';
  String Function(BuildContext)? onGenerateTitle;
  Color? color;
  ThemeData? theme;
  ThemeData? darkTheme;
  ThemeData? highContrastTheme, highContrastDarkTheme;
  ThemeMode? themeMode;
  Locale? locale;
  Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  Locale? Function(List<Locale>?, Iterable<Locale>)?
      localeListResolutionCallback;
  Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  Iterable<Locale> supportedLocales;
  bool debugShowMaterialGrid;
  bool showPerformanceOverlay,
      checkerboardRasterCacheImages,
      checkerboardOffscreenLayers,
      showSemanticsDebugger,
      debugShowCheckedModeBanner,
      useInheritedMediaQuery;
  Map<ShortcutActivator, Intent>? shortcuts;
  Map<Type, Action<Intent>>? actions;
  String? restorationScopeId;
  ScrollBehavior? scrollBehavior;
  RixaMaterial({
    Key? key,
    required this.pageControlPanel,
    this.scaffoldMessengerKey,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.widgetsInBuilder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.useInheritedMediaQuery = false,
  }) : super(key: key) {
    widgetsInBuilder ??= [];
    pageControlPanel = KeyboardSizeProvider(
      child: pageControlPanel,
    );
    router = GoRouter(
      routes: [
        for (var page in Get.find<PageManager>().pages) ...[
          if (page.children != null) ...[
            GoRoute(
              path: page.route,
              name: page.name,
              redirect: (context, state) => (page.checkRedirect != null &&
                      page.checkRedirect!(page.route) != null)
                  ? page.checkRedirect!(page.route)
                  : page.redirect != null
                      ? (page.route + page.redirect!)
                      : null,
              pageBuilder: (context, state) {
                page.params = state.params;
                Get.find<PageManager>().initRoute(
                    params: state.params,
                    route:
                        paramsConverter(path: page.route, params: state.params),
                    pageRoute: page.route);
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  maintainState: false,
                  child: pageControlPanel,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                );
              },
            ),
            ...getRoutes(
                children: page.children!, route: page.route, page: page.page())
          ] else
            GoRoute(
                path: page.route,
                name: page.name,
                redirect: (context, state) => (page.checkRedirect != null &&
                        page.checkRedirect!(page.route) != null)
                    ? page.checkRedirect!(page.route)
                    : page.redirect,
                pageBuilder: (context, state) {
                  page.params = state.params;
                  Get.find<PageManager>().initRoute(
                      params: state.params,
                      route: paramsConverter(
                          path: page.route, params: state.params),
                      pageRoute: page.route);
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: pageControlPanel,
                    maintainState: false,
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  );
                }),
          if (page.redirectFrom != null)
            for (var redirect in page.redirectFrom!)
              GoRoute(
                  path: redirect,
                  redirect: (context, state) => (page.checkRedirect != null &&
                          page.checkRedirect!(page.route) != null)
                      ? page.checkRedirect!(page.route)
                      : page.route),
        ]
      ],
      errorPageBuilder: (context, state) {
        Get.find<PageManager>()
            .initRoute(route: state.location, pageRoute: state.location, params: state.params);
        return CustomTransitionPage<void>(
          key: state.pageKey,
          maintainState: false,
          child: pageControlPanel,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
  List<GoRoute> getRoutes(
      {required List<ChildPage> children,
      required String route,
      required Widget page}) {
    List<GoRoute> routes = [];
    for (var child in children) {
      String path = route + child.route;
      GoRoute? routeItem;
      if (child.redirect != null) {
        routeItem = GoRoute(
            path: path,
            name: child.name,
            redirect: (context, state) =>
                (child.checkRedirect != null && child.checkRedirect!() != null)
                    ? child.checkRedirect!()
                    : path + child.redirect!);
      } else {
        routeItem = GoRoute(
            path: path,
            name: child.name,
            redirect: (context, state) =>
                (child.checkRedirect != null && child.checkRedirect!() != null)
                    ? child.checkRedirect!()
                    : null,
            pageBuilder: (context, state) {
              child.params = state.params;
              Get.find<PageManager>().initRoute(
                  route: paramsConverter(path: path, params: state.params),
                  params: state.params,
                  pageRoute: path);
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: pageControlPanel,
                maintainState: false,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              );
            });
      }

      routes.add(routeItem);
      if (child.children != null) {
        routes = routes +
            getRoutes(children: child.children!, route: path, page: page);
      }
    }
    return routes;
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android ||
        Theme.of(context).platform == TargetPlatform.iOS ||
        Theme.of(context).platform == TargetPlatform.fuchsia) {
      //widgetsInBuilder!.add(RixaEmoji());
    }
    return MaterialApp.router(
      routerConfig: router,
      scaffoldMessengerKey: scaffoldMessengerKey,
      routeInformationProvider: routeInformationProvider,
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate,
      backButtonDispatcher: backButtonDispatcher,
      builder: (context, child) => Stack(
        children: [child!, ...widgetsInBuilder!],
      ),
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: theme,
      darkTheme: darkTheme,
      highContrastTheme: highContrastTheme,
      highContrastDarkTheme: highContrastDarkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      debugShowMaterialGrid: debugShowMaterialGrid,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      scrollBehavior: scrollBehavior,
      useInheritedMediaQuery: useInheritedMediaQuery,
    );
  }
}
