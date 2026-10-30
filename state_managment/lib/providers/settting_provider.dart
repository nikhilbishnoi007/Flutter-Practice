import 'package:flutter/material.dart';

class SetttingProvider with ChangeNotifier{
  ThemeMode mode=ThemeMode.light;
  void switchMode(ThemeMode value){
    mode=value;
    notifyListeners();
  }
}