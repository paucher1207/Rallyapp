import 'package:flutter/material.dart';
import 'global_settings_page.dart';
import 'gps_settings_page.dart';
import 'pace_settings_page.dart';

class SettingsMenuPage extends StatelessWidget {
  const SettingsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajustes")),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text("Ajustes Globales"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GlobalSettingsPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.gps_fixed),
            title: const Text("Ajustes GPS"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GpsSettingsPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notes),
            title: const Text("Ajustes Pace Notes"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PaceSettingsPage()),
            ),
          ),
        ],
      ),
    );
  }
}
