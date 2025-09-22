import 'package:flutter/material.dart';
import '../services/settings_service.dart';

class SettingsController extends ChangeNotifier {
  final SettingsService _settingsService = SettingsService();

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  SettingsController() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _themeMode = await _settingsService.getThemeMode();
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await _settingsService.setThemeMode(mode);
  }
}
