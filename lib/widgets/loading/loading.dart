import 'package:flutter/material.dart';
import 'package:flutter_admin/style/colors.dart';
import 'package:flutter_admin/widgets/loading/style.dart';

class LoadingView extends StatelessWidget {
  final Widget child;
  final bool loading;
  final LoadingStyle? loadingStyle;
  final BoxDecoration? decoration;

  const LoadingView(
      {super.key,
      required this.child,
      required this.loading,
      this.loadingStyle,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    LoadingStyle loadingStyle =
        this.loadingStyle ?? AdminColors().get().loadingStyle;
    return LayoutBuilder(builder: (context, size) {
      var children = <Widget>[];
      children.add(child);
      if (loading) {
        children.add(Container(
          alignment: Alignment.center,
          width: size.maxWidth,
          height: size.maxHeight,
          color: loadingStyle.backgroundColor,
          child: loadingStyle.onLoadingView(context),
        ));
      }
      return Container(
        decoration: decoration,
        width: size.maxWidth,
        height: size.maxHeight,
        child: Stack(
          children: children,
        ),
      );
    });
  }
}
