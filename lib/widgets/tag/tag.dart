import 'package:flutter/material.dart';
import 'package:flutter_admin/style/colors.dart';
import 'package:flutter_admin/widgets/button/style.dart';

class TagView extends StatelessWidget {
  final AdminButtonType type;
  final String title;
  final Function? onTop;
  final AdminButtonSize size;
  final double? padding;
  final Color? background;
  final TextStyle? textStyle;
  final bool? hit;

  const TagView(this.title,
      {super.key,
      this.type = AdminButtonType.primary,
      this.onTop,
      this.size = AdminButtonSize.mini,
      this.padding,
      this.background,
      this.hit,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    AdminButtonStyle buttonStyle =
        AdminColors().get().buttonStyle.resolveOne(type);
    var textStyle = this.textStyle ?? buttonStyle.textStyle.resolve({});
    return LayoutBuilder(builder: (context, size) {
      double tempPadding = padding ?? 0;
      switch (this.size) {
        case AdminButtonSize.medium:
          tempPadding = 10;
          textStyle = textStyle.copyWith(
            fontSize: 12,);
          break;
        case AdminButtonSize.small:
          tempPadding = 5;
          textStyle =
              textStyle.copyWith(fontSize: 11);
          break;
        case AdminButtonSize.mini:
          tempPadding = 2;
          textStyle =
              textStyle.copyWith(fontSize: 10);
          break;
        case AdminButtonSize.custom:
          if (padding == null) {
            throw const FormatException(
                "the size is custom, but the height is empty");
          }
          tempPadding = padding!;
          break;
      }

      var borderColor = background ?? buttonStyle.borderColor.resolve({});
      return Container(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.only(left: 10,right: 10,top: tempPadding,bottom: tempPadding),
          decoration: BoxDecoration(
              color: background ?? buttonStyle.backgroundColor.resolve({}),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: borderColor, width: 1)),
          child: Text(
            title,
            style: textStyle,
          ),
        ),
      );
    });
  }
}
