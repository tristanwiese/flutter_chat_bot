import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrightnesMode with ChangeNotifier{
  String _currentTheme = "";

  get currentTheme => _currentTheme;

  initiateTheme(Brightness mode){
    if (mode == Brightness.dark){
      _currentTheme = "dark";
    }else{
      _currentTheme = "light";
    }
    notifyListeners();
  }

  changeTheme(String mode){
    _currentTheme = mode;
    notifyListeners();
  }
}