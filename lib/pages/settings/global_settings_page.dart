import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/settings_controller.dart';

class GlobalSettingsPage extends StatelessWidget {
  const GlobalSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Ajustes Globales")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tema de la aplicación",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Lista de opciones con RadioMenuButton
            RadioMenuButton<ThemeMode>(
            value: ThemeMode.system,
            groupValue: settings.themeMode,
            onChanged: (val) => settings.updateThemeMode(val!),
            child: const Text("Sistema"),
            ),
            RadioMenuButton<ThemeMode>(
              value: ThemeMode.light,
              groupValue: settings.themeMode,
              onChanged: (val) => settings.updateThemeMode(val!),
              child: const Text("Claro"),
            ),
            RadioMenuButton<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: settings.themeMode,
              onChanged: (val) => settings.updateThemeMode(val!),
              child: const Text("Oscuro"),
            ),
          ],
        ),
      ),
    );
  }
}
