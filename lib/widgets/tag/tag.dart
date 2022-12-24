import 'package:flutter/material.dart';
import 'package:flutter_admin/style/colors.dart';
import 'package:flutter_admin/widgets/button/style.dart';

class TagView extends StatelessWidget {
  final AdminButtonType type;
  final String title;
  final Function? onTop;
  final AdminButtonSize size;
  final double? height;
  final Color? background;
  final TextStyle? textStyle;
  final bool? hit;

  const TagView(this.title,
      {super.key,
      required this.type,
      this.onTop,
      required this.size,
      this.height,
      this.background,
      this.hit,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    AdminButtonStyle buttonStyle =
        AdminColors().get().buttonStyle.resolveOne(type);
    var textStyle = this.textStyle ?? buttonStyle.textStyle.resolve({});
    return LayoutBuilder(builder: (context, size) {
      double height;
      switch (this.size) {
        case AdminButtonSize.medium:
          height = 40;
          textStyle = textStyle.copyWith(
            fontSize: 12,
            backgroundColor: Colors.red,
          );
          break;
        case AdminButtonSize.small:
          height = 30;
          textStyle =
              textStyle.copyWith(fontSize: 11, backgroundColor: Colors.red);
          break;
        case AdminButtonSize.mini:
          height = 20;
          textStyle =
              textStyle.copyWith(fontSize: 10, backgroundColor: Colors.red);
          break;
        case AdminButtonSize.custom:
          if (this.height == null) {
            throw const FormatException(
                "the size is custom, but the height is empty");
          }
          height = this.height!;
          break;
      }
      if (height > size.maxHeight) {
        height = size.maxHeight;
      }
      var borderColor = background ?? buttonStyle.borderColor.resolve({});
      return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: WidgetSpan(
          child: Container(
            width: 50,
            height: height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color:
                background ?? buttonStyle.backgroundColor.resolve({}),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: borderColor, width: 1)),
            child: Text(
              title,
              style: textStyle,
            ),
          ),
        ),
      );
    });
  }
}
