import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin/style/colors.dart';
import 'package:flutter_admin/views/base_views.dart';
import 'package:flutter_admin/views/title.dart';
import 'package:flutter_admin/widgets/menu/nav_menu.dart';
import 'package:flutter_admin/widgets/menu/nav_menu_define.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../config/menu_config.dart';
import '../router/router_info.dart';
import 'menu_title.dart';

class RouterView extends AdminView {
  RouterView({super.key});

  @override
  State<StatefulWidget> createState() => _RouterView();
}

class _RouterView extends AdminStateView {
  final double _menuOpenRate = 0.125;
  final double _menuCloseRate = 0.032;
  bool menuOpen = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    logger.i("RouterView Init State");
    super.initState();
  }

  Drawer getMenu(BoxConstraints constraints) {
    var desktopWidth =
        (menuOpen ? _menuOpenRate : _menuCloseRate) * constraints.maxWidth;
    var mobileWidth = constraints.maxWidth / 2;
    var width =
        ResponsiveWrapper.of(context).isMobile ? mobileWidth : desktopWidth;
    return Drawer(
      width: width,
      child: Container(
        width: width,
        color: AdminColors().get().navMenuStyle.background,
        height: constraints.maxHeight,
        child: SingleChildScrollView(
          child: NavMenu(
            onSelected: (routeInfo) {
              logger.i("Click Route:${routeInfo.fullPath}");
              context.router.navigateNamed(routeInfo.fullPath);
            },
            axis: Axis.vertical,
            open: menuOpen,
            indexedBuilder: (context, data, index, style, states,
                animationController, menuOpen) {
              return NavMenuItem(
                data: data,
                menuOpen: menuOpen,
                materialState: states,
                itemStyle: style,
                animation: animationController.drive(Tween(begin: 0, end: 0.5)),
              );
            },
            rootCount: AdminRouter().routeInfo.last.children?.length ?? 0,
            width: width,
            rootBuilder: (int index) {
              return AdminRouter().routeInfo.last.children![index];
            },
            menuStateBuilder: (RouteInfo route) {
              return AdminRouter().currentRoute?.id == route.id;
            },
            onChild: (RouteInfo route) {
              return !route.id.eq(AdminRouter().currentRoute?.id) &&
                  (AdminRouter().currentRoute?.id ?? "-").startsWith(route.id);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget? buildForLarge(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      Drawer menu = getMenu(size);
      var main = SizedBox(
        height: size.maxHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              if (ResponsiveWrapper.of(context).isMobile) {
                                setState(() {
                                  menuOpen = true;
                                });
                                _scaffoldKey.currentState?.openDrawer();
                              } else {
                                setState(() {
                                  menuOpen = !menuOpen;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white70,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: TitleView(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: MenuTitle(),
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: AutoRouter(),
            )
          ],
        ),
      );
      List<Widget> widgets = [];
      if (!ResponsiveWrapper.of(context).isMobile) {
        widgets.add(AnimatedContainer(
          duration: Duration(milliseconds: 200),
          child: menu,
        ));
      }
      widgets.add(Expanded(child: main));
      return Scaffold(
        key: _scaffoldKey,
        drawer: ResponsiveWrapper.of(context).isMobile ? menu : null,
        body: Container(
          height: size.maxHeight,
          width: size.maxWidth,
          color: AdminColors().get().backgroundColor,
          child: Row(
            children: widgets,
          ),
        ),
      );
    });
  }
}
