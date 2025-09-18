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
      body: Column(
        children: [
          RadioListTile(
            title: const Text("Sistema"),
            value: ThemeMode.system,
            groupValue: settings.themeMode,
            onChanged: (val) => settings.updateThemeMode(val!),
          ),
          RadioListTile(
            title: const Text("Claro"),
            value: ThemeMode.light,
            groupValue: settings.themeMode,
            onChanged: (val) => settings.updateThemeMode(val!),
          ),
          RadioListTile(
            title: const Text("Oscuro"),
            value: ThemeMode.dark,
            groupValue: settings.themeMode,
            onChanged: (val) => settings.updateThemeMode(val!),
          ),
        ],
      ),
    );
  }
}
