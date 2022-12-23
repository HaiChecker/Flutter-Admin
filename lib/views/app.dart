// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_admin/config/menu_config.dart';
// import 'package:flutter_admin/router/auto_router.gr.dart';
// import 'package:flutter_admin/router/router_info.dart';
// import 'package:flutter_admin/style/colors.dart';
// import 'package:flutter_admin/views/menu_title.dart';
// import 'package:flutter_admin/views/title.dart';
// import 'package:logger/logger.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_framework/responsive_wrapper.dart';
//
// import '../widgets/menu/nav_menu.dart';
// import '../widgets/menu/nav_menu_define.dart';
//
// class AppView extends StatefulWidget {
//   // final Widget? child;
//   // final AdminRouter router;
//
//   // const AppView({super.key, this.child, required this.router});
//
//   @override
//   State<StatefulWidget> createState() => _AppView();
// }
//
// class _AppView extends State<AppView> {
//   // late NavMenuController controller;
//   var logger = Logger();
//   bool showMenu = false;
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     // widget.router.addListener(updateView);
//   }
//
//   @override
//   void dispose() {
//     // widget.router.removeListener(updateView);
//     super.dispose();
//   }
//
//   void onMenuSelect(RouteInfo data) {
//     // widget.router.goRouter.replace(data.fullPath);
//     AutoRouter.of(context).replaceNamed(data.name);
//   }
//
//   void updateView() {
//     if (mounted) {
//       try {
//         setState(() {});
//       } catch (e) {
//         logger.i("刷新发生错误:$e");
//       }
//     }
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }
//
//   @override
//   void didUpdateWidget(covariant AppView oldWidget) {
//     logger.i("App didUpdateWidget");
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     logger.i("App build");
//     double menuOpenRate = 0.125;
//     double menuCloseRate = 0.032;
//     MenuConfig tempMenuConfig = context.read<MenuConfig>();
//     tempMenuConfig.removeListener(updateView);
//     tempMenuConfig.addListener(updateView);
//
//     if (ResponsiveWrapper.of(context).isMobile) {
//       menuOpenRate = 0.5;
//       menuCloseRate = 0.0;
//     }
//     // showMenu = widget.router.currentRoute?.menu == true ||
//     //     widget.router.currentRoute?.isChildren() == true;
//     logger.i("ShowMenu:$showMenu");
//     return LayoutBuilder(builder: (context, size) {
//       var menu = AnimatedContainer(
//         width: size.maxWidth *
//             (tempMenuConfig.menuOpen ? menuOpenRate : menuCloseRate),
//         height: double.infinity,
//         duration: const Duration(milliseconds: 200),
//         child: SingleChildScrollView(
//           child: NavMenu(
//             onSelected: onMenuSelect,
//             indexedBuilder: (context, data, index, style, states,
//                 animationController, menuOpen) {
//               return AnimatedBuilder(
//                   animation: animationController,
//                   builder: (context, child) {
//                     return NavMenuItem(
//                       menuOpen: menuOpen,
//                       data: data,
//                       itemStyle: style,
//                       materialState: states,
//                       animation:
//                           animationController.drive(Tween(begin: 0, end: 0.5)),
//                     );
//                   });
//             },
//             axis: Axis.vertical,
//             width: double.infinity,
//             open: tempMenuConfig.menuOpen,
//             rootBuilder: (int index) {
//               // return widget.router.routeInfo[index];
//             },
//             // rootCount: widget.router.routeInfo.length,
//             menuStateBuilder: (RouteInfo route) {
//               return true;
//               // return widget.router.currentRoute?.id == route.id;
//             },
//             onChild: (RouteInfo route) {
//               return false;
//               // return !route.id.eq(widget.router.currentRoute?.id) &&
//               //     (widget.router.currentRoute?.id ?? "-").startsWith(route.id);
//             },
//           ),
//         ),
//       );
//       var title = Container(
//         color: AdminColors().get().backgroundColor,
//         width: double.infinity,
//         height: 80,
//         alignment: Alignment.centerLeft,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 50,
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     child: Container(
//                       height: double.infinity,
//                       width: 50,
//                       child: Icon(
//                         Icons.menu_rounded,
//                         color: AdminColors().get().secondaryColor,
//                       ),
//                     ),
//                     onTap: () {
//                       tempMenuConfig.changeMenu(!tempMenuConfig.menuOpen);
//                       if (ResponsiveWrapper.of(context).isMobile) {
//                         if (tempMenuConfig.menuOpen) {
//                           scaffoldKey.currentState!.openDrawer();
//                         } else {
//                           scaffoldKey.currentState!.closeDrawer();
//                         }
//                       }
//                     },
//                   ),
//                   // TitleView(
//                   //   router: widget.router,
//                   // )
//                 ],
//               ),
//             ),
//             // Container(
//             //   color: AdminColors().get().primaryBackgroundColor,
//             //   width: size.maxWidth,
//             //   height: 30,
//             //   child: SingleChildScrollView(
//             //     scrollDirection: Axis.horizontal,
//             //     child: MenuTitle(
//             //       router: widget.router,
//             //     ),
//             //   ),
//             // )
//           ],
//         ),
//       );
//       var content = Stack(
//         alignment: Alignment.center,
//         children: [
//           showMenu
//               ? Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   child: title,
//                 )
//               : Container(),
//           Container(
//             margin: showMenu ? const EdgeInsets.only(top: 80) : null,
//             child: widget.child!,
//           )
//         ],
//       );
//       if (widget.child == null) {
//         return Container(
//           color: Colors.green,
//         );
//       } else {
//         return ResponsiveWrapper.of(context).isMobile
//             ? Scaffold(
//                 body: content,
//                 key: scaffoldKey,
//                 drawer: showMenu
//                     ? Drawer(
//                         child: Container(
//                           color: AdminColors().get().navMenuStyle.background,
//                           child: menu,
//                         ),
//                       )
//                     : Container(),
//               )
//             : Row(
//                 children: [
//                   showMenu
//                       ? Container(
//                           color: AdminColors().get().navMenuStyle.background,
//                           child: menu,
//                         )
//                       : Container(),
//                   Expanded(child: content)
//                 ],
//               );
//       }
//     });
//   }
// }
