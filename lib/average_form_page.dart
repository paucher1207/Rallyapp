import 'package:flutter/material.dart';
import '../models.dart';
import 'database_service.dart';

class AverageFormPage extends StatefulWidget {
  final Stage stage;
  final Average? average; // null = crear, no null = editar

  const AverageFormPage({super.key, required this.stage, this.average});

  @override
  State<AverageFormPage> createState() => _AverageFormPageState();
}

class _AverageFormPageState extends State<AverageFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _distanciaController;
  late TextEditingController _velocidadController;

  @override
  void initState() {
    super.initState();
    _distanciaController = TextEditingController(
        text: widget.average?.distanciaInicio.toString() ?? "");
    _velocidadController = TextEditingController(
        text: widget.average?.velocidadMedia.toString() ?? "");
  }

  @override
  void dispose() {
    _distanciaController.dispose();
    _velocidadController.dispose();
    super.dispose();
  }

  Future<void> _saveAverage() async {
    if (_formKey.currentState?.validate() ?? false) {
      final distancia = int.parse(_distanciaController.text);
      final velocidad = double.parse(_velocidadController.text);

      if (widget.average == null) {
        // Crear nuevo Average
        await DatabaseService.addAverage(
            widget.stage.id, distancia, velocidad);
      } else {
        // Editar existente
        widget.average!.distanciaInicio = distancia;
        widget.average!.velocidadMedia = velocidad;
        await DatabaseService.updateAverage(widget.average!);
      }

      if (!mounted) return;
      Navigator.pop(context, true); // devuelve true para refrescar lista
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.average != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Editar Average" : "Nuevo Average")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _distanciaController,
                decoration: const InputDecoration(labelText: "Distancia inicio (m)"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Introduce la distancia" : null,
              ),
              TextFormField(
                controller: _velocidadController,
                decoration: const InputDecoration(labelText: "Velocidad media (m/s)"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    value == null || value.isEmpty ? "Introduce la velocidad media" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveAverage,
                child: Text(isEditing ? "Guardar cambios" : "Crear Average"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
