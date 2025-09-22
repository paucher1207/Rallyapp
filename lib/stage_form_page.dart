import 'package:flutter/material.dart';
import '../models.dart';
import 'database_service.dart';

class StageFormPage extends StatefulWidget {
  final Stage? stage; // null = crear, no null = editar

  const StageFormPage({super.key, this.stage});

  @override
  State<StageFormPage> createState() => _StageFormPageState();
}

class _StageFormPageState extends State<StageFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nomController;
  late TextEditingController _distanciaController;
  DateTime? _horaSortida;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.stage?.nom ?? "");
    _distanciaController =
        TextEditingController(text: widget.stage?.distancia.toString() ?? "");
    _horaSortida = widget.stage?.horaSortida ?? DateTime.now();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _distanciaController.dispose();
    super.dispose();
  }

  Future<void> _pickHoraSortida() async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_horaSortida ?? DateTime.now()),
    );
    if (timeOfDay != null) {
      setState(() {
        final now = DateTime.now();
        _horaSortida = DateTime(
          now.year,
          now.month,
          now.day,
          timeOfDay.hour,
          timeOfDay.minute,
        );
      });
    }
  }

  Future<void> _saveStage() async {
    if (_formKey.currentState?.validate() ?? false) {
      final newStage = widget.stage ?? Stage();
      newStage.nom = _nomController.text;
      newStage.distancia = int.parse(_distanciaController.text);
      newStage.horaSortida = _horaSortida ?? DateTime.now();

      if (widget.stage == null) {
        await DatabaseService.createStage(newStage);
      } else {
        await DatabaseService.updateStage(newStage);
      }

      if (!mounted) return;
      Navigator.pop(context, true); // devolvemos true para refrescar listas
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.stage != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Editar Stage" : "Nuevo Stage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: "Nombre del Stage"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Introduce un nombre" : null,
              ),
              TextFormField(
                controller: _distanciaController,
                decoration: const InputDecoration(labelText: "Distancia (m)"),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? "Introduce la distancia"
                    : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(_horaSortida != null
                        ? "Hora salida: ${_horaSortida!.hour.toString().padLeft(2, '0')}:${_horaSortida!.minute.toString().padLeft(2, '0')}"
                        : "Selecciona hora de salida"),
                  ),
                  IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: _pickHoraSortida,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveStage,
                child: Text(isEditing ? "Guardar cambios" : "Crear Stage"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
