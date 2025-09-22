import 'package:flutter/material.dart';
import 'database.dart';
import 'models.dart';

class PaceFormDialog extends StatefulWidget {
  final Stage stage;
  final PaceData? pace;

  const PaceFormDialog({super.key, required this.stage, this.pace});

  @override
  State<PaceFormDialog> createState() => _PaceFormDialogState();
}

class _PaceFormDialogState extends State<PaceFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _distanciaController;
  late TextEditingController _longitudCurvaController;
  late TextEditingController _notaController;

  @override
  void initState() {
    super.initState();
    _distanciaController = TextEditingController(text: widget.pace?.distancia.toString() ?? "");
    _longitudCurvaController = TextEditingController(text: widget.pace?.longitudCurva.toString() ?? "");
    _notaController = TextEditingController(text: widget.pace?.nota ?? "");
  }

  @override
  void dispose() {
    _distanciaController.dispose();
    _longitudCurvaController.dispose();
    _notaController.dispose();
    super.dispose();
  }

  Future<void> _savePace() async {
    if (_formKey.currentState?.validate() ?? false) {
      final isar = await DatabaseService.openDB();

      await isar.writeTxn(() async {
        if (widget.pace == null) {
          final pace = PaceData()
            ..distancia = int.parse(_distanciaController.text)
            ..longitudCurva = int.parse(_longitudCurvaController.text)
            ..nota = _notaController.text
            ..stage.value = widget.stage;

          await isar.paceDatas.put(pace);
          await pace.stage.save();
        } else {
          widget.pace!
            ..distancia = int.parse(_distanciaController.text)
            ..longitudCurva = int.parse(_longitudCurvaController.text)
            ..nota = _notaController.text;

          await isar.paceDatas.put(widget.pace!);
        }
      });

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
              controller: _longitudCurvaController,
              decoration: const InputDecoration(labelText: "Longitud curva (m)"),
              keyboardType: TextInputType.number,
              validator: (v) => v == null || v.isEmpty ? "Introduce la longitud de la curva" : null,
            ),
            TextFormField(
              controller: _notaController,
              decoration: const InputDecoration(labelText: "Nota"),
              validator: (v) => v == null || v.isEmpty ? "Introduce la nota" : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
        ElevatedButton(onPressed: _savePace, child: Text(isEditing ? "Guardar" : "Añadir")),
      ],
    );
  }
}
