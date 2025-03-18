import 'package:flutter/material.dart';

class ThemeViewmodel extends ChangeNotifier {

  // set Light theme by default
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

/// helps to toggle/ switch theme.
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
