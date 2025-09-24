import 'package:flutter/material.dart';
import '../models.dart';
import 'database_service.dart';
import 'average_list_page.dart';
import 'waypoint_list_page.dart';
import 'pace_list_page.dart';

class StageDetailPage extends StatefulWidget {
  final Stage stage;

  const StageDetailPage({super.key, required this.stage});

  @override
  State<StageDetailPage> createState() => _StageDetailPageState();
}

class _StageDetailPageState extends State<StageDetailPage> {
  int averagesCount = 0;
  int waypointsCount = 0;
  int paceNotesCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCounts();
  }

  Future<void> _loadCounts() async {
    final averages = await DatabaseService.getAverages(widget.stage.id);
    final waypoints = await DatabaseService.getWaypoints(widget.stage.id);
    final paceNotes = await DatabaseService.getPaceData(widget.stage.id);

    setState(() {
      averagesCount = averages.length;
      waypointsCount = waypoints.length;
      paceNotesCount = paceNotes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles: ${widget.stage.nom}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text("Averages"),
              subtitle: Text("$averagesCount registrados"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AverageListPage(stage: widget.stage),
                  ),
                );
                _loadCounts(); // refresca los contadores al volver
              },
            ),
            ListTile(
              title: const Text("Waypoints"),
              subtitle: Text("$waypointsCount registrados"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WaypointListPage(stage: widget.stage),
                  ),
                );
                _loadCounts();
              },
            ),
            ListTile(
              title: const Text("Pace Notes"),
              subtitle: Text("$paceNotesCount registrados"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaceListPage(stage: widget.stage),
                  ),
                );
                _loadCounts();
              },
            ),
          ],
        ),
      ),
    );
  }
}
