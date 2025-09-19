import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void updateThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners(); // 🔔 notifica a toda la app
  }
}