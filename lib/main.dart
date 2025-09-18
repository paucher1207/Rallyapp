import 'package:flutter/material.dart';
import 'stage_list_page.dart';
import 'waypoint_list_page.dart';
import 'pace_list_page.dart';

void main() {
  runApp(const RallyApp());
}

class RallyApp extends StatelessWidget {
  const RallyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rally Navigator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainMenuPage(),
    );
  }
}

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  void _openStages(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StageListPage()),
    );
  }

  void _openWaypoints(BuildContext context) {
    // Por ahora pedimos un stageId manualmente
    // Más adelante se puede elegir un Stage antes
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => WaypointListPage(stageId: 1)),
    );
  }

  void _openPaceNotes(BuildContext context) {
    // Igual que waypoints, se puede mejorar con selección de Stage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PaceListPage(stageId: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rally Navigator - Menú Principal"),
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
          ],
        ),
      ),
    );
  }
}
