import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  String _unit = "km";
  int _gpsInterval = 1; // segundos
  bool _paceNotesHighlight = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool("darkMode") ?? false;
      _unit = prefs.getString("unit") ?? "km";
      _gpsInterval = prefs.getInt("gpsInterval") ?? 1;
      _paceNotesHighlight = prefs.getBool("paceNotesHighlight") ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", _darkMode);
    await prefs.setString("unit", _unit);
    await prefs.setInt("gpsInterval", _gpsInterval);
    await prefs.setBool("paceNotesHighlight", _paceNotesHighlight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajustes")),
      body: ListView(
        children: [
          const ListTile(title: Text("🌍 Ajustes globales")),
          SwitchListTile(
            title: const Text("Modo oscuro"),
            value: _darkMode,
            onChanged: (val) {
              setState(() => _darkMode = val);
              _saveSettings();
            },
          ),
          ListTile(
            title: const Text("Unidad de distancia"),
            trailing: DropdownButton<String>(
              value: _unit,
              items: const [
                DropdownMenuItem(value: "km", child: Text("Kilómetros")),
                DropdownMenuItem(value: "mi", child: Text("Millas")),
              ],
              onChanged: (val) {
                if (val != null) {
                  setState(() => _unit = val);
                  _saveSettings();
                }
              },
            ),
          ),
          const Divider(),

          const ListTile(title: Text("📡 Ajustes GPS")),
          ListTile(
            title: const Text("Intervalo de actualización (segundos)"),
            trailing: DropdownButton<int>(
              value: _gpsInterval,
              items: [1, 2, 5, 10]
                  .map((v) => DropdownMenuItem(value: v, child: Text("$v s")))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _gpsInterval = val);
                  _saveSettings();
                }
              },
            ),
          ),
          const Divider(),

          const ListTile(title: Text("📝 Ajustes Pace Notes")),
          SwitchListTile(
            title: const Text("Resaltar notas importantes"),
            value: _paceNotesHighlight,
            onChanged: (val) {
              setState(() => _paceNotesHighlight = val);
              _saveSettings();
            },
          ),
        ],
      ),
    );
  }
}
