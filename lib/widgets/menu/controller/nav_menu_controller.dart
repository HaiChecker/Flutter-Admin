import 'package:flutter/material.dart';
@deprecated
class NavMenuController extends ChangeNotifier {
  List<dynamic> _data = [];

  dynamic? _selected;

  var mapData = <String, dynamic>{};

  bool isSelected(dynamic data) {
    if (_selected == null) {
      return false;
    }
    return data['id'] == _selected['id'];
  }

  bool isExpand(String ids){
    if(_selected != null){
      return (_selected['id'] as String).startsWith(ids);
    }
    return false;
  }

  bool onSelectedByName(String name, {List<dynamic>? data}) {
    if (_selected != null && name == _selected['name']) {
      return true;
    }

    for (var value in data ?? _data) {
      if (value['name'] == name) {
        _selected = value;
        notifyListeners();
        return true;
      } else {
        bool isChildren = children(value);
        if (isChildren) {
          onSelectedByName(name, data: value['children']);
        }
      }
    }
    return false;
  }

  void onSelected(dynamic data) {
    _selected = data;
    notifyListeners();
  }

  void setNewData(List<dynamic> data) {
    _data = data;
    notifyListeners();
  }

  // 判断是否存在child
  bool children(dynamic data) {
    try {
      return data['children'] != null && (data['children'] as List).isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // 获取child数据
  dynamic ofIndex(int index, String? parentPath, {dynamic? data}) {
    if (data == null) {
      _data[index]['id'] = "$index";
      mapData[_data[index]['name']] = _data[index];
      return _data[index];
    } else {
      data[index]['id'] = "$parentPath.$index";
      mapData[data[index]['name']] = data[index];
      return data[index];
    }
  }

  dynamic? getData(String name){
    return mapData[name];
  }

  List<dynamic> getParent(String name) {
    if (!mapData.containsKey(name)) {
      return [];
    }
    dynamic data = mapData[name];
    var index = (data['id'] as String).split(".");
    List<dynamic> parent = [];

    dynamic getChildren(List<dynamic> data, int index) {
      return data[index];
    }

    var parentData;
    for (var value in index) {
      parentData = getChildren(parentData?['children'] ?? _data, int.parse(value));
      parent.add(parentData);
    }
    return parent;
  }

  int needNumber({dynamic? data}) {
    if (data == null) {
      return _data.length;
    }
    return (data as List).length;
  }
}
