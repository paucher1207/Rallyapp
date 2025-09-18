import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _keyThemeMode = 'themeMode';
  static const _keyGpsAccuracy = 'gpsAccuracy';
  static const _keyGpsInterval = 'gpsInterval';
  static const _keyPaceDefaultLength = 'paceDefaultLength';

  /// Obtiene el modo de tema (light/dark/system)
  Future<String> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyThemeMode) ?? 'system';
  }

  Future<void> setThemeMode(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyThemeMode, value);
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
