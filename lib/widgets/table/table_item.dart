import 'package:flutter/material.dart';

typedef OnDisplay = bool Function();
typedef ItemView<T> = Widget Function(
    BuildContext context, int index, T? data, AdminTableItem<T> tableItem);

enum FixedDirection {
  left,
  right,
  none;
}

class AdminTableItem<T> {
  final FixedDirection fixed;
  final double width;
  final String label;
  final ItemView<T> itemView;
  OnDisplay? onDisplay;
  final Key? key;

  AdminTableItem(
      {
      required this.itemView,
      required this.width,
      required this.label,
      this.key,
      this.fixed = FixedDirection.none,
      this.onDisplay});
}
