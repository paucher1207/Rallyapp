import 'package:flutter/material.dart';
import '../../services/settings_service.dart';

class GlobalSettingsPage extends StatefulWidget {
  const GlobalSettingsPage({super.key});

  @override
  State<GlobalSettingsPage> createState() => _GlobalSettingsPageState();
}

class _GlobalSettingsPageState extends State<GlobalSettingsPage> {
  final _settings = SettingsService();
  String _theme = 'system';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final theme = await _settings.getThemeMode();
    setState(() => _theme = theme);
  }

  Future<void> _save(String value) async {
    await _settings.setThemeMode(value);
    setState(() => _theme = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajustes Globales")),
      body: Column(
        children: [
          RadioListTile(
            title: const Text("Sistema"),
            value: 'system',
            groupValue: _theme,
            onChanged: (val) => _save(val!),
          ),
          RadioListTile(
            title: const Text("Claro"),
            value: 'light',
            groupValue: _theme,
            onChanged: (val) => _save(val!),
          ),
          RadioListTile(
            title: const Text("Oscuro"),
            value: 'dark',
            groupValue: _theme,
            onChanged: (val) => _save(val!),
          ),
        ],
      ),
    );
  }
}
