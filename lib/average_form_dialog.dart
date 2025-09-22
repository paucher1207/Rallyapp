import 'package:flutter/material.dart';
import 'database.dart';
import 'models.dart';

class AverageFormDialog extends StatefulWidget {
  final Stage stage; // ahora pasamos el objeto Stage completo
  final Average? average;

  const AverageFormDialog({
    super.key,
    required this.stage,
    this.average,
  });

  @override
  State<AverageFormDialog> createState() => _AverageFormDialogState();
}

class _AverageFormDialogState extends State<AverageFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _distanciaInicioController;
  late TextEditingController _velocidadMediaController;

  @override
  void initState() {
    super.initState();
    _distanciaInicioController = TextEditingController(
        text: widget.average?.distanciaInicio.toString() ?? "");
    _velocidadMediaController = TextEditingController(
        text: widget.average?.velocidadMedia.toString() ?? "");
  }

  @override
  void dispose() {
    _distanciaInicioController.dispose();
    _velocidadMediaController.dispose();
    super.dispose();
  }

  Future<void> _saveAverage() async {
    if (_formKey.currentState?.validate() ?? false) {
      final isar = await DatabaseService.openDB();

      await isar.writeTxn(() async {
        if (widget.average == null) {
          // crear nuevo
          final avg = Average()
            ..distanciaInicio = int.parse(_distanciaInicioController.text)
            ..velocidadMedia = double.parse(_velocidadMediaController.text)
            ..stage.value = widget.stage;

          await isar.averages.put(avg);
          await avg.stage.save();
        } else {
          // actualizar existente
          widget.average!
            ..distanciaInicio = int.parse(_distanciaInicioController.text)
            ..velocidadMedia = double.parse(_velocidadMediaController.text);

          await isar.averages.put(widget.average!);
        }
      });

      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.average != null;

    return AlertDialog(
      title: Text(isEditing ? "Editar Velocidad Media" : "Nueva Velocidad Media"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _distanciaInicioController,
              decoration: const InputDecoration(labelText: "Distancia inicio (m)"),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? "Introduce la distancia" : null,
            ),
            TextFormField(
              controller: _velocidadMediaController,
              decoration: const InputDecoration(labelText: "Velocidad media (km/h)"),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? "Introduce la velocidad" : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: _saveAverage,
          child: Text(isEditing ? "Guardar" : "Añadir"),
        ),
      ],
    );
  }
}
