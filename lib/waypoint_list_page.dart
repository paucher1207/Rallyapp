import 'package:flutter/material.dart';
import '../models.dart';
import '../database_service.dart';

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
    final wps = await DatabaseService.getWaypoints(widget.stage.id);
    setState(() => _waypoints = wps);
  }

  Future<void> _addWaypoint() async {
    final controllerDist = TextEditingController();
    final controllerLat = TextEditingController();
    final controllerLon = TextEditingController();
    final controllerMsg = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nuevo Waypoint"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: controllerDist, decoration: const InputDecoration(labelText: "Distancia"), keyboardType: TextInputType.number),
            TextField(controller: controllerLat, decoration: const InputDecoration(labelText: "Latitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
            TextField(controller: controllerLon, decoration: const InputDecoration(labelText: "Longitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
            TextField(controller: controllerMsg, decoration: const InputDecoration(labelText: "Mensaje")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              await DatabaseService.addWaypoint(
                widget.stage.id,
                int.tryParse(controllerDist.text) ?? 0,
                double.tryParse(controllerLat.text) ?? 0,
                double.tryParse(controllerLon.text) ?? 0,
                controllerMsg.text,
              );
              Navigator.pop(context);
              _loadWaypoints();
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  Future<void> _editWaypoint(RefWaypoint wp) async {
    final controllerDist = TextEditingController(text: wp.distancia.toString());
    final controllerLat = TextEditingController(text: wp.latitud.toString());
    final controllerLon = TextEditingController(text: wp.longitud.toString());
    final controllerMsg = TextEditingController(text: wp.mensaje);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar Waypoint"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: controllerDist, decoration: const InputDecoration(labelText: "Distancia"), keyboardType: TextInputType.number),
            TextField(controller: controllerLat, decoration: const InputDecoration(labelText: "Latitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
            TextField(controller: controllerLon, decoration: const InputDecoration(labelText: "Longitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
            TextField(controller: controllerMsg, decoration: const InputDecoration(labelText: "Mensaje")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              wp.distancia = int.tryParse(controllerDist.text) ?? wp.distancia;
              wp.latitud = double.tryParse(controllerLat.text) ?? wp.latitud;
              wp.longitud = double.tryParse(controllerLon.text) ?? wp.longitud;
              wp.mensaje = controllerMsg.text;

              await DatabaseService.updateWaypoint(wp);
              Navigator.pop(context);
              _loadWaypoints();
            },
            child: const Text("Guardar cambios"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteWaypoint(int id) async {
    await DatabaseService.deleteWaypoint(id);
    _loadWaypoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Waypoints")),
      body: _waypoints.isEmpty
          ? const Center(child: Text("No hay Waypoints"))
          : ListView.builder(
              itemCount: _waypoints.length,
              itemBuilder: (context, i) {
                final wp = _waypoints[i];
                return ListTile(
                  title: Text("Distancia: ${wp.distancia}"),
                  subtitle: Text("Lat: ${wp.latitud}, Lon: ${wp.longitud}\n${wp.mensaje}"),
                  onTap: () => _editWaypoint(wp),
                  trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteWaypoint(wp.id)),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWaypoint,
        child: const Icon(Icons.add),
      ),
    );
  }
}
