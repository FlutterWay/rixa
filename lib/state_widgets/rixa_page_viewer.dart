import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rixa/models/page_base.dart';
import 'package:rixa/rixa.dart';
import '../functions/functions.dart';
import '../models/route_properties.dart';

class RixaPageBuilder extends StatelessWidget {
  final Widget? child;
  const RixaPageBuilder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Rixa.build(context);
    return child ?? const SizedBox();
  }
}

class RixaPageViewer extends StatelessWidget {
  final RixaPage rixaPage;
  final String path;
  const RixaPageViewer({Key? key, required this.rixaPage, required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return rixaPage.builder != null
        ? rixaPage.builder!(
            context,
            RouteProperties(
                route: paramsConverter(path: path, params: Get.parameters),
                name: rixaPage.name,
                params: Get.parameters))
        : Material(
            child: Placeholder(
              child: Center(
                  child: Text(
                "RixaPage named {${rixaPage.name}} doesn't have any builder!",
                style: Rixa.appFonts.M(color: Colors.blue),
              )),
            ),
          );
  }
}

class RixaNestedPageViewer extends StatelessWidget {
  final RixaPage rixaPage;
  final NestedPage nestedPage;
  final String path;
  const RixaNestedPageViewer(
      {Key? key,
      required this.rixaPage,
      required this.nestedPage,
      required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget view = nestedPage.builder(
        context,
        RouteProperties(route: path, name: "", params: Get.parameters),
        rixaPage.builder != null
            ? rixaPage.builder!(
                context,
                RouteProperties(
                    route: paramsConverter(path: path, params: Get.parameters),
                    name: rixaPage.name,
                    params: Get.parameters))
            : Material(
                child: Placeholder(
                  child: Center(
                      child: Text(
                    "RixaPage named {${rixaPage.name}} doesn't have any builder!",
                    style: Rixa.appFonts.M(color: Colors.blue),
                  )),
                ),
              ));
    PageBase? grandParent = nestedPage.parent;
    return grandParent != null && grandParent is RixaPage
        ? checkPreviousNesteds(view, grandParent, context)
        : view;
  }

  Widget checkPreviousNesteds(
      Widget view, RixaPage parent, BuildContext context) {
    if (parent.parent != null && parent.parent is NestedPage) {
      NestedPage nested = parent.parent! as NestedPage;
      Widget addedView = nested.builder(context,
          RouteProperties(route: path, name: "", params: Get.parameters), view);
      PageBase? grandParent = parent.parent!.parent;
      return grandParent != null && grandParent is RixaPage
          ? checkPreviousNesteds(addedView, grandParent, context)
          : addedView;
    } else {
      return view;
    }
  }
}
