import 'package:flutter/material.dart';
import 'package:flutter_admin/style/colors.dart';
import 'package:flutter_admin/widgets/input/style.dart';

class AdminInput extends StatefulWidget {
  final BoxDecoration? decoration;
  final TextEditingController? controller;
  final TextInputType inputType;
  final AdminInputStyle? inputStyle;
  final Widget? left;
  final Widget? right;
  final Color backgroundColor;
  final bool autoFocus;
  final bool password;
  final String hintText;
  final bool? enabled;
  final ValueChanged<String>? onChange;
  MaterialStatesController? statesController;

  AdminInput(
      {super.key,
      this.decoration,
      this.controller,
      this.inputType = TextInputType.text,
      this.left,
      this.right,
      this.backgroundColor = Colors.white,
      this.hintText = "",
      this.autoFocus = false,
      this.enabled,
      this.onChange,
      this.statesController,
      this.inputStyle,
      this.password = false});

  @override
  State<StatefulWidget> createState() => _AdminInput();
}

class _AdminInput extends State<AdminInput> {
  late FocusNode myFocusNode;
  MaterialStatesController? internalStatesController;
  final OutlineInputBorder _outlineInputBorder = const OutlineInputBorder(
    gapPadding: 0,
    borderSide: BorderSide.none,
  );

  void updateView() {
    setState(() {});
  }

  void initStatesController() {
    if (widget.statesController == null) {
      internalStatesController = MaterialStatesController();
    } else {
      internalStatesController = widget.statesController;
    }
    internalStatesController!.update(MaterialState.disabled,
        widget.enabled != null ? !widget.enabled! : false);
    internalStatesController!.addListener(updateView);
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    internalStatesController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      internalStatesController?.update(
          MaterialState.focused, myFocusNode.hasPrimaryFocus);
    });
    initStatesController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late AdminInputStyle inputStyle;
    if (widget.inputStyle == null) {
      inputStyle = AdminColors().get().inputStyle;
    } else {
      inputStyle = widget.inputStyle!;
    }
    late BoxDecoration boxDecoration;
    if (widget.decoration != null) {
      boxDecoration = widget.decoration!;
    } else {
      boxDecoration = BoxDecoration(
          color: inputStyle.backgroundColor
              .resolve(internalStatesController!.value),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              color: inputStyle.borderColor
                  .resolve(internalStatesController!.value),
              width: 0.5));
    }
    return LayoutBuilder(builder: (context, constraints) {
      return MouseRegion(
        onEnter: (event) {
          internalStatesController?.update(MaterialState.hovered, true);
        },
        onExit: (event) {
          internalStatesController?.update(MaterialState.hovered, false);
        },
        child: Container(
          width: constraints.maxWidth,
          height: constraints.minHeight,
          decoration: boxDecoration,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.left != null ? widget.left! : Container(),
              Expanded(
                child: TextField(
                  enabled: widget.enabled,
                  autofocus: widget.autoFocus,
                  controller: widget.controller,
                  focusNode: myFocusNode,
                  keyboardType: widget.inputType,
                  onChanged: widget.onChange,
                  style: inputStyle.textStyle.resolve(internalStatesController!.value),
                  obscureText: widget.password,
                  decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: inputStyle.textStyle.resolve(internalStatesController!.value),
                      border: _outlineInputBorder,
                      focusedBorder: _outlineInputBorder,
                      enabledBorder: _outlineInputBorder,
                      disabledBorder: _outlineInputBorder,
                      focusedErrorBorder: _outlineInputBorder,
                      errorBorder: _outlineInputBorder,
                      constraints: constraints,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5)),
                ),
              ),
              widget.right != null ? widget.right! : Container(),
            ],
          ),
        ),
      );
    });
  }
}
