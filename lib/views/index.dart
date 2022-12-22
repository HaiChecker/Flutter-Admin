import 'package:flutter/material.dart';
import 'package:flutter_admin/style/colors.dart';
import 'package:flutter_admin/views/base_views.dart';
import 'package:flutter_admin/widgets/loading/loading.dart';
import 'package:flutter_admin/widgets/table/controller.dart';
import 'package:flutter_admin/widgets/table/table.dart';
import 'package:flutter_admin/widgets/table/table_item.dart';

class IndexView extends AdminView {
  IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexView();
}

class _IndexView extends AdminStateView<IndexView> {
  late AdminTableController<dynamic> controller;

  Widget itemView(BuildContext context, int index, dynamic? data,
      AdminTableItem<dynamic> tableItem) {
    if (index == -1) {
      return Container(
        alignment: Alignment.center,
        child: Text(tableItem.label,style: TextStyle(color: AdminColors().get().secondaryColor),),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Text("测试内容:$index",style: TextStyle(color: AdminColors().get().secondaryColor)),
      );
    }
  }

  @override
  void initState() {
    controller = AdminTableController(items: [
      AdminTableItem<dynamic>(
          itemView: itemView,
          width: 100,
          label: "标题1",
          fixed: FixedDirection.right),
      AdminTableItem<dynamic>(
          itemView: itemView,
          width: 100,
          label: "标题2",
          fixed: FixedDirection.left),
      AdminTableItem<dynamic>(itemView: itemView, width: 100, label: "标题3"),
      AdminTableItem<dynamic>(itemView: itemView, width: 100, label: "标题4"),
      AdminTableItem<dynamic>(itemView: itemView, width: 100, label: "标题5"),
    ]);
    controller.setNewData([
      {'name': 'A'},
      {'name': 'B'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'},
      {'name': 'C'}
    ]);
    super.initState();
  }

  @override
  Widget? buildForLarge(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: AdminTable<dynamic>(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        controller: controller,
        fixedHeader: true,
      ),
    );
  }
}
