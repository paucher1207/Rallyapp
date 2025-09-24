import 'package:flutter/material.dart';
import '../models.dart';
import 'database_service.dart';

class PaceFormPage extends StatefulWidget {
  final Stage stage;
  final PaceData? pace;

  const PaceFormPage({super.key, required this.stage, this.pace});

  @override
  State<PaceFormPage> createState() => _PaceFormPageState();
}

class _PaceFormPageState extends State<PaceFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _distanciaController;
  late TextEditingController _longitudController;
  late TextEditingController _notaController;
  late TextEditingController _latController;
  late TextEditingController _lonController;

  @override
  void initState() {
    super.initState();
    _distanciaController =
        TextEditingController(text: widget.pace?.distancia.toString() ?? "");
    _longitudController =
        TextEditingController(text: widget.pace?.longitudCurva.toString() ?? "");
    _notaController = TextEditingController(text: widget.pace?.nota ?? "");
    _latController =
        TextEditingController(text: widget.pace?.latitud.toString() ?? "");
    _lonController =
        TextEditingController(text: widget.pace?.longitud.toString() ?? "");
  }

  @override
  void dispose() {
    _distanciaController.dispose();
    _longitudController.dispose();
    _notaController.dispose();
    _latController.dispose();
    _lonController.dispose();
    super.dispose();
  }

  Future<void> _savePace() async {
    if (_formKey.currentState?.validate() ?? false) {
      final distancia = int.parse(_distanciaController.text);
      final longitud = int.parse(_longitudController.text);
      final nota = _notaController.text;
      final lat = double.parse(_latController.text);
      final lon = double.parse(_lonController.text);

      if (widget.pace == null) {
        await DatabaseService.addPaceData(widget.stage.id, distancia, longitud, nota, lat, lon);
      } else {
        widget.pace!
          ..distancia = distancia
          ..longitudCurva = longitud
          ..nota = nota
          ..latitud = lat
          ..longitud = lon;
        await DatabaseService.updatePaceData(widget.pace!);
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.pace != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Editar Pace Note" : "Nueva Pace Note")),
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
                controller: _longitudController,
                decoration: const InputDecoration(labelText: "Longitud curva"),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? "Introduce longitud curva" : null,
              ),
              TextFormField(
                controller: _notaController,
                decoration: const InputDecoration(labelText: "Nota"),
              ),
              TextFormField(
                controller: _latController,
                decoration: const InputDecoration(labelText: "Latitud"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: _lonController,
                decoration: const InputDecoration(labelText: "Longitud"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _savePace,
                child: Text(isEditing ? "Guardar cambios" : "Crear Pace Note"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
