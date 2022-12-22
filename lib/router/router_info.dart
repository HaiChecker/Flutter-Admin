import 'package:flutter/material.dart';
import 'package:flutter_admin/config/menu_config.dart';
import 'package:flutter_admin/views/login/login.dart';
import 'package:flutter_admin/views/menu_title.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/logger.dart';
import '../views/index.dart';

class RouteInfo {
  final String path;
  final String name;
  final String title;
  final IconData? icon;

  final List<RouteInfo>? children;
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
      this.runtimePair});

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

final fixedRouters = <RouteInfo>[
  RouteInfo(path: '/login', name: 'Login', title: "登录", menu: false),
  RouteInfo(path: '/', name: 'Index', title: "首页", icon: Icons.home),
  RouteInfo(
      path: '/permission',
      name: 'Permission',
      title: "权限测试",
      view: false,
      icon: Icons.lock_outline,
      children: [
        RouteInfo(path: 'role', name: 'Role', title: "角色权限",affix: true,),
      ]),
  RouteInfo(path: '/icon', name: 'Icon', title: "图标", icon: Icons.image),
  RouteInfo(path: '/chat', name: 'Chat', title: "图表", icon: Icons.table_chart)
];

final dynamicRouters = <RouteInfo>[];

class AdminRouter extends ChangeNotifier {
  static final AdminRouter _instance = AdminRouter._internal();
  late GoRouter goRouter;
  RouteInfo? currentRoute;
  var nameRouteInfo = <String, RouteInfo>{};
  List<RouteInfo> routeInfo = [];
  Map<String, Map<String, Object>> tips = {};

  AdminRouter._internal() {
    routeInfo
      ..addAll(fixedRouters)
      ..addAll(dynamicRouters);

    List<GoRoute> getChild({RouteInfo? parent}) {
      var ret = <GoRoute>[];
      var tempRouteList = (parent?.children ?? routeInfo);
      for (int i = 1; i <= tempRouteList.length; i++) {
        RouteInfo routeInfo = tempRouteList[i - 1];
        String id = i.toString();
        if (parent != null) {
          id = "${parent.id}.$id";
        }
        routeInfo.id = id;

        String fullPath = routeInfo.path;
        if (parent != null) {
          fullPath = "${parent.fullPath}/${fullPath.replaceFirst("/", '')}";
        }
        routeInfo.fullPath = fullPath;
        nameRouteInfo[routeInfo.name] = routeInfo;
        if(routeInfo.affix && routeInfo.menu){
          tips[routeInfo.name] = {
            'name': routeInfo.name,
            'id': routeInfo.id,
            'title': routeInfo.title
          };
        }
        ret.add(GoRoute(
            path: routeInfo.path,
            name: routeInfo.name,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                  child: onRouter(context, state, routeInfo));
            },
            routes: routeInfo.isChildren() ? getChild(parent: routeInfo) : []));
      }
      return ret;
    }

    goRouter = GoRouter(
        routes: getChild(),
        debugLogDiagnostics: true,
        redirect: (context, state) {
          onSelected(state.location);
        });
  }

  factory AdminRouter() {
    return _instance;
  }

  List<RouteInfo> getParent() {
    if (currentRoute == null ||
        !nameRouteInfo.containsKey(currentRoute!.name)) {
      return [];
    }
    RouteInfo data = nameRouteInfo[currentRoute!.name]!;
    var index = data.id.split(".");
    List<RouteInfo> parent = [];

    RouteInfo getChildren(List<RouteInfo> data, int index) {
      return data[index];
    }

    RouteInfo? parentData;
    for (var value in index) {
      parentData =
          getChildren(parentData?.children ?? routeInfo, int.parse(value) - 1);
      parent.add(parentData);
    }
    return parent;
  }

  void onSelected(String? location) {
    if (location != null) {
      var m = goRouter.routeInformationParser.matcher.findMatch(location);
      if (m.last.route is GoRoute) {
        GoRoute route = m.last.route as GoRoute;
        try {
          if (currentRoute?.fullPath == route.path) {
            return;
          }
          currentRoute = nameRouteInfo[route.name];
          logger.i("Router:${currentRoute?.name} - ${currentRoute?.fullPath}");
          if (!tips.containsKey(currentRoute!.name) && currentRoute!.menu) {
            tips[currentRoute!.name] = {
              'name': currentRoute!.name,
              'id': currentRoute!.id,
              'title': currentRoute!.title
            };
          }
        } catch (e) {}
        notifyListeners();
      }
    }
  }

  static Widget onRouter(
      BuildContext context, GoRouterState state, RouteInfo routeInfo) {
    switch (routeInfo.name) {
      case "Index":
        return IndexView();
      case "Login":
        return LoginView();
      default:
        return LoginView();
    }
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
