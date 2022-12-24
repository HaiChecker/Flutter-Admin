import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin/views/base_views.dart';
import 'package:flutter_admin/widgets/table/controller.dart';
import 'package:flutter_admin/widgets/table/table_item.dart';

import '../../style/colors.dart';
import '../../widgets/table/table.dart';

class SchoolView extends AdminView {
  SchoolView({super.key});

  @override
  State<StatefulWidget> createState() => _SchoolView();
}

class _SchoolView extends AdminStateView<SchoolView> {
  late AdminTableController schoolController;
  late AdminTableController courseController;

  @override
  void initState() {
    super.initState();
    schoolController = AdminTableController(items: [
      AdminTableItem(
          itemView: schoolItemView, width: 100, label: '学校ID', prop: 'id'),
      AdminTableItem(
          itemView: schoolItemView, width: 100, label: '学校名称', prop: 'name',fixed: FixedDirection.left),
      AdminTableItem(
          itemView: schoolItemView, width: 100, label: '主管部门', prop: 'parent'),
      AdminTableItem(
          itemView: schoolItemView, width: 200, label: '所在地', prop: 'addr'),
      AdminTableItem(
          itemView: schoolItemView, width: 100, label: '办学层级', prop: 'level'),
      AdminTableItem(
          itemView: schoolItemView, width: 100, label: '操作', prop: 'action',fixed: FixedDirection.right),
    ]);

    var schoolData = [];
    for (int i = 1; i <= 50; i++) {
      schoolData.add({
        'id': i,
        'name': '四川大学',
        'parent': '教育局',
        'addr': '四川省成都市锦江区',
        'level': '本科'
      });
    }
    schoolController.setNewData(schoolData);
  }

  Widget schoolItemView(
      BuildContext context, int index, dynamic data, AdminTableItem item) {
    if (index == -1) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          item.label,
          style: TextStyle(color: AdminColors()
              .get()
              .secondaryColor),
        ),
      );
    } else {
      if (item.prop == 'action') {
        return Container(
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("查看",
                style: TextStyle(color: Colors.blueAccent, fontSize: 15),),
              Container(width: 1,
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                color: Colors.black12,),
              const Text("更多",
                style: TextStyle(color: Colors.blueAccent, fontSize: 15),),
            ],
          ),
        );
      }
      return Container(
        alignment: Alignment.center,
        child: Text(
          "${schoolController.ofData(index)[item.prop!]}",
          style: TextStyle(color: AdminColors()
              .get()
              .secondaryColor),
        ),
      );
    }
  }
  @override
  Widget? buildForLarge(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Container(
        width: size.maxWidth,
        margin: const EdgeInsets.all(20),
        height: size.maxHeight,
        child: AdminTable(
          controller: schoolController,
          fixedHeader: true,
        ),
      );
    });
  }
}
