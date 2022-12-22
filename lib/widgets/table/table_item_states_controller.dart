import 'package:flutter/material.dart';
import 'package:flutter_admin/config/logger.dart';

class TableItemStatesController
    extends ChangeNotifier {

  var value = <String,Set<MaterialState>>{};

  void update(String key, MaterialState state, bool add) {
    if (!value.containsKey(key)) {
      value[key] = <MaterialState>{};
    }
    final bool valueChanged =
        add ? value[key]!.add(state) : value[key]!.remove(state);


    if(valueChanged){
      notifyListeners();
    }
  }

  Set<MaterialState> getState(String key) {
    if (value.containsKey(key)) {
      return value[key]!;
    } else {
      return <MaterialState>{};
    }
  }
}
