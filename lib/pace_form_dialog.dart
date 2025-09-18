import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models.dart';

class PaceFormDialog extends StatefulWidget {
  final int stageId;
  final PaceData? pace;

  const PaceFormDialog({
    super.key,
    required this.stageId,
    this.pace,
  });

  @override
  State<PaceFormDialog> createState() => _PaceFormDialogState();
}

class _PaceFormDialogState extends State<PaceFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _dbHelper = DatabaseHelper();

  late TextEditingController _distanciaController;
  late TextEditingController _longitudCurvaController;
  late TextEditingController _notaController;
  late TextEditingController _latitudController;
  late TextEditingController _longitudController;

  @override
  void initState() {
    super.initState();
    _distanciaController =
        TextEditingController(text: widget.pace?.distancia.toString() ?? "");
    _longitudCurvaController =
        TextEditingController(text: widget.pace?.longitudCurva.toString() ?? "");
    _notaController =
        TextEditingController(text: widget.pace?.nota ?? "");
    _latitudController =
        TextEditingController(text: widget.pace?.latitud.toString() ?? "");
    _longitudController =
        TextEditingController(text: widget.pace?.longitud.toString() ?? "");
  }

  @override
  void dispose() {
    _distanciaController.dispose();
    _longitudCurvaController.dispose();
    _notaController.dispose();
    _latitudController.dispose();
    _longitudController.dispose();
    super.dispose();
  }

  Future<void> _savePace() async {
    if (_formKey.currentState?.validate() ?? false) {
      final newPace = PaceData(
        id: widget.pace?.id,
        stageId: widget.stageId,
        distancia: int.parse(_distanciaController.text),
        longitudCurva: int.parse(_longitudCurvaController.text),
        nota: _notaController.text,
        latitud: double.tryParse(_latitudController.text) ?? 0.0,
        longitud: double.tryParse(_longitudController.text) ?? 0.0,
      );

      if (widget.pace == null) {
        await _dbHelper.insertPaceData(newPace);
      } else {
        await _dbHelper.updatePaceData(newPace);
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.pace != null;

    return AlertDialog(
      title: Text(isEditing ? "Editar Pace Note" : "Nueva Pace Note"),
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
                controller: _longitudCurvaController,
                decoration: const InputDecoration(labelText: "Longitud de curva (m)"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Introduce longitud de curva" : null,
              ),
              TextFormField(
                controller: _notaController,
                decoration: const InputDecoration(labelText: "Nota / Texto"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Introduce una nota" : null,
              ),
              TextFormField(
                controller: _latitudController,
                decoration: const InputDecoration(labelText: "Latitud"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _longitudController,
                decoration: const InputDecoration(labelText: "Longitud"),
                keyboardType: TextInputType.number,
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
          onPressed: _savePace,
          child: Text(isEditing ? "Guardar" : "Añadir"),
        ),
      ],
    );
  }
}
