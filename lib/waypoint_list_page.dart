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
    final waypoints = await DatabaseService.getWaypointsByStage(widget.stage);
    setState(() => _waypoints = waypoints);
  }

  Future<void> _addWaypoint() async {
    final distanciaController = TextEditingController();
    final latController = TextEditingController();
    final lonController = TextEditingController();
    final mensajeController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nuevo Waypoint"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: distanciaController, decoration: const InputDecoration(labelText: "Distancia"), keyboardType: TextInputType.number),
            TextField(controller: latController, decoration: const InputDecoration(labelText: "Latitud"), keyboardType: TextInputType.number),
            TextField(controller: lonController, decoration: const InputDecoration(labelText: "Longitud"), keyboardType: TextInputType.number),
            TextField(controller: mensajeController, decoration: const InputDecoration(labelText: "Mensaje")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              final distancia = int.tryParse(distanciaController.text);
              final lat = double.tryParse(latController.text);
              final lon = double.tryParse(lonController.text);
              final mensaje = mensajeController.text;

              if (distancia == null || lat == null || lon == null || mensaje.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Rellena todos los campos correctamente")),
                );
                return;
              }

              await DatabaseService.addWaypoint(widget.stage.id, distancia, lat, lon, mensaje);
              Navigator.pop(context);
              _loadWaypoints();
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteWaypoint(RefWaypoint wp) async {
    await DatabaseService.deleteWaypoint(wp.id);
    _loadWaypoints();
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
                return ListTile(
                  title: Text("Distancia: ${wp.distancia} m"),
                  subtitle: Text("Lat: ${wp.latitud}, Lon: ${wp.longitud}\nMensaje: ${wp.mensaje}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteWaypoint(wp),
                  ),
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
