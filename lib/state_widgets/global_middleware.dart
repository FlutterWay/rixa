//import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//import 'package:get/get_navigation/src/root/parse_route.dart';
//
//import '../rixa.dart';

//class GlobalMiddleware extends GetMiddleware {
//  GlobalMiddleware();
//  @override
//  RouteSettings? redirect(String? route) {
//    print("redirect");
//    if (route != null) {
//      Uri uri = Uri.parse(route);
//      String keepParams = uri.toString();
//
//      RouteDecoder match = Get.routeTree.matchRoute(keepParams);
//      String path = match.treeBranch.last.name;
//      if (path != route) {
//        return const RouteSettings(name: "/404");
//      } else {
//        RixaPage? rixaPage = Get.find<PageManager>().searchGetxRoute(route);
//        String? redirect;
//        if (rixaPage != null &&
//            rixaPage.redirectRoute(Get.parameters, route) is! Future<String?>) {
//          redirect = rixaPage.redirectRoute(Get.parameters, route) as String?;
//        }
//        return redirect == null || redirect == route
//            ? null
//            : RouteSettings(name: redirect);
//      }
//    } else {
//      return null;
//    }
//  }
//
//  @override
//  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
//    String? location = route.location;
//    print(Rixa.pageManager.routedPageCounts);
//    if (Rixa.pageManager.routedPageCounts == 0) {
//      return GetNavConfig.fromRoute(Rixa.pageManager.initialRoute);
//    }
//    print("redirectDelegate:$location");
//    if (location != null) {
//      Uri uri = Uri.parse(location);
//      String keepParams = uri.toString();
//
//      RouteDecoder match = Get.routeTree.matchRoute(keepParams);
//      String path = match.treeBranch.last.name;
//      print("path:$path");
//      print(Get.find<PageManager>().initialRoute);
//      if (path != location) {
//        return GetNavConfig.fromRoute("/404");
//      } else {
//        RixaPage? rixaPage = Get.find<PageManager>().searchGetxRoute(location);
//        String? redirect;
//        print("lol");
//        if (rixaPage != null &&
//            rixaPage.redirectRoute(Get.parameters, location)
//                is Future<String?>) {
//          redirect = await rixaPage.redirectRoute(Get.parameters, location);
//          print("redirect:$redirect");
//        }
//        return redirect == null || redirect == location
//            ? GetNavConfig.fromRoute(location)
//            : GetNavConfig.fromRoute(redirect);
//      }
//    } else {
//      return null;
//    }
//  }
//}
