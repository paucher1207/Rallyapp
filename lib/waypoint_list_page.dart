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

  final _distanciaController = TextEditingController();
  final _latController = TextEditingController();
  final _lonController = TextEditingController();
  final _mensajeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWaypoints();
  }

  Future<void> _loadWaypoints() async {
    final waypoints = await DatabaseService.getWaypoints(widget.stage.id);
    setState(() => _waypoints = waypoints);
  }

  Future<void> _addWaypoint() async {
    _distanciaController.clear();
    _latController.clear();
    _lonController.clear();
    _mensajeController.clear();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nuevo Waypoint"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _distanciaController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Distancia")),
            TextField(controller: _latController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Latitud")),
            TextField(controller: _lonController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Longitud")),
            TextField(controller: _mensajeController, decoration: const InputDecoration(labelText: "Mensaje")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              final distancia = int.tryParse(_distanciaController.text);
              final lat = double.tryParse(_latController.text);
              final lon = double.tryParse(_lonController.text);
              final mensaje = _mensajeController.text;

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
              itemBuilder: (_, index) {
                final wp = _waypoints[index];
                return ListTile(
                  title: Text("Distancia: ${wp.distancia} m"),
                  subtitle: Text("Lat: ${wp.latitud}, Lon: ${wp.longitud}\nMensaje: ${wp.mensaje}"),
                  trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteWaypoint(wp)),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(onPressed: _addWaypoint, child: const Icon(Icons.add)),
    );
  }
}
