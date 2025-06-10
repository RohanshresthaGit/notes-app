import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../constants/constans.dart';

class ThemeViewmodel extends ChangeNotifier {
  // set Light theme by default
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  Box? box;

  ThemeViewmodel() {
    openBox();
  }

  openBox() async {
    box = await Hive.openBox(themeBox);
    getTheme();
  }

  /// helps to toggle/ switch theme.
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setTheme(_themeMode);
    notifyListeners();
  }

  setTheme(ThemeMode themes) {
    if (box == null) return;
    box!.put(theme, themes.toString());
  }

  getTheme() {
    if (box == null) return;
    final themeMode = box!.get(theme);
    if (themeMode == ThemeMode.light.toString()) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}
