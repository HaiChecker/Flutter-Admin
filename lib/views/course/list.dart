import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin/store/name_random.dart';
import 'package:flutter_admin/views/base_views.dart';
import 'package:flutter_admin/widgets/button/style.dart';
import 'package:flutter_admin/widgets/table/controller.dart';
import 'package:flutter_admin/widgets/table/table_item.dart';
import 'package:flutter_admin/widgets/tag/tag.dart';

import '../../style/colors.dart';
import '../../widgets/table/table.dart';

class CourseListPage extends AdminView {
  CourseListPage({super.key});

  @override
  State<StatefulWidget> createState() => _CourseListPage();
}

class _CourseListPage extends AdminStateView<CourseListPage> {
  late AdminTableController _adminTableController;
  var itemData = [];

  Widget courseListItemView(BuildContext context, int index, dynamic data,
      AdminTableItem item) {
    return LayoutBuilder(builder: (context, size) {
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
                const Text("预览",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 15),),
                Container(width: 1,
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  color: Colors.black12,),
                const Text("编辑",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 15),),
                Container(width: 1,
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  color: Colors.black12,),
                const Text("删除",
                  style: TextStyle(color: Colors.red, fontSize: 15),),
              ],
            ),
          );
        }
        BoxDecoration? boxDecoration;
        TextStyle? textStyle;

        switch (item.prop) {
          case 'title':
            textStyle = const TextStyle(color: Colors.blue);
            break;
          default:
            textStyle = TextStyle(color: AdminColors()
                .get()
                .secondaryColor);
            break;
        }
        if(item.prop == 'state'){
          return Container(
            alignment: Alignment.center,
            child: TagView(data[item.prop!], type: AdminButtonType.primary,size: AdminButtonSize.mini,),
          );
        }
        return Container(
          decoration: boxDecoration,
          alignment: Alignment.center,
          child: Text(
            "${data[item.prop!]}",
            style: textStyle,
          ),
        );
      }
    });

  }

  @override
  void initState() {
    final type = ['免费课程', '收费课程', '会员专区', '视频专区'];
    final state = ['已发布', '未发布'];

    for (var i = 0; i <= 50; i++) {
      int typeIndex = Random().nextInt(type.length - 1);
      int stateIndex = Random().nextInt(2);

      itemData.add({
        'title': '证券基本法律法规-精讲班',
        'type': type[typeIndex],
        'atCreate': NameRandom().getChineseName(),
        'state': state[stateIndex],
        'school': Random().nextInt(20),
        'time': "${Random().nextInt(20)} 小时",
        'openNum': Random().nextInt(5000)
      });
    }
    _adminTableController = AdminTableController(items: [
      AdminTableItem(
          itemView: courseListItemView,
          width: 200,
          label: '课程标题',
          fixed: FixedDirection.left,
          prop: 'title'),
      AdminTableItem(
          itemView: courseListItemView,
          width: 100,
          label: '课程分类',
          prop: 'type'),
      AdminTableItem(
          itemView: courseListItemView,
          width: 100,
          label: '课程管理员',
          prop: 'atCreate'),
      AdminTableItem(
          itemView: courseListItemView,
          width: 100,
          label: '课程状态',
          prop: 'state'),
      AdminTableItem(
          itemView: courseListItemView,
          width: 100,
          label: '关联学校数',
          prop: 'school'),
      AdminTableItem(
          itemView: courseListItemView,
          width: 100,
          label: '课程时长',
          prop: 'time'),
      AdminTableItem(
          itemView: courseListItemView,
          width: 100,
          label: '浏览次数',
          prop: 'openNum'),
      AdminTableItem(
          itemView: courseListItemView, width: 200, label: '操作', prop: 'action')
    ]);
    _adminTableController.setNewData(itemData);
    super.initState();
  }

  @override
  Widget? buildForLarge(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Container(
        width: size.maxWidth,
        margin: const EdgeInsets.all(10),
        height: size.maxHeight,
        child: AdminTable(
          controller: _adminTableController,
          fixedHeader: true,
        ),
      );
    });
  }
}
