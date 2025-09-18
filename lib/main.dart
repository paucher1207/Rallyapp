import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/settings_controller.dart';
import 'services/settings_service.dart';

// Páginas principales

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsService = SettingsService();
  final settingsController = SettingsController(settingsService);
  await settingsController.loadSettings();

  runApp(
    ChangeNotifierProvider(
      create: (_) => settingsController,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsController>(context);

    return MaterialApp(
      title: 'Rally App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settings.themeMode,
    );
  }
}
