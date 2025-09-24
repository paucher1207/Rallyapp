import 'package:flutter/material.dart';
import '../models.dart';
import 'database_service.dart';
import 'waypoint_form_page.dart';

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
    final wps = await DatabaseService.getWaypointsByStage(widget.stage.id);
    setState(() {
      _waypoints = wps;
    });
  }

  Future<void> _deleteWaypoint(RefWaypoint wp) async {
    await DatabaseService.deleteWaypoint(wp.id);
    await _loadWaypoints();
  }

  Future<void> _openWaypointForm({RefWaypoint? wp}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WaypointFormPage(stage: widget.stage, waypoint: wp),
      ),
    );

    if (result == true) {
      await _loadWaypoints();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Waypoints: ${widget.stage.nom}")),
      body: _waypoints.isEmpty
          ? const Center(child: Text("No hay waypoints todavía"))
          : ListView.builder(
              itemCount: _waypoints.length,
              itemBuilder: (context, index) {
                final wp = _waypoints[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text("Distancia: ${wp.distancia} m"),
                    subtitle: Text("Lat: ${wp.latitud}, Lon: ${wp.longitud}\nMensaje: ${wp.mensaje}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _openWaypointForm(wp: wp),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteWaypoint(wp),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openWaypointForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
