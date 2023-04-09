import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rixa/models/page_base.dart';
import 'package:rixa/models/route_properties.dart';
import 'package:rixa/state_widgets/rixa_page_viewer.dart';
import '../functions/functions.dart';
import '../rixa.dart';
import 'unknown_route_page.dart';

class RixaMaterial extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final RouterConfig<Object>? routerConfig;
  final BackButtonDispatcher? backButtonDispatcher;
  final String title;
  final String Function(BuildContext)? onGenerateTitle;
  final Color? color;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme, highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Widget Function(BuildContext, Widget?)? builder;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Locale? Function(List<Locale>?, Iterable<Locale>)?
      localeListResolutionCallback;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay,
      checkerboardRasterCacheImages,
      checkerboardOffscreenLayers,
      showSemanticsDebugger,
      debugShowCheckedModeBanner,
      useInheritedMediaQuery;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  const RixaMaterial({
    Key? key,
    this.scaffoldMessengerKey,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.title = '',
    this.onGenerateTitle,
    this.builder,
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
  }) : super(key: key);

  @override
  State<RixaMaterial> createState() => _RixaMaterialState();
}

class _RixaMaterialState extends State<RixaMaterial> {
  late final GoRouter router;
  late final List<GetPage> getPages;

  _RixaMaterialState() {
    {
      router = GoRouter(
        initialLocation: Get.find<PageManager>().initialRoute,
        routes: [
          for (var page in Get.find<PageManager>().pages)
            if (page is RixaPage)
              GoRoute(
                path: page.route,
                name: page.name,
                redirect: (context, state) =>
                    page.redirectRoute(state.params, state.location),
                pageBuilder: (context, state) {
                  if (state.location.split("/").length ==
                      page.fullRoute.split("/").length) {
                    Get.find<PageManager>().initRoute(
                        params: state.params,
                        context: context,
                        route: paramsConverter(
                            path: page.route, params: state.params),
                        mainPage: page,
                        currentPage: page);
                  }
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: page.builder != null
                        ? page.builder!(
                            context,
                            RouteProperties(
                                route: paramsConverter(
                                    path: page.route, params: state.params),
                                name: page.name,
                                params: state.params))
                        : Material(
                            child: Placeholder(
                              child: Center(
                                  child: Text(
                                "RixaPage named {${page.name}} doesn't have any builder!",
                                style: Rixa.appFonts.M(color: Colors.blue),
                              )),
                            ),
                          ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  );
                },
                routes: getRoutes(
                    children: page.children, route: page.route, main: page),
              )
            else if (page is NestedPage)
              ShellRoute(
                builder: (context, state, widget) {
                  return page.builder(
                      context,
                      RouteProperties(
                          route: state.location,
                          name: "",
                          params: state.params),
                      widget);
                },
                routes:
                    getRoutes(children: page.children, route: "", main: null),
              )
        ],
        errorPageBuilder: (context, state) {
          Get.find<PageManager>()
              .initErrorPage(route: state.location, params: state.params);
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: Get.find<PageManager>().unknownRoutePage ??
                const UnknownRoutePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      );
      //getPages = [
      //  GetPage(
      //    name: "/404",
      //    page: () =>
      //        Get.find<PageManager>().unknownRoutePage ??
      //        const UnknownRoutePage(),
      //  ),
      //  for (var page in Get.find<PageManager>().pages)
      //    if (page is RixaPage) ...[
      //      GetPage(
      //        name: page.route,
      //        page: () {
      //          {
      //            Get.find<PageManager>().initRoute(
      //                params: Get.parameters,
      //                route: paramsConverter(
      //                    path: page.route, params: Get.parameters),
      //                mainPage: page,
      //                currentPage: page);
      //            return RixaPageViewer(
      //              rixaPage: page,
      //              path: page.route,
      //            );
      //          }
      //        },
      //        middlewares: [GlobalMiddleware()],
      //        children: convertToGetPages(
      //            children: page.children, route: page.route, main: page),
      //      ),
      //    ] else if (page is NestedPage)
      //      for (var nestedChildPage in page.children) ...[
      //        GetPage(
      //          name: nestedChildPage.route,
      //          page: () {
      //            {
      //              Get.find<PageManager>().initRoute(
      //                  params: Get.parameters,
      //                  route: paramsConverter(
      //                      path: nestedChildPage.route,
      //                      params: Get.parameters),
      //                  mainPage: nestedChildPage,
      //                  currentPage: nestedChildPage);
      //              return RixaNestedPageViewer(
      //                nestedPage: page,
      //                rixaPage: nestedChildPage,
      //                path: nestedChildPage.route,
      //              );
      //            }
      //          },
      //          middlewares: [GlobalMiddleware()],
      //          children: convertToGetPages(
      //              children: nestedChildPage.children, route: "", main: null),
      //        ),
      //      ]
      //];
    }
  }

  //List<GetPage> convertToGetPages({
  //  required List<PageBase> children,
  //  required String route,
  //  required RixaPage? main,
  //}) {
  //  return [
  //    for (var child in children)
  //      if (child is RixaPage) ...[
  //        GetPage(
  //          name: child.route,
  //          page: () {
  //            {
  //              NestedPage? nestedPage = child.firstNestedParent;
  //              Get.find<PageManager>().initRoute(
  //                  params: Get.parameters,
  //                  route: paramsConverter(
  //                      path: route + child.route, params: Get.parameters),
  //                  mainPage: main ?? child,
  //                  currentPage: child);
  //              if (nestedPage == null) {
  //                return RixaPageViewer(
  //                    rixaPage: child, path: route + child.route);
  //              } else {
  //                return RixaNestedPageViewer(
  //                  nestedPage: nestedPage,
  //                  rixaPage: child,
  //                  path: route + child.route,
  //                );
  //              }
  //            }
  //          },
  //          children: convertToGetPages(
  //              children: child.children, route: child.route, main: child),
  //        ),
  //      ] else if (child is NestedPage)
  //        for (var nestedChildPage in child.children) ...[
  //          GetPage(
  //            name: nestedChildPage.route,
  //            page: () {
  //              {
  //                Get.find<PageManager>().initRoute(
  //                    params: Get.parameters,
  //                    route: paramsConverter(
  //                        path: route + nestedChildPage.route,
  //                        params: Get.parameters),
  //                    mainPage: main ?? nestedChildPage,
  //                    currentPage: nestedChildPage);
  //                return RixaNestedPageViewer(
  //                  nestedPage: child,
  //                  rixaPage: nestedChildPage,
  //                  path: route + nestedChildPage.route,
  //                );
  //              }
  //            },
  //            children: convertToGetPages(
  //                children: nestedChildPage.children, route: route, main: main),
  //          ),
  //        ]
  //  ];
  //}

  List<RouteBase> getRoutes({
    required List<PageBase> children,
    required String route,
    required RixaPage? main,
  }) {
    return [
      for (var child in children)
        if (child is RixaPage)
          GoRoute(
            path:
                main == null ? child.route : child.route.replaceFirst("/", ""),
            name: child.name,
            redirect: (context, state) =>
                child.redirectRoute(state.params, state.location),
            pageBuilder: (context, state) {
              if (state.location.split("/").length ==
                  child.fullRoute.split("/").length) {
                Get.find<PageManager>().initRoute(
                    params: state.params,
                    context: context,
                    route: paramsConverter(
                        path: route + child.route, params: state.params),
                    mainPage: main ?? child,
                    currentPage: child);
              }
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: child.builder != null
                    ? child.builder!(
                        context,
                        RouteProperties(
                            route: paramsConverter(
                                path: route + child.route,
                                params: state.params),
                            name: child.name,
                            params: state.params))
                    : Material(
                        child: Placeholder(
                          child: Center(
                              child: Text(
                            "RixaPage named {${child.name}} doesn't have any builder!",
                            style: Rixa.appFonts.M(color: Colors.blue),
                          )),
                        ),
                      ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              );
            },
            routes: getRoutes(
                children: child.children,
                route: route + child.route,
                main: main ?? child),
          )
        else if (child is NestedPage)
          ShellRoute(
            builder: (context, state, widget) {
              return child.builder(
                  context,
                  RouteProperties(route: route, name: "", params: state.params),
                  widget);
            },
            routes:
                getRoutes(children: child.children, route: route, main: main),
          )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: widget.scaffoldMessengerKey,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      backButtonDispatcher: widget.backButtonDispatcher,
      builder: (context, child) => widget.builder == null
          ? Stack(
              children: [
                RixaPageBuilder(child: child!),
                const EmojiGifMenuStack(),
              ],
            )
          : widget.builder!(
              context,
              Stack(
                children: [
                  RixaPageBuilder(child: child!),
                  const EmojiGifMenuStack(),
                ],
              )),
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      color: widget.color,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      highContrastTheme: widget.highContrastTheme,
      highContrastDarkTheme: widget.highContrastDarkTheme,
      themeMode: widget.themeMode,
      locale: widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      localeResolutionCallback: widget.localeResolutionCallback,
      supportedLocales: widget.supportedLocales,
      debugShowMaterialGrid: widget.debugShowMaterialGrid,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      shortcuts: widget.shortcuts,
      actions: widget.actions,
      restorationScopeId: widget.restorationScopeId,
      scrollBehavior: widget.scrollBehavior,
      useInheritedMediaQuery: widget.useInheritedMediaQuery,
    );
    //if (kIsWeb) {
    //} else {
    //  return GetMaterialApp.router(
    //    scaffoldMessengerKey: widget.scaffoldMessengerKey,
    //    builder: (context, child) => widget.builder == null
    //        ? Stack(
    //            children: [
    //              RixaPageBuilder(child: child!),
    //              const EmojiGifMenuStack(),
    //            ],
    //          )
    //        : widget.builder!(
    //            context,
    //            Stack(
    //              children: [
    //                RixaPageBuilder(child: child!),
    //                const EmojiGifMenuStack(),
    //              ],
    //            )),
    //    routeInformationParser: GetInformationParser(
    //      initialRoute: Get.find<PageManager>().initialRoute,
    //    ),
    //    getPages: getPages,
    //    title: widget.title,
    //    onGenerateTitle: widget.onGenerateTitle,
    //    color: widget.color,
    //    theme: widget.theme,
    //    darkTheme: widget.darkTheme,
    //    highContrastTheme: widget.highContrastTheme,
    //    highContrastDarkTheme: widget.highContrastDarkTheme,
    //    locale: widget.locale,
    //    localizationsDelegates: widget.localizationsDelegates,
    //    localeListResolutionCallback: widget.localeListResolutionCallback,
    //    localeResolutionCallback: widget.localeResolutionCallback,
    //    supportedLocales: widget.supportedLocales,
    //    debugShowMaterialGrid: widget.debugShowMaterialGrid,
    //    showPerformanceOverlay: widget.showPerformanceOverlay,
    //    checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
    //    checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
    //    showSemanticsDebugger: widget.showSemanticsDebugger,
    //    debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
    //    actions: widget.actions,
    //    scrollBehavior: widget.scrollBehavior,
    //    useInheritedMediaQuery: widget.useInheritedMediaQuery,
    //  );
    //}
  }
}
