import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models.dart';
import 'waypoint_form_dialog.dart';

class WaypointListPage extends StatefulWidget {
  final Stage stage;

  const WaypointListPage({super.key, required this.stage});

  @override
  State<WaypointListPage> createState() => _WaypointListPageState();
}

class _WaypointListPageState extends State<WaypointListPage> {
  final _dbHelper = DatabaseHelper();
  List<RefWaypoint> _waypoints = [];

  @override
  void initState() {
    super.initState();
    _loadWaypoints();
  }

  Future<void> _loadWaypoints() async {
    final waypoints = await _dbHelper.getRefWaypointsByStage(widget.stage.id!);
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
        stageId: widget.stage.id!,
        waypoint: waypoint,
      ),
    );

    if (result == true) {
      _loadWaypoints();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waypoints GPS - ${widget.stage.nom}"),
      ),
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
                    subtitle: Text(
                        "Lat: ${wp.latitud}, Lng: ${wp.longitud}\nMensaje: ${wp.mensaje}"),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "edit") {
                          _openWaypointForm(waypoint: wp);
                        } else if (value == "delete") {
                          _deleteWaypoint(wp.id!);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: "edit",
                          child: Text("Editar"),
                        ),
                        const PopupMenuItem(
                          value: "delete",
                          child: Text("Eliminar"),
                        ),
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
