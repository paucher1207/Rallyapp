import 'package:flutter/material.dart';
import '../models.dart';
import 'average_list_page.dart';
import 'waypoint_list_page.dart';
import 'pace_list_page.dart';

class StageDetailPage extends StatelessWidget {
  final Stage stage;

  const StageDetailPage({super.key, required this.stage});

  @override
  Widget build(BuildContext context) {
    final averagesCount = stage.averages.length;
    final waypointsCount = stage.waypoints.length;
    final paceNotesCount = stage.paceNotes.length;

    return Scaffold(
      appBar: AppBar(title: Text("Detalles: ${stage.nom}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Distancia: ${stage.distancia} m"),
            Text("Hora salida: ${stage.horaSortida.hour.toString().padLeft(2, '0')}:${stage.horaSortida.minute.toString().padLeft(2, '0')}"),
            const SizedBox(height: 20),
            ListTile(
              title: const Text("Averages"),
              subtitle: Text("$averagesCount registrados"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AverageListPage(stage: stage),
                ),
              ),
            ),
            ListTile(
              title: const Text("Waypoints"),
              subtitle: Text("$waypointsCount registrados"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WaypointListPage(stage: stage),
                ),
              ),
            ),
            ListTile(
              title: const Text("Pace Notes"),
              subtitle: Text("$paceNotesCount registrados"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaceDataListPage(stage: stage),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
