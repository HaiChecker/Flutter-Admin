import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';

enum AdminInputType { text, number, int, password, time }
@CopyWith()
class AdminInputStyle {
  final MaterialStateProperty<Color> backgroundColor;
  final MaterialStateProperty<Color> borderColor;
  final MaterialStateProperty<TextStyle> textStyle;
  final MaterialStateProperty<TextStyle> hintTextStyle;

  AdminInputStyle(
      {required this.textStyle,
      required this.hintTextStyle,
      required this.backgroundColor,
      required this.borderColor});
}
