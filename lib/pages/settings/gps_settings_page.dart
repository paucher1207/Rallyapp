import 'package:flutter/material.dart';
import '../../services/settings_service.dart';

class GpsSettingsPage extends StatefulWidget {
  const GpsSettingsPage({super.key});

  @override
  State<GpsSettingsPage> createState() => _GpsSettingsPageState();
}

class _GpsSettingsPageState extends State<GpsSettingsPage> {
  final _settings = SettingsService();

  int _accuracy = 50;
  int _interval = 1000;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final acc = await _settings.getGpsAccuracy();
    final intv = await _settings.getGpsInterval();
    setState(() {
      _accuracy = acc;
      _interval = intv;
    });
  }

  Future<void> _saveAccuracy(int value) async {
    await _settings.setGpsAccuracy(value);
    setState(() => _accuracy = value);
  }

  Future<void> _saveInterval(int value) async {
    await _settings.setGpsInterval(value);
    setState(() => _interval = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajustes GPS")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: const Text("Precisión (m)"),
              subtitle: Text("$_accuracy m"),
              trailing: DropdownButton<int>(
                value: _accuracy,
                items: const [
                  DropdownMenuItem(value: 10, child: Text("10 m")),
                  DropdownMenuItem(value: 20, child: Text("20 m")),
                  DropdownMenuItem(value: 50, child: Text("50 m")),
                  DropdownMenuItem(value: 100, child: Text("100 m")),
                ],
                onChanged: (val) => _saveAccuracy(val!),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text("Intervalo (ms)"),
              subtitle: Text("$_interval ms"),
              trailing: DropdownButton<int>(
                value: _interval,
                items: const [
                  DropdownMenuItem(value: 500, child: Text("500 ms")),
                  DropdownMenuItem(value: 1000, child: Text("1000 ms")),
                  DropdownMenuItem(value: 2000, child: Text("2000 ms")),
                  DropdownMenuItem(value: 5000, child: Text("5000 ms")),
                ],
                onChanged: (val) => _saveInterval(val!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
