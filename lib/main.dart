import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'stage_list_page.dart';
import 'waypoint_list_page.dart';
import 'pace_list_page.dart';
import 'settings_page.dart';

void main() {
  runApp(const RallyApp());
}

class RallyApp extends StatefulWidget {
  const RallyApp({super.key});

  @override
  State<RallyApp> createState() => _RallyAppState();
}

class _RallyAppState extends State<RallyApp> {
  bool _darkMode = false;
  String _unit = "km";

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool("darkMode") ?? false;
      _unit = prefs.getString("unit") ?? "km";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rally Navigator',
      theme: ThemeData(
        brightness: _darkMode ? Brightness.dark : Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: _darkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: MainMenuPage(
        onSettingsChanged: _loadSettings,
        unit: _unit,
      ),
    );
  }
}

class MainMenuPage extends StatelessWidget {
  final VoidCallback onSettingsChanged;
  final String unit;

  const MainMenuPage({
    super.key,
    required this.onSettingsChanged,
    required this.unit,
  });

  void _openStages(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StageListPage()),
    );
  }

  void _openWaypoints(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => WaypointListPage(stageId: 1)),
    );
  }

  void _openPaceNotes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PaceListPage(stageId: 1)),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsPage()),
    ).then((_) {
      // Recargar ajustes al volver
      onSettingsChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rally Navigator - Menú Principal ($unit)"),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.flag),
              label: const Text("Gestionar Stages"),
              onPressed: () => _openStages(context),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.gps_fixed),
              label: const Text("Gestionar Waypoints"),
              onPressed: () => _openWaypoints(context),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.notes),
              label: const Text("Gestionar Pace Notes"),
              onPressed: () => _openPaceNotes(context),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text("Ajustes"),
              onPressed: () => _openSettings(context),
            ),
          ],
        ),
      ),
    );
  }
}
