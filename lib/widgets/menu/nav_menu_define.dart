import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/router/router_info.dart';
import 'package:flutter_admin/style/colors.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:provider/provider.dart';

import '../../style/base_style.dart';
import 'controller/nav_menu_controller.dart';

typedef IndexedBuilder = Widget Function(
    BuildContext context,
    dynamic data,
    int index,
    NavMenuItemStyle? style,
    MaterialStatesController materialStates,
    AnimationController animationController,
    bool open);

typedef RootBuilder = RouteInfo Function(int index);
typedef MenuStateBuilder = bool Function(RouteInfo route);

typedef OnSelected = void Function(RouteInfo data);

@CopyWith()
class NavMenuItemStyle {
  final MaterialStateProperty<TextStyle> titleStyle;
  final MaterialStateProperty<Color> backgroundColor;
  final MaterialStateProperty<Color> iconColor;

  NavMenuItemStyle(
      {required this.titleStyle,
      required this.backgroundColor,
      required this.iconColor});
}
@CopyWith()
class NavMenuStyle extends BaseStyle {
  NavMenuStyle({super.background});
}

class NavMenuItem extends StatefulWidget {
  RouteInfo data;
  NavMenuItemStyle? itemStyle;
  MaterialStatesController materialState;
  Animation<double> animation;
  bool menuOpen;

  NavMenuItem(
      {super.key,
      required this.data,
      required this.menuOpen,
      required this.materialState,
      this.itemStyle,
      required this.animation});

  @override
  State<StatefulWidget> createState() => _NavMenuItem();
}

class _NavMenuItem extends State<NavMenuItem>
    with SingleTickerProviderStateMixin {
  void updateView() {
    setState(() {});
  }

  @override
  void initState() {
    widget.materialState.addListener(updateView);
    super.initState();
  }

  @override
  void dispose() {
    widget.materialState.removeListener(updateView);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String path = widget.data.id;
    // 获取层级
    int cell = path.split(".").length;

    switch (cell) {
      case 1:
        widget.itemStyle ??= AdminColors().get().navMenuItemStyle;
        break;
      case 2:
        widget.itemStyle ??= AdminColors().get().navMenuItemStyle2;
        break;
      default:
        widget.itemStyle ??= AdminColors().get().navMenuItemStyle3;
        break;
    }

    return LayoutBuilder(builder: (context, size) {
      return AnimatedContainer(
        color: widget.itemStyle!.backgroundColor
            .resolve(widget.materialState.value),
        height: size.maxWidth > 100 ? 50 : size.maxWidth,
        width: size.maxWidth,
        padding: size.maxWidth > 100 ? EdgeInsets.only(left: 15 * cell.toDouble()) : null,
        duration: const Duration(milliseconds: 200),
        child: widget.menuOpen
            ? Row(
                children: [
                  Icon(
                    widget.data.icon ?? Icons.browser_not_supported_rounded,
                    size: 15,
                    color: widget.itemStyle!.iconColor
                        .resolve(widget.materialState.value),
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: AnimatedDefaultTextStyle(
                      style: widget.itemStyle!.titleStyle
                          .resolve(widget.materialState.value),
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        widget.data.title,
                      ),
                    ),
                  )),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: widget.data.isChildren()
                        ? RotationTransition(
                            turns: widget.animation,
                            child: const Icon(
                              Entypo.down_open_mini,
                              color: Colors.white70,
                            ),
                          )
                        : Container(),
                  )
                ],
              )
            : Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Icon(
                  widget.data.icon ?? Icons.browser_not_supported_rounded,
                  color: widget.itemStyle!.titleStyle
                      .resolve(widget.materialState.value).color,
                ),
              ),
      );
    });
  }
}
