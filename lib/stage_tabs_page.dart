import 'package:flutter/material.dart';
import '../models.dart';
import 'stage_detail_page.dart';
import 'database_service.dart';

class StageTabsPage extends StatefulWidget {
  const StageTabsPage({super.key});

  @override
  State<StageTabsPage> createState() => _StageTabsPageState();
}

class _StageTabsPageState extends State<StageTabsPage> {
  final ValueNotifier<List<Stage>> stagesNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _loadStages();
  }

  Future<void> _loadStages() async {
    final stages = await DatabaseService.getStagesWithExtras();
    stagesNotifier.value = stages;
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

              await DatabaseService.createStage(stage);

              Navigator.pop(context);
              _loadStages(); // actualizamos automáticamente la lista
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

              await DatabaseService.updateStage(stage);

              Navigator.pop(context);
              _loadStages(); // actualización automática
            },
            child: const Text("Guardar cambios"),
          ),
        ],
      ),
    );
  }

  // ------------------ Eliminar Stage ------------------
  Future<void> _deleteStage(Stage stage) async {
    await DatabaseService.deleteStage(stage.id);
    _loadStages(); // actualización automática
  }

  // ------------------ Build ------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stages")),
      body: ValueListenableBuilder<List<Stage>>(
        valueListenable: stagesNotifier,
        builder: (context, stages, _) {
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
                onTap: () {
                  // Navegar a StageDetailPage sin pasar isar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StageDetailPage(stage: stage),
                    ),
                  );
                },
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
