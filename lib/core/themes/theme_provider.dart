import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

final themeProvider = ChangeNotifierProvider<ThemeNotifier>(
      (ref) => ThemeNotifier(),
);

class ThemeNotifier extends ChangeNotifier {
  ThemeData themeData = lightTheme;

  Future<void> loadInitialTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTheme = prefs.getString('appTheme');

    if (storedTheme != null) {
      themeData = storedTheme == 'dark' ? darkTheme : lightTheme;
    } else {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      themeData = brightness == Brightness.dark ? darkTheme : lightTheme;
    }
    notifyListeners();
  }

  void changeTheme() async {
    if (themeData == darkTheme) {
      themeData = lightTheme;
      await (await SharedPreferences.getInstance()).setString('appTheme', 'light');
    } else {
      themeData = darkTheme;
      await (await SharedPreferences.getInstance()).setString('appTheme', 'dark');
    }
    notifyListeners();
  }
}
