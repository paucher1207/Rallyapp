import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models.dart';
import 'waypoint_form_dialog.dart';

class WaypointListPage extends StatefulWidget {
  final Stage? stage;
  final int? stageId;

  // Debes pasar stage o stageId (al menos uno)
  WaypointListPage({Key? key, this.stage, this.stageId})
      : assert(stage != null || stageId != null, 'Debes proporcionar stage o stageId'),
        super(key: key);

  @override
  State<WaypointListPage> createState() => _WaypointListPageState();
}

class _WaypointListPageState extends State<WaypointListPage> {
  final _dbHelper = DatabaseHelper();
  List<RefWaypoint> _waypoints = [];

  int get _stageId => widget.stage?.id ?? widget.stageId!;
  String get _stageName => widget.stage?.nom ?? 'Stage $_stageId';

  @override
  void initState() {
    super.initState();
    _loadWaypoints();
  }

  Future<void> _loadWaypoints() async {
    final waypoints = await _dbHelper.getRefWaypointsByStage(_stageId);
    setState(() {
      _waypoints = waypoints;
    });
  }

  Future<void> _deleteWaypoint(int id) async {
    await _dbHelper.deleteRefWaypoint(id);
    _loadWaypoints();
  }

  Future<void> _openWaypointForm({RefWaypoint? waypoint}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => WaypointFormDialog(
        stageId: _stageId,
        waypoint: waypoint,
      ),
    );

    if (result == true) _loadWaypoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Waypoints - $_stageName")),
      body: _waypoints.isEmpty
          ? const Center(child: Text("No hay waypoints"))
          : ListView.builder(
              itemCount: _waypoints.length,
              itemBuilder: (context, index) {
                final wp = _waypoints[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text("Distancia: ${wp.distancia} m"),
                    subtitle: Text("Lat: ${wp.latitud}, Lng: ${wp.longitud}\nMensaje: ${wp.mensaje}"),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "edit") {
                          _openWaypointForm(waypoint: wp);
                        } else if (value == "delete") {
                          _deleteWaypoint(wp.id!);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: "edit", child: Text("Editar")),
                        PopupMenuItem(value: "delete", child: Text("Eliminar")),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openWaypointForm(),
        child: const Icon(Icons.add_location_alt),
      ),
    );
  }
}
