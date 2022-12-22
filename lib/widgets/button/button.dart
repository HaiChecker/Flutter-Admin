import 'package:flutter/material.dart';
import 'package:flutter_admin/widgets/button/style.dart';
import 'package:fluttericon/fontelico_icons.dart';

import '../../style/colors.dart';
import '../animation/rotation.dart';

class AdminButton extends StatefulWidget {
  final AdminButtonStyle? buttonStyle;
  final AdminButtonShape buttonShape;
  final AdminButtonSize buttonSize;
  final AdminButtonType buttonType;
  final Widget? child;
  final String? text;
  final bool? loading;
  final Widget? left;
  final Widget? right;
  final Function? onTop;
  final bool disabled;
  final double? height;
  final MaterialStateProperty<TextStyle>? textStyle;
  final MaterialStateProperty<MouseCursor>? mouseCursor;
  final BorderRadiusGeometry? borderRadius;

  AdminButton(
      {super.key,
      this.buttonStyle,
      this.buttonShape = AdminButtonShape.plain,
      this.buttonSize = AdminButtonSize.medium,
      this.disabled = false,
      this.child,
      this.loading = false,
      this.left,
      this.right,
      this.onTop,
      this.buttonType = AdminButtonType.primary,
      this.height,
      this.borderRadius,
      this.text, this.textStyle, this.mouseCursor})
      : assert(child != null || text != null, "child and text must choose one");

  @override
  State<StatefulWidget> createState() => _AdminButton();
}

class _AdminButton extends State<AdminButton> {
  late MaterialStatesController internalStatesController;
  late FocusScopeNode myFocus;

  void updateView() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    internalStatesController = MaterialStatesController();
    internalStatesController.update(
        MaterialState.disabled, widget.disabled || widget.onTop == null);
    if (widget.loading != null) {
      internalStatesController.update(MaterialState.disabled, widget.loading!);
    }
    internalStatesController.addListener(updateView);
    myFocus = FocusScopeNode();
    myFocus.addListener(updateView);
    super.initState();
  }

  @override
  void dispose() {
    internalStatesController.removeListener(updateView);
    internalStatesController.dispose();
    myFocus.removeListener(updateView);
    myFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AdminButtonStyle buttonStyle = widget.buttonStyle ??
        AdminColors().get().buttonStyle.resolveOne(widget.buttonType);
    internalStatesController.update(
        MaterialState.focused, myFocus.hasPrimaryFocus);
    return LayoutBuilder(builder: (context, size) {

      double? width = size.maxWidth;
      double height = widget.height ?? size.maxHeight;
      switch (widget.buttonSize) {
        case AdminButtonSize.custom:
          if (height > size.maxHeight) {
            height = size.maxHeight;
          }
          break;
        case AdminButtonSize.medium:
          height = 40;
          break;
        case AdminButtonSize.small:
          height = 30;
          break;
        case AdminButtonSize.mini:
          height = 20;
          break;
      }
      Color borderColor =
          buttonStyle.borderColor.resolve(internalStatesController.value);

      Color backgroundColor =
          buttonStyle.backgroundColor.resolve(internalStatesController.value);

      BorderRadius? borderRadius;

      switch (widget.buttonShape) {
        case AdminButtonShape.plain:
          if(widget.buttonType != AdminButtonType.text){
            backgroundColor = backgroundColor.withAlpha(100);
          }
          break;
        case AdminButtonShape.round:
          width = height;
          borderRadius = BorderRadius.all(Radius.circular(width / 2));
          break;
        case AdminButtonShape.circle:
          borderRadius = BorderRadius.all(Radius.circular(height / 2));
          break;
        case AdminButtonShape.custom:
          break;
      }

      switch(widget.buttonType){
        case AdminButtonType.text:
          borderRadius = const BorderRadius.all(Radius.circular(0));
          break;
        case AdminButtonType.success:
          // TODO: Handle this case.
          break;
        case AdminButtonType.info:
          // TODO: Handle this case.
          break;
        case AdminButtonType.error:
          // TODO: Handle this case.
          break;
        case AdminButtonType.warning:
          // TODO: Handle this case.
          break;
        case AdminButtonType.primary:
          // TODO: Handle this case.
          break;
        case AdminButtonType.custom:
          // TODO: Handle this case.
          break;
      }
      if (width == double.infinity) {
        width = null;
      }
      late Widget child;
      if (widget.text != null) {
        child = Text(
          widget.text!,
          style: widget.textStyle?.resolve(internalStatesController.value) ?? buttonStyle.textStyle.resolve(internalStatesController.value),
        );
      } else {
        child = widget.child!;
      }

      Widget? progressWidget;
      bool progress = widget.loading ?? false;
      if (progress) {
        progressWidget = RotationView(
          start: true,
          child: Icon(
            Fontelico.spin6,
            size: buttonStyle.textStyle
                .resolve(internalStatesController.value)
                .fontSize,
            color: buttonStyle.textStyle
                .resolve(internalStatesController.value)
                .color,
          ),
        );
      }
      return MouseRegion(
        onExit: (e) {
          internalStatesController.update(MaterialState.hovered, false);
        },
        onEnter: (e) {
          internalStatesController.update(MaterialState.hovered, true);
        },
        child: FocusScope(
          node: myFocus,
          child: InkWell(
            mouseCursor:(widget.mouseCursor ?? AdminColors()
                .get()
                .clickMouse)
                .resolve(internalStatesController.value),
            onTapDown: (details) {
              internalStatesController.update(MaterialState.pressed, true);
            },
            onTapCancel: () {
              internalStatesController.update(MaterialState.pressed, false);
            },
            onTapUp: (details) {
              internalStatesController.update(MaterialState.pressed, false);
            },
            onTap: (){
              if(widget.onTop != null){
                widget.onTop!();
              }
            },
            child: AnimatedContainer(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: widget.borderRadius ??
                      borderRadius ??
                      const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: borderColor,
                    width: 0.5,
                  ),
                  color: backgroundColor),
              duration: const Duration(milliseconds: 200),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  progressWidget != null
                      ? Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: progressWidget,
                        )
                      : Container(),
                  child
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
