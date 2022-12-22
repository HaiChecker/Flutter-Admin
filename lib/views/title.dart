import 'package:flutter/material.dart';
import 'package:flutter_admin/config/menu_config.dart';
import 'package:flutter_admin/router/router_info.dart';
import 'package:flutter_admin/views/breadcrumb.dart';
import 'package:flutter_admin/widgets/button/button.dart';
import 'package:flutter_admin/widgets/button/style.dart';
import 'package:flutter_admin/widgets/menu/controller/nav_menu_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../style/colors.dart';

class TitleView extends StatefulWidget {
  final AdminRouter router;

  const TitleView({super.key, required this.router});

  @override
  State<StatefulWidget> createState() => _TitleView();
}

class _TitleView extends State<TitleView> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      widget.router.addListener(updateView);
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.router.removeListener(updateView);
    super.dispose();
  }

  void updateView() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    List<RouteInfo> titles = widget.router.getParent();
    RouteInfo? currentRoute = widget.router.currentRoute;

    return LayoutBuilder(builder: (context, size) {
      return BreadCrumbView(
          separator: Text(" / ",style: TextStyle(fontSize: 14,color: AdminColors().get().secondaryColor),),
          buttons: titles.map((e) {
            return SizedBox(
              height: 50,
              child: AdminButton(
                onTop: null,
                text: e.title,
                buttonType: AdminButtonType.text,
                textStyle: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return TextStyle(
                        fontSize: 14, color: AdminColors().get().secondaryColor);
                  }
                  if (states.contains(MaterialState.selected)) {
                    return const TextStyle(fontSize: 14, color: Colors.white);
                  }

                  if (currentRoute?.path == e.path) {
                    return const TextStyle(
                        fontSize: 14, color: Colors.white);
                  } else {
                    if (states.contains(MaterialState.hovered)) {
                      return const TextStyle(
                          fontSize: 14, color: Colors.white);
                    }
                    return TextStyle(
                        fontSize: 14, color: AdminColors().get().secondaryColor);
                  }
                }),
              ),
            );
          }).toList());
    });
  }
}
