import 'package:flutter/material.dart';
import '../services/settings_service.dart';

class SettingsController extends ChangeNotifier {
  final SettingsService _service;
  ThemeMode _themeMode = ThemeMode.system;

  SettingsController(this._service);

  ThemeMode get themeMode => _themeMode;

  /// Carga los ajustes al iniciar la app
  Future<void> loadSettings() async {
    final theme = await _service.getThemeMode();
    _themeMode = _stringToThemeMode(theme);
    notifyListeners();
  }

  /// Cambia el tema y guarda el ajuste
  Future<void> updateThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _service.setThemeMode(_themeMode.name);
    notifyListeners();
  }

  /// Convierte String a ThemeMode
  ThemeMode _stringToThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
