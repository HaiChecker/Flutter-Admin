import 'package:flutter/material.dart';
import 'package:flutter_admin/router/router_info.dart';
import 'package:flutter_admin/style/colors.dart';
import 'package:fluttericon/entypo_icons.dart';

import '../../style/base_style.dart';
import '../animation/icon_color.dart';

typedef IndexedBuilder = Widget Function(
    BuildContext context,
    dynamic data,
    int index,
    NavMenuItemStyle? style,
    MaterialStatesController materialStates,
    AnimationController animationController,
    bool open,
    int level);

typedef RootBuilder = RouteInfo Function(int index);
typedef MenuStateBuilder = bool Function(RouteInfo route);

typedef OnSelected = void Function(RouteInfo data);

class NavMenuItemStyle {
  final MaterialStateProperty<TextStyle> titleStyle;
  final MaterialStateProperty<Color> backgroundColor;
  final MaterialStateProperty<Color> iconColor;

  NavMenuItemStyle(
      {required this.titleStyle,
      required this.backgroundColor,
      required this.iconColor});
}

class NavMenuStyle extends BaseStyle {
  NavMenuStyle({super.background});
}

class NavMenuItem extends StatefulWidget {
  RouteInfo data;
  NavMenuItemStyle? itemStyle;
  MaterialStatesController materialState;
  Animation<double> animation;
  bool menuOpen;
  int level = 1;

  NavMenuItem(
      {super.key,
      required this.data,
      required this.menuOpen,
      required this.materialState,
      this.itemStyle,
      required this.level,
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
    // 获取层级
    switch (widget.level) {
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
        padding: size.maxWidth > 100
            ? EdgeInsets.only(left: 15 * widget.level.toDouble())
            : null,
        duration: const Duration(milliseconds: 200),
        child: widget.menuOpen
            ? Row(
                children: [
                  IconColor(
                    Icon(
                      widget.data.icon ?? Icons.browser_not_supported_rounded,
                      size: 15,
                    ),
                    color: widget.itemStyle!.iconColor
                        .resolve(widget.materialState.value),
                    duration: const Duration(milliseconds: 500),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: AnimatedDefaultTextStyle(
                        style: widget.itemStyle!.titleStyle
                            .resolve(widget.materialState.value),
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          widget.data.title,
                        ),
                      ),
                    ),
                  ),
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
                      .resolve(widget.materialState.value)
                      .color,
                ),
              ),
      );
    });
  }
}
