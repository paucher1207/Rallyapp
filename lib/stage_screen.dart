import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'models.dart'; // tu archivo con Stage, Average, RefWaypoint, PaceData

class StageScreen extends StatefulWidget {
  final Isar isar;

  const StageScreen({super.key, required this.isar});

  @override
  _StageScreenState createState() => _StageScreenState();
}

class _StageScreenState extends State<StageScreen> {
  late Future<List<Stage>> stagesFuture;

  @override
  void initState() {
    super.initState();
    stagesFuture = _loadStages();
  }

  Future<List<Stage>> _loadStages() async {
    return await widget.isar.stages.where().findAll();
  }

  Future<void> _addStage() async {
    final controllerNom = TextEditingController();
    final controllerDistancia = TextEditingController();
    DateTime hora = DateTime.now();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Nuevo Stage"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controllerNom,
              decoration: InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: controllerDistancia,
              decoration: InputDecoration(labelText: "Distancia (m)"),
              keyboardType: TextInputType.number,
            ),
            TextButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: hora,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() => hora = picked);
                }
              },
              child: Text("Seleccionar hora de salida: ${hora.toLocal()}"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              final stage = Stage()
                ..nom = controllerNom.text
                ..distancia = int.tryParse(controllerDistancia.text) ?? 0
                ..horaSortida = hora;

              await widget.isar.writeTxn(() async {
                await widget.isar.stages.put(stage);
              });

              Navigator.pop(context);
              setState(() => stagesFuture = _loadStages());
            },
            child: Text("Guardar"),
          ),
        ],
      ),
    );
  }

  Future<void> _editStage(Stage stage) async {
    final controllerNom = TextEditingController(text: stage.nom);
    final controllerDistancia = TextEditingController(text: stage.distancia.toString());
    DateTime hora = stage.horaSortida;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Editar Stage"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controllerNom,
              decoration: InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: controllerDistancia,
              decoration: InputDecoration(labelText: "Distancia (m)"),
              keyboardType: TextInputType.number,
            ),
            TextButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: hora,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() => hora = picked);
                }
              },
              child: Text("Seleccionar hora de salida: ${hora.toLocal()}"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              stage.nom = controllerNom.text;
              stage.distancia = int.tryParse(controllerDistancia.text) ?? 0;
              stage.horaSortida = hora;

              await widget.isar.writeTxn(() async {
                await widget.isar.stages.put(stage);
              });

              Navigator.pop(context);
              setState(() => stagesFuture = _loadStages());
            },
            child: Text("Guardar cambios"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteStage(Stage stage) async {
    await widget.isar.writeTxn(() async {
      await widget.isar.stages.delete(stage.id);
    });
    setState(() => stagesFuture = _loadStages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stages")),
      body: FutureBuilder<List<Stage>>(
        future: stagesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final stages = snapshot.data!;
          if (stages.isEmpty) return Center(child: Text("No hay stages todavía"));

          return ListView.builder(
            itemCount: stages.length,
            itemBuilder: (context, index) {
              final stage = stages[index];
              return ListTile(
                title: Text(stage.nom),
                subtitle: Text(
                  "Distancia: ${stage.distancia} m\nHora salida: ${stage.horaSortida.toLocal()}",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editStage(stage),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
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
        child: Icon(Icons.add),
      ),
    );
  }
}
