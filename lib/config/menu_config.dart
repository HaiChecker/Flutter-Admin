import 'package:flutter/material.dart';

class MenuConfig extends ChangeNotifier {
  bool menuOpen;
  MenuConfig({required this.menuOpen});

  void changeMenu(bool open) {
    menuOpen = open;
    notifyListeners();
  }
}
