import 'package:flutter/material.dart';
import './pages/settings/gps_settings_page.dart';
import './pages/settings/pace_settings_page.dart';
import './pages/settings/global_settings_page.dart';

class SettingsMenuPage extends StatelessWidget {
  const SettingsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajustes")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Ajustes Globales"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GlobalSettingsPage()),
              );
            },
          ),
          ListTile(
            title: const Text("Ajustes GPS"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GpsSettingsPage()),
              );
            },
          ),
          ListTile(
            title: const Text("Ajustes Pace Notes"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaceSettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
