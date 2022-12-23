import 'package:flutter/material.dart';
import 'package:flutter_admin/router/router_info.dart';
import 'package:flutter_admin/views/breadcrumb.dart';
import 'package:flutter_admin/widgets/button/button.dart';
import 'package:flutter_admin/widgets/button/style.dart';

import '../style/colors.dart';

class TitleView extends StatelessWidget {

  const TitleView({super.key});

  @override
  Widget build(BuildContext context) {
    List<RouteInfo> titles = AdminRouter().parents;
    RouteInfo? currentRoute = AdminRouter().currentRoute;

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
