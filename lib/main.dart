import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_admin/config/logger.dart';
import 'package:flutter_admin/config/menu_config.dart';
import 'package:flutter_admin/router/router_info.dart';
import 'package:flutter_admin/views/app.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    ThemeData themeData = ThemeData(
        primarySwatch: Colors.blue,
        tabBarTheme: Theme.of(context).tabBarTheme.copyWith(
              labelColor: Colors.black26,
              labelStyle: const TextStyle(color: Colors.black26, fontSize: 14),
            ));


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MenuConfig(menuOpen: true),
        ),
        ChangeNotifierProvider(
          create: (_) => AdminRouter().goRouter,
        ),

      ],
      child: MaterialApp.router(
        theme: themeData,
        title: 'Flutter Admin',
        routerDelegate: AdminRouter().goRouter.routerDelegate,
        routeInformationParser: AdminRouter().goRouter.routeInformationParser,
        routeInformationProvider: AdminRouter().goRouter.routeInformationProvider,
        builder: (routerContext, child) {
          var router = routerContext.read<GoRouter>();
          // 更新路由信息到App
          AdminRouter().onSelected(router.location);
          return ResponsiveWrapper.builder(
              Scaffold(
                body: AppView(
                  router: AdminRouter(),
                  child: child!,
                ),
              ),
              maxWidth: 2460,
              minWidth: 280,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(280, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(912, name: TABLET),
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(color: const Color(0xFFF5F5F5)));
        },

      ),
    );
  }
}
