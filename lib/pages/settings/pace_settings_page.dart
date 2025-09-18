import 'package:flutter/material.dart';
import '../../services/settings_service.dart';

class PaceSettingsPage extends StatefulWidget {
  const PaceSettingsPage({super.key});

  @override
  State<PaceSettingsPage> createState() => _PaceSettingsPageState();
}

class _PaceSettingsPageState extends State<PaceSettingsPage> {
  final _settings = SettingsService();
  int _defaultLength = 100;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final length = await _settings.getPaceDefaultLength();
    setState(() => _defaultLength = length);
  }

  Future<void> _save(int value) async {
    await _settings.setPaceDefaultLength(value);
    setState(() => _defaultLength = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajustes Pace Notes")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: const Text("Longitud curva por defecto (m)"),
              subtitle: Text("$_defaultLength m"),
              trailing: DropdownButton<int>(
                value: _defaultLength,
                items: const [
                  DropdownMenuItem(value: 50, child: Text("50 m")),
                  DropdownMenuItem(value: 100, child: Text("100 m")),
                  DropdownMenuItem(value: 200, child: Text("200 m")),
                ],
                onChanged: (val) => _save(val!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
