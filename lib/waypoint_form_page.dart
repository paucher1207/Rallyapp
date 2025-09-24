import 'package:flutter/material.dart';
import '../models.dart';
import 'database_service.dart';

class WaypointFormPage extends StatefulWidget {
  final Stage stage;
  final RefWaypoint? waypoint;

  const WaypointFormPage({super.key, required this.stage, this.waypoint});

  @override
  State<WaypointFormPage> createState() => _WaypointFormPageState();
}

class _WaypointFormPageState extends State<WaypointFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _distanciaController;
  late TextEditingController _latController;
  late TextEditingController _lonController;
  late TextEditingController _mensajeController;

  @override
  void initState() {
    super.initState();
    _distanciaController = TextEditingController(
        text: widget.waypoint?.distancia.toString() ?? "");
    _latController = TextEditingController(
        text: widget.waypoint?.latitud.toString() ?? "");
    _lonController = TextEditingController(
        text: widget.waypoint?.longitud.toString() ?? "");
    _mensajeController = TextEditingController(
        text: widget.waypoint?.mensaje ?? "");
  }

  @override
  void dispose() {
    _distanciaController.dispose();
    _latController.dispose();
    _lonController.dispose();
    _mensajeController.dispose();
    super.dispose();
  }

  Future<void> _saveWaypoint() async {
    if (_formKey.currentState?.validate() ?? false) {
      final distancia = int.parse(_distanciaController.text);
      final lat = double.parse(_latController.text);
      final lon = double.parse(_lonController.text);
      final mensaje = _mensajeController.text;

      if (widget.waypoint == null) {
        await DatabaseService.addWaypoint(
            widget.stage.id, distancia, lat, lon, mensaje);
      } else {
        widget.waypoint!
          ..distancia = distancia
          ..latitud = lat
          ..longitud = lon
          ..mensaje = mensaje;
        await DatabaseService.updateWaypoint(widget.waypoint!);
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.waypoint != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Editar Waypoint" : "Nuevo Waypoint")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _distanciaController,
                decoration: const InputDecoration(labelText: "Distancia (m)"),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? "Introduce distancia" : null,
              ),
              TextFormField(
                controller: _latController,
                decoration: const InputDecoration(labelText: "Latitud"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) => v == null || v.isEmpty ? "Introduce latitud" : null,
              ),
              TextFormField(
                controller: _lonController,
                decoration: const InputDecoration(labelText: "Longitud"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) => v == null || v.isEmpty ? "Introduce longitud" : null,
              ),
              TextFormField(
                controller: _mensajeController,
                decoration: const InputDecoration(labelText: "Mensaje"),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveWaypoint,
                child: Text(isEditing ? "Guardar cambios" : "Crear Waypoint"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
