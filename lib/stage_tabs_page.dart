import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../models.dart'; // tu modelo Stage, Average, RefWaypoint, PaceData

class StageTabsPage extends StatefulWidget {
  final Isar isar;

  const StageTabsPage({super.key, required this.isar});

  @override
  State<StageTabsPage> createState() => _StageTabsPageState();
}

class _StageTabsPageState extends State<StageTabsPage> {
  late Future<List<Stage>> stagesFuture;

  @override
  void initState() {
    super.initState();
    stagesFuture = _loadStages();
  }

  Future<List<Stage>> _loadStages() async {
    return await widget.isar.stages.where().findAll();
  }

  // ------------------ Añadir Stage ------------------
  Future<void> _addStage() async {
    final controllerNom = TextEditingController();
    final controllerDistancia = TextEditingController();
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nuevo Stage"),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controllerNom,
                  decoration: const InputDecoration(labelText: "Nombre"),
                ),
                TextField(
                  controller: controllerDistancia,
                  decoration: const InputDecoration(labelText: "Distancia (m)"),
                  keyboardType: TextInputType.number,
                ),
                TextButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) setState(() => selectedDate = date);
                  },
                  child: Text(selectedDate == null
                      ? "Seleccionar fecha"
                      : "Fecha: ${selectedDate!.toLocal().toIso8601String().split('T')[0]}"),
                ),
                TextButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) setState(() => selectedTime = time);
                  },
                  child: Text(selectedTime == null
                      ? "Seleccionar hora"
                      : "Hora: ${selectedTime!.format(context)}"),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              if (selectedDate == null || selectedTime == null) return;

              final horaSortida = DateTime(
                selectedDate!.year,
                selectedDate!.month,
                selectedDate!.day,
                selectedTime!.hour,
                selectedTime!.minute,
              );

              final stage = Stage()
                ..nom = controllerNom.text
                ..distancia = int.tryParse(controllerDistancia.text) ?? 0
                ..horaSortida = horaSortida;

              await widget.isar.writeTxn(() async {
                await widget.isar.stages.put(stage);
              });

              Navigator.pop(context);
              setState(() => stagesFuture = _loadStages());
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  // ------------------ Editar Stage ------------------
  Future<void> _editStage(Stage stage) async {
    final controllerNom = TextEditingController(text: stage.nom);
    final controllerDistancia = TextEditingController(text: stage.distancia.toString());
    DateTime selectedDate = stage.horaSortida;
    TimeOfDay selectedTime = TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar Stage"),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controllerNom,
                  decoration: const InputDecoration(labelText: "Nombre"),
                ),
                TextField(
                  controller: controllerDistancia,
                  decoration: const InputDecoration(labelText: "Distancia (m)"),
                  keyboardType: TextInputType.number,
                ),
                TextButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) setState(() => selectedDate = date);
                  },
                  child: Text("Fecha: ${selectedDate.toLocal().toIso8601String().split('T')[0]}"),
                ),
                TextButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (time != null) setState(() => selectedTime = time);
                  },
                  child: Text("Hora: ${selectedTime.format(context)}"),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              final horaSortida = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              );

              stage.nom = controllerNom.text;
              stage.distancia = int.tryParse(controllerDistancia.text) ?? 0;
              stage.horaSortida = horaSortida;

              await widget.isar.writeTxn(() async {
                await widget.isar.stages.put(stage);
              });

              Navigator.pop(context);
              setState(() => stagesFuture = _loadStages());
            },
            child: const Text("Guardar cambios"),
          ),
        ],
      ),
    );
  }

  // ------------------ Eliminar Stage ------------------
  Future<void> _deleteStage(Stage stage) async {
    await widget.isar.writeTxn(() async {
      await widget.isar.stages.delete(stage.id);
    });
    setState(() => stagesFuture = _loadStages());
  }

  // ------------------ Build ------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stages")),
      body: FutureBuilder<List<Stage>>(
        future: stagesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final stages = snapshot.data!;
          if (stages.isEmpty) return const Center(child: Text("No hay stages todavía"));

          return ListView.builder(
            itemCount: stages.length,
            itemBuilder: (context, index) {
              final stage = stages[index];
              return ListTile(
                title: Text(stage.nom),
                subtitle: Text(
                  "Distancia: ${stage.distancia} m\nHora salida: ${stage.horaSortida.toLocal().toString().substring(0,16)}",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editStage(stage),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteStage(stage),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
