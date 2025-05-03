// theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/dark_theme.dart';

import 'light_theme.dart';
final themeProvider = ChangeNotifierProvider<ThemeNotifier>((ref) => ThemeNotifier());

class ThemeNotifier extends ChangeNotifier {
  ThemeData themeData = lightTheme;

  void changeTheme() {
    print("we entered the function");
    if (themeData == darkTheme) {
      themeData = lightTheme; // ✅ FIXED
      print("this is the light theme");
    } else {
      themeData = darkTheme;
      print("this is the dark theme");
    }
    notifyListeners(); // ✅ Rebuild listeners
  }
}
