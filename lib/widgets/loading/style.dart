import 'dart:ui';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';

typedef OnLoadingView = Widget Function(BuildContext context);


class LoadingStyle {
  final Color backgroundColor;
  final OnLoadingView onLoadingView;

  LoadingStyle(this.backgroundColor, this.onLoadingView);
}
