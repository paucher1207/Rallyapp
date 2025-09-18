import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models.dart';
import 'stage_form_page.dart';
import 'average_list_page.dart';

class StageListPage extends StatefulWidget {
  const StageListPage({super.key});

  @override
  State<StageListPage> createState() => _StageListPageState();
}

class _StageListPageState extends State<StageListPage> {
  final _dbHelper = DatabaseHelper();
  List<Stage> _stages = [];

  @override
  void initState() {
    super.initState();
    _loadStages();
  }

  Future<void> _loadStages() async {
    final stages = await _dbHelper.getStages();
    setState(() {
      _stages = stages;
    });
  }

  Future<void> _deleteStage(int id) async {
    await _dbHelper.deleteStage(id);
    _loadStages();
  }

  Future<void> _openStageForm({Stage? stage}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StageFormPage(stage: stage),
      ),
    );

    if (result == true) {
      _loadStages(); // refresca después de guardar
    }
  }

  void _openAverages(Stage stage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AverageListPage(stage: stage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stages"),
      ),
      body: _stages.isEmpty
          ? const Center(child: Text("No hay stages todavía"))
          : ListView.builder(
              itemCount: _stages.length,
              itemBuilder: (context, index) {
                final stage = _stages[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(stage.nom),
                    subtitle: Text(
                        "Distancia: ${stage.distancia} m | Salida: ${stage.horaSortida.hour.toString().padLeft(2, '0')}:${stage.horaSortida.minute.toString().padLeft(2, '0')}"),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "edit") {
                          _openStageForm(stage: stage);
                        } else if (value == "delete") {
                          _deleteStage(stage.id!);
                        } else if (value == "averages") {
                          _openAverages(stage);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: "edit",
                          child: Text("Editar"),
                        ),
                        const PopupMenuItem(
                          value: "averages",
                          child: Text("Velocidades medias"),
                        ),
                        const PopupMenuItem(
                          value: "delete",
                          child: Text("Eliminar"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openStageForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
