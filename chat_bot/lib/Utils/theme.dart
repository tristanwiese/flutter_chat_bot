import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class BrightnesMode with ChangeNotifier{

   final deviceThemeMode =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

  ThemeData _currentTheme = ThemeData.light();

  get currentTheme => _currentTheme;


  changeTheme(String mode){
    if (mode == "dark"){
      _currentTheme = ThemeData.dark();
    }else{
      _currentTheme = ThemeData.light();
    }
    notifyListeners();
  }
}