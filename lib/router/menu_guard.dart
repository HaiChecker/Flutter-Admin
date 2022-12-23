import 'package:auto_route/auto_route.dart';
import 'package:flutter_admin/router/router_info.dart';

class MenuGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    List<String> names = [];
    var route = resolver.route;
    while(route.hasChildren){
      route = route.children!.first;
      names.add(route.name);
    }
    AdminRouter().setNewNav(names);
    AdminRouter().routerUpdate(route.name);
    resolver.next(true);
  }
}
