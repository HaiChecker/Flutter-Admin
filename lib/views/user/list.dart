import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin/store/name_random.dart';
import 'package:flutter_admin/views/base_views.dart';
import 'package:flutter_admin/views/filter_view.dart';
import 'package:flutter_admin/widgets/input/input.dart';
import 'package:flutter_admin/widgets/table/controller.dart';
import 'package:flutter_admin/widgets/table/table.dart';
import 'package:flutter_admin/widgets/table/table_item.dart';

import '../../style/colors.dart';

class UserList extends AdminView {
  UserList({super.key});

  @override
  State<StatefulWidget> createState() => _UserList();
}

class _UserList extends AdminStateView<UserList> {
  late AdminTableController _controller;

  var itemData = [];

  @override
  void initState() {
    NameRandom nameRandom = NameRandom();
    for (int i = 1; i <= 100; i++) {
      itemData.add({
        'id': i,
        'name': nameRandom.getChineseName(),
        'six': i % 2 == 0 ? '男' : '女',
        'addr': '四川省成都市',
        'id_type': "身份证",
        'reg_time': DateTime.now().toIso8601String(),
        'id_number': '123111111111111112',
        'phone': '18090555563',
        'course':"${Random().nextInt(20)}",
        'ip': '127.0.0.1'
      });
    }
    _controller = AdminTableController(items: [
      AdminTableItem(
          itemView: onItemView,
          width: 100,
          label: "用户ID",
          prop: 'id',
          fixed: FixedDirection.left),
      AdminTableItem(
          itemView: onItemView, width: 150, label: "姓名", prop: 'name'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "性别", prop: 'six'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "在读课程数", prop: 'course'),
      AdminTableItem(
          itemView: onItemView, width: 200, label: "户籍", prop: 'addr'),
      AdminTableItem(
          itemView: onItemView, width: 200, label: "注册时间", prop: 'reg_time'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "身份证证件类型", prop: 'id_type'),
      AdminTableItem(
          itemView: onItemView, width: 200, label: "身份证件号码", prop: 'id_number'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "手机号码", prop: 'phone'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "登录IP", prop: 'ip'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "操作",fixed: FixedDirection.right,prop: 'action'),
    ]);
    _controller.setNewData(itemData);
    super.initState();
  }

  Widget onItemView(
      BuildContext context, int index, dynamic data, AdminTableItem item) {
    if (index == -1) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          item.label,
          style: TextStyle(color: AdminColors().get().secondaryColor),
        ),
      );
    } else {
      if(item.prop == 'action'){
        return Container(
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("查看",style: TextStyle(color: Colors.blueAccent,fontSize: 15),),
              Container(width: 1,margin: const EdgeInsets.only(left:10,right: 10,top: 10,bottom: 10),color: Colors.black12,),
              const Text("更多",style: TextStyle(color: Colors.blueAccent,fontSize: 15),),
            ],
          ),
        );
      }
      return Container(
        alignment: Alignment.center,
        child: Text(
          "${_controller.ofData(index)[item.prop!]}",
          style: TextStyle(color: AdminColors().get().secondaryColor),
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
          controller: _controller,
          fixedHeader: true,
        ),
      );
    });
  }
}
