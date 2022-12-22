import 'package:flutter/material.dart';
import 'package:flutter_admin/widgets/button/button.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class BreadCrumbView extends StatelessWidget {
  final Widget separator;
  final List<Widget> buttons;

  const BreadCrumbView(
      {super.key, required this.separator, required this.buttons});

  List<Widget> getChildren() {
    List<Widget> data = [];
    for (var value in buttons) {
      data.add(value);
      final tempSeparator = separator;
      data.add(tempSeparator);
    }
    if (data.isNotEmpty) {
      data.removeLast();
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: getChildren(),
      );
    });
  }
}
