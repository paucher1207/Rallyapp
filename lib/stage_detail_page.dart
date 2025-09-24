import 'package:flutter/material.dart';
import '../models.dart';
import '../database_service.dart';
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
  Stage? stage; // versión local que se actualiza al refrescar

  @override
  void initState() {
    super.initState();
    stage = widget.stage;
    _refreshStage();
  }

  Future<void> _refreshStage() async {
    final stages = await DatabaseService.getStagesWithExtras();
    final updated = stages.firstWhere((s) => s.id == widget.stage.id, orElse: () => widget.stage);
    setState(() => stage = updated);
  }

  void _openAverages() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AverageListPage(stage: stage!)),
    );
    await _refreshStage(); // refresca al volver
  }

  void _openWaypoints() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => WaypointListPage(stage: stage!)),
    );
    await _refreshStage();
  }

  void _openPaceData() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PaceListPage(stage: stage!)),
    );
    await _refreshStage();
  }

  @override
  Widget build(BuildContext context) {
    final lastAverage = stage?.lastAverage;
    final lastPace = stage?.lastPace;
    final waypointsCount = stage?.waypointsCount ?? 0;

    return Scaffold(
      appBar: AppBar(title: Text("Detalles: ${stage?.nom ?? ''}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Distancia: ${stage?.distancia ?? 0} m"),
            Text("Hora salida: ${stage?.horaSortida.toLocal().toString().substring(0,16) ?? ''}"),
            const SizedBox(height: 20),
            ListTile(
              title: const Text("Averages"),
              subtitle: Text(lastAverage != null
                  ? "Última: ${lastAverage.velocidadMedia.toStringAsFixed(2)} m/s"
                  : "No hay registros"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: _openAverages,
            ),
            ListTile(
              title: const Text("Waypoints"),
              subtitle: Text("$waypointsCount registrados"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: _openWaypoints,
            ),
            ListTile(
              title: const Text("Pace Notes"),
              subtitle: Text(lastPace != null ? lastPace.nota : "No hay registros"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: _openPaceData,
            ),
          ],
        ),
      ),
    );
  }
}
