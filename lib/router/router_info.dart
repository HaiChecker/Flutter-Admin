import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_admin/router/auto_router.gr.dart';
import 'package:flutter_admin/router/menu_guard.dart';

import '../config/logger.dart';

class RouteInfo {
  final String path;
  final String name;
  final String title;
  final IconData? icon;

  List<RouteInfo>? children;
  final bool menu;
  final bool view;
  final bool affix;
  final bool breadcrumb;
  Map<String, dynamic>? runtimePair;
  late String id;
  late String fullPath;

  RouteInfo(
      {required this.path,
      required this.name,
      required this.title,
      this.menu = true,
      this.affix = false,
      this.breadcrumb = true,
      this.view = true,
      this.children,
      this.icon,
      this.runtimePair}) {
    id = "$path$name$title".hashCode.toString();
    fullPath = "";
  }

  bool isChildren() => children != null && children!.isNotEmpty;

  bool isRuntimePair() => runtimePair != null;

  T? getPair<T>(String key) {
    runtimePair ??= {};
    if (!runtimePair!.containsKey(key)) {
      return null;
    }
    try {
      return runtimePair![key];
    } catch (e) {
      return null;
    }
  }

  putPair(String key, dynamic data, {bool replace = false}) {
    runtimePair ??= {};
    if (runtimePair!.containsKey(key)) {
      if (!replace) {
        return;
      }
    }
    runtimePair![key] = data;
  }
}

class AdminRouter extends ChangeNotifier {
  static final AdminRouter _instance = AdminRouter._internal();
  RouteInfo? currentRoute;
  AppRouter appRouter = AppRouter(menuGuard: MenuGuard());
  var nameRouteInfo = <String, RouteInfo>{};
  List<RouteInfo> routeInfo = [];
  Map<String, Map<String, Object>> tips = {};
  List<RouteInfo> parents = [];

  List<RouteInfo> route({List<RouteConfig>? config, RouteInfo? parent}) {
    List<RouteInfo> retData = [];
    if (config == null) {
      return retData;
    }
    var data = config;
    for (int i = 0; i < data.length; i++) {
      var value = data[i];
      if (value.path.isEmpty) {
        continue;
      }
      String title = value.meta['title'] ?? "";
      bool menu = value.meta['menu'] ?? true;
      bool view = value.meta['view'] ?? false;
      IconData? iconData;
      if (value.meta['icon_data'] != null) {
        iconData = IconData(value.meta['icon_data'],
            fontFamily: value.meta['icon_font']);
      }
      bool affix = value.meta['affix'] ?? false;
      String id = i.toString();
      if (parent != null) {
        id = "${parent.id}.$id";
      }
      String fullPath = value.path;
      if (parent != null) {
        fullPath = "${parent.fullPath}/$fullPath";
      }
      fullPath = fullPath.replaceAll("//", "/");

      RouteInfo routeInfo = RouteInfo(
          path: value.path,
          name: value.name,
          title: title,
          menu: menu,
          view: view,
          icon: iconData,
          affix: affix,
          children: []);
      routeInfo.fullPath = fullPath;
      routeInfo.id = id;
      routeInfo.children =
          route(config: value.children?.routes.toList(), parent: routeInfo);
      nameRouteInfo[routeInfo.name] = routeInfo;
      if (routeInfo.affix) {
        // 固定到导航栏
        tips[currentRoute!.name] = {
          'id': routeInfo.id,
          'title': routeInfo.title,
          'affix': routeInfo.affix,
          'name': routeInfo.name,
          'fullPath': routeInfo.fullPath
        };
      }
      retData.add(routeInfo);
    }
    return retData;
  }

  AdminRouter._internal() {
    routeInfo = route(config: appRouter.routes);
  }

  void setNewNav(List<String> names) {
    if (names.isEmpty) {
      return;
    }
    parents.clear();
    parents = names.map((e) {
      return nameRouteInfo[e]!;
    }).toList();
  }

  void routerUpdate(String name) {
    if (nameRouteInfo.containsKey(name)) {
      if (currentRoute?.name == name) {
        return;
      }
      currentRoute = nameRouteInfo[name];
      if (currentRoute != null) {
        // 添加到导航栏 - 不判断是否存在
        tips[currentRoute!.name] = {
          'id': currentRoute!.id,
          'title': currentRoute!.title,
          'affix': currentRoute!.affix,
          'name': currentRoute!.name,
          'fullPath': currentRoute!.fullPath
        };
      }
    }
  }

  factory AdminRouter() {
    return _instance;
  }
}

extension AdminString on String {
  bool eq(dynamic? d) {
    if (d == null) {
      return false;
    }
    return toString() == d.toString();
  }
}
