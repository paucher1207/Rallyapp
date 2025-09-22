import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  /// Actualiza el tema y lo guarda en SharedPreferences
  void updateThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    _saveSettings();
  }

  /// Carga los ajustes guardados
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('themeMode') ?? 'system';
    switch (theme) {
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  /// Guarda los ajustes
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    String value = 'system';
    if (_themeMode == ThemeMode.light) value = 'light';
    if (_themeMode == ThemeMode.dark) value = 'dark';
    await prefs.setString('themeMode', value);
  }
}
