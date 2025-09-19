import 'package:flutter/material.dart';
import 'global_settings_page.dart';
import 'gps_settings_page.dart';
import 'pace_settings_page.dart';

class SettingsMenuPage extends StatelessWidget {
  const SettingsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menú de Ajustes")),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Ajustes globales"),
            subtitle: const Text("Tema, idioma, etc."),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GlobalSettingsPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.gps_fixed),
            title: const Text("Ajustes GPS"),
            subtitle: const Text("Precisión e intervalo"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GpsSettingsPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit_note),
            title: const Text("Ajustes Pace Notes"),
            subtitle: const Text("Longitud de curvas por defecto"),
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
