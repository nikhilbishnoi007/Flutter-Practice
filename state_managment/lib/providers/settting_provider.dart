import 'package:flutter/material.dart';

class SetttingProvider with ChangeNotifier{
  ThemeMode mode=ThemeMode.system;
  void switchMode(ThemeMode value){
    mode=value;
    notifyListeners();
  }
}