import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models.dart';

class WaypointFormDialog extends StatefulWidget {
  final int stageId;
  final RefWaypoint? waypoint;

  const WaypointFormDialog({
    super.key,
    required this.stageId,
    this.waypoint,
  });

  @override
  State<WaypointFormDialog> createState() => _WaypointFormDialogState();
}

class _WaypointFormDialogState extends State<WaypointFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _dbHelper = DatabaseHelper();

  late TextEditingController _distanciaController;
  late TextEditingController _latController;
  late TextEditingController _lngController;
  late TextEditingController _errorController;
  late TextEditingController _mensajeController;
  late TextEditingController _capController;
  bool _esManual = false;

  @override
  void initState() {
    super.initState();
    _distanciaController =
        TextEditingController(text: widget.waypoint?.distancia.toString() ?? "");
    _latController =
        TextEditingController(text: widget.waypoint?.latitud.toString() ?? "");
    _lngController =
        TextEditingController(text: widget.waypoint?.longitud.toString() ?? "");
    _errorController =
        TextEditingController(text: widget.waypoint?.error.toString() ?? "");
    _mensajeController =
        TextEditingController(text: widget.waypoint?.mensaje ?? "");
    _capController =
        TextEditingController(text: widget.waypoint?.cap.toString() ?? "");
    _esManual = widget.waypoint?.esManual ?? false;
  }

  @override
  void dispose() {
    _distanciaController.dispose();
    _latController.dispose();
    _lngController.dispose();
    _errorController.dispose();
    _mensajeController.dispose();
    _capController.dispose();
    super.dispose();
  }

  Future<void> _saveWaypoint() async {
    if (_formKey.currentState?.validate() ?? false) {
      final newWp = RefWaypoint(
        id: widget.waypoint?.id,
        stageId: widget.stageId,
        distancia: int.parse(_distanciaController.text),
        latitud: double.parse(_latController.text),
        longitud: double.parse(_lngController.text),
        error: double.tryParse(_errorController.text) ?? 0.0,
        mensaje: _mensajeController.text,
        cap: double.tryParse(_capController.text) ?? 0.0,
        esManual: _esManual,
      );

      if (widget.waypoint == null) {
        await _dbHelper.insertRefWaypoint(newWp);
      } else {
        await _dbHelper.updateRefWaypoint(newWp);
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.waypoint != null;

    return AlertDialog(
      title: Text(isEditing ? "Editar Waypoint" : "Nuevo Waypoint"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _distanciaController,
                decoration: const InputDecoration(labelText: "Distancia (m)"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Introduce distancia" : null,
              ),
              TextFormField(
                controller: _latController,
                decoration: const InputDecoration(labelText: "Latitud"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Introduce latitud" : null,
              ),
              TextFormField(
                controller: _lngController,
                decoration: const InputDecoration(labelText: "Longitud"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Introduce longitud" : null,
              ),
              TextFormField(
                controller: _errorController,
                decoration: const InputDecoration(labelText: "Error estimado"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _mensajeController,
                decoration: const InputDecoration(labelText: "Mensaje"),
              ),
              TextFormField(
                controller: _capController,
                decoration: const InputDecoration(labelText: "Cap (grados)"),
                keyboardType: TextInputType.number,
              ),
              CheckboxListTile(
                title: const Text("Waypoint manual"),
                value: _esManual,
                onChanged: (val) {
                  setState(() {
                    _esManual = val ?? false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: _saveWaypoint,
          child: Text(isEditing ? "Guardar" : "Añadir"),
        ),
      ],
    );
  }
}
