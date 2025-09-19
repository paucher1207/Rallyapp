import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/settings_controller.dart';
import 'stage_list_page.dart';
import 'waypoint_list_page.dart';
import 'pace_list_page.dart';
import 'pages/settings/settings_menu_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsController(),
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
      themeMode: settings.themeMode, // se conecta al controller
      home: const MainMenuPage(),
    );
  }
}

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rally App - Menú Principal')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Stages'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  StageListPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Waypoints'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  WaypointListPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Pace Notes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  PaceListPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Ajustes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  SettingsMenuPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
