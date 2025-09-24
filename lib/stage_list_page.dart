import 'package:flutter/material.dart';
import '../models.dart';
import 'database_service.dart';
import 'stage_form_page.dart';
import 'average_list_page.dart';
import 'waypoint_list_page.dart';
import 'pace_list_page.dart';

class StageListPage extends StatefulWidget {
  const StageListPage({super.key});

  @override
  State<StageListPage> createState() => _StageListPageState();
}

class _StageListPageState extends State<StageListPage> {
  List<Stage> _stages = [];

  @override
  void initState() {
    super.initState();
    _loadStages();
  }

  Future<void> _loadStages() async {
    final stages = await DatabaseService.getStages();
    setState(() => _stages = stages);
  }

  Future<void> _deleteStage(int id) async {
    await DatabaseService.deleteStage(id);
    await _loadStages();
  }

  Future<void> _openStageForm({Stage? stage}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StageFormPage(stage: stage),
      ),
    );

    if (result == true) _loadStages();
  }

  void _openAverages(Stage stage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AverageListPage(stage: stage),
      ),
    );
  }

  void _openWaypoints(Stage stage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WaypointListPage(stage: stage),
      ),
    );
  }

  void _openPaceData(Stage stage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaceDataListPage(stage: stage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tramos")),
      body: _stages.isEmpty
          ? const Center(child: Text("No hay Tramos todavía"))
          : ListView.builder(
              itemCount: _stages.length,
              itemBuilder: (context, index) {
                final stage = _stages[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(stage.nom),
                    subtitle: Text(
                        "Distancia: ${stage.distancia} m | Salida: ${stage.horaSortida.hour.toString().padLeft(2,'0')}:${stage.horaSortida.minute.toString().padLeft(2,'0')}"),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "edit") _openStageForm(stage: stage);
                        if (value == "delete") _deleteStage(stage.id);
                        if (value == "averages") _openAverages(stage);
                        if (value == "waypoints") _openWaypoints(stage);
                        if (value == "pacedata") _openPaceData(stage);
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: "edit", child: Text("Editar")),
                        PopupMenuItem(value: "averages", child: Text("Velocidades medias")),
                        PopupMenuItem(value: "waypoints", child: Text("Waypoints")),
                        PopupMenuItem(value: "pacedata", child: Text("Pace Notes")),
                        PopupMenuItem(value: "delete", child: Text("Eliminar")),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openStageForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
