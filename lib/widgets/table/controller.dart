import 'package:flutter/material.dart';
import 'package:flutter_admin/widgets/table/table_item.dart';

class AdminTableController<T> extends ChangeNotifier {
  List<T> _data = [];

  List<AdminTableItem> items;

  AdminTableController({required this.items});

  void setNewData(List<T> data) {
    _data = data;
    notifyListeners();
  }

  int ofCount() {
    return _data.length;
  }

  T ofData(int index) {
    return _data[index];
  }

  List<AdminTableItem> getItem(
      {FixedDirection fixedDirection = FixedDirection.none}) {
    List<AdminTableItem> ret = [];
    for (var value in items) {
      if (value.fixed == fixedDirection) {
        if (value.onDisplay != null) {
          if (value.onDisplay!()) {
            ret.add(value);
          }
        } else {
          ret.add(value);
        }
      }
    }
    return ret;
  }

  bool fixed(FixedDirection fixed) {
    for (var value in items) {
      if (value.fixed == fixed) {
        return true;
      }
    }
    return false;
  }
}
