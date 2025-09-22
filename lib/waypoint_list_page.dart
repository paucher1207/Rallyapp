import 'package:flutter/material.dart';
import 'database.dart';
import 'models.dart';
import 'waypoint_form_dialog.dart';

class WaypointListPage extends StatefulWidget {
  final Stage stage;

  const WaypointListPage({super.key, required this.stage});

  @override
  State<WaypointListPage> createState() => _WaypointListPageState();
}

class _WaypointListPageState extends State<WaypointListPage> {
  List<RefWaypoint> _waypoints = [];

  @override
  void initState() {
    super.initState();
    _loadWaypoints();
  }

  Future<void> _loadWaypoints() async {
    final isar = await DatabaseService.openDB();
    final stageFresh = await isar.stages.get(widget.stage.id);
    await stageFresh!.waypoints.load();
    setState(() {
      _waypoints = stageFresh.waypoints.toList();
    });
  }

  Future<void> _openFormDialog({RefWaypoint? waypoint}) async {
    final result = await showDialog(
      context: context,
      builder: (_) => WaypointFormDialog(stage: widget.stage, waypoint: waypoint),
    );
    if (result == true) _loadWaypoints();
  }

  Future<void> _deleteWaypoint(RefWaypoint waypoint) async {
    final isar = await DatabaseService.openDB();
    await isar.writeTxn(() async {
      await isar.refWaypoints.delete(waypoint.id);
    });
    _loadWaypoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waypoints"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openFormDialog(),
          ),
        ],
      ),
      body: _waypoints.isEmpty
          ? const Center(child: Text("No hay waypoints"))
          : ListView.builder(
              itemCount: _waypoints.length,
              itemBuilder: (context, index) {
                final wp = _waypoints[index];
                return ListTile(
                  title: Text("Distancia: ${wp.distancia} m"),
                  subtitle: Text("Lat: ${wp.latitud}, Lon: ${wp.longitud}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openFormDialog(waypoint: wp),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteWaypoint(wp),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
