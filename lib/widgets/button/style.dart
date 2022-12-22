import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';

enum AdminButtonType { success, info, error, warning, primary, text, custom }

enum AdminButtonShape { plain, round, circle, custom }

enum AdminButtonSize { medium, small, mini, custom }

@CopyWith()
class AdminButtonStyle {
  final MaterialStateProperty<Color> backgroundColor;
  final MaterialStateProperty<Color> borderColor;
  final MaterialStateProperty<TextStyle> textStyle;


  AdminButtonStyle(
      {required this.textStyle,
      required this.backgroundColor,
      required this.borderColor});
}
