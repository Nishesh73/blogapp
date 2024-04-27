import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkTheme = false; //give status of theme
  bool get darkTheme => _isDarkTheme; //to access status outside the class

  //get the theme

  getTheme() {
    return _isDarkTheme ? ThemeData.dark() : ThemeData.light();
  }
//toogle the theme

  toogleTheme() {
    _isDarkTheme = !_isDarkTheme;
    saveThemeState(_isDarkTheme);
    notifyListeners();
  }

//saving theme state
  saveThemeState(bool themeval) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("themeState", themeval);
  }
}
