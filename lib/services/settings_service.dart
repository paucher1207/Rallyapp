import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SettingsService {
  static const String _themeKey = 'theme_mode';
  static const _keyGpsAccuracy = 'gpsAccuracy';
  static const _keyGpsInterval = 'gpsInterval';
  static const _keyPaceDefaultLength = 'paceDefaultLength';

  /// Obtiene el modo de tema (light/dark/system)
 Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey);

    if (themeIndex == null) {
      return ThemeMode.system;
    }
    return ThemeMode.values[themeIndex];
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }

  /// Ajustes GPS
  Future<int> getGpsAccuracy() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyGpsAccuracy) ?? 50; // en metros
  }

  Future<void> setGpsAccuracy(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyGpsAccuracy, value);
  }

  Future<int> getGpsInterval() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyGpsInterval) ?? 1000; // en milisegundos
  }

  Future<void> setGpsInterval(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyGpsInterval, value);
  }

  /// Ajustes Pace
  Future<int> getPaceDefaultLength() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyPaceDefaultLength) ?? 100; // metros
  }

  Future<void> setPaceDefaultLength(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyPaceDefaultLength, value);
  }
}
