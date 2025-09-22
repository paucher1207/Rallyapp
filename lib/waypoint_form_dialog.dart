import 'package:flutter/material.dart';
import 'database.dart';
import 'models.dart';

class WaypointFormDialog extends StatefulWidget {
  final Stage stage;
  final RefWaypoint? waypoint;

  const WaypointFormDialog({super.key, required this.stage, this.waypoint});

  @override
  State<WaypointFormDialog> createState() => _WaypointFormDialogState();
}

class _WaypointFormDialogState extends State<WaypointFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _distanciaController;
  late TextEditingController _latController;
  late TextEditingController _lonController;

  bool _esManual = false;

  @override
  void initState() {
    super.initState();
    _distanciaController = TextEditingController(text: widget.waypoint?.distancia.toString() ?? "");
    _latController = TextEditingController(text: widget.waypoint?.latitud.toString() ?? "");
    _lonController = TextEditingController(text: widget.waypoint?.longitud.toString() ?? "");
    _esManual = widget.waypoint?.esManual ?? false;
  }

  @override
  void dispose() {
    _distanciaController.dispose();
    _latController.dispose();
    _lonController.dispose();
    super.dispose();
  }

  Future<void> _saveWaypoint() async {
    if (_formKey.currentState?.validate() ?? false) {
      final isar = await DatabaseService.openDB();

      await isar.writeTxn(() async {
        if (widget.waypoint == null) {
          final wp = RefWaypoint()
            ..distancia = int.parse(_distanciaController.text)
            ..latitud = double.parse(_latController.text)
            ..longitud = double.parse(_lonController.text)
            ..esManual = _esManual
            ..stage.value = widget.stage;

          await isar.refWaypoints.put(wp);
          await wp.stage.save();
        } else {
          widget.waypoint!
            ..distancia = int.parse(_distanciaController.text)
            ..latitud = double.parse(_latController.text)
            ..longitud = double.parse(_lonController.text)
            ..esManual = _esManual;

          await isar.refWaypoints.put(widget.waypoint!);
        }
      });

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _distanciaController,
              decoration: const InputDecoration(labelText: "Distancia (m)"),
              keyboardType: TextInputType.number,
              validator: (v) => v == null || v.isEmpty ? "Introduce la distancia" : null,
            ),
            TextFormField(
              controller: _latController,
              decoration: const InputDecoration(labelText: "Latitud"),
              keyboardType: TextInputType.number,
              validator: (v) => v == null || v.isEmpty ? "Introduce la latitud" : null,
            ),
            TextFormField(
              controller: _lonController,
              decoration: const InputDecoration(labelText: "Longitud"),
              keyboardType: TextInputType.number,
              validator: (v) => v == null || v.isEmpty ? "Introduce la longitud" : null,
            ),
            SwitchListTile(
              title: const Text("Manual"),
              value: _esManual,
              onChanged: (val) => setState(() => _esManual = val),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
        ElevatedButton(onPressed: _saveWaypoint, child: Text(isEditing ? "Guardar" : "Añadir")),
      ],
    );
  }
}
