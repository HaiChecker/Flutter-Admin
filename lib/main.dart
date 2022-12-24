import 'package:flutter/material.dart';
import 'package:flutter_admin/router/router_info.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  AdminRouter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData(
        primarySwatch: Colors.blue,
        tabBarTheme: Theme.of(context).tabBarTheme.copyWith(
              labelColor: Colors.black26,
              labelStyle: const TextStyle(color: Colors.black26, fontSize: 14),
            ));

    return MaterialApp.router(
      theme: themeData,
      title: 'Flutter Admin',
      routerConfig: AdminRouter().goRouter,
      builder: (routerContext, child) {
        return ResponsiveWrapper.builder(
            child,
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
    );
  }
}
