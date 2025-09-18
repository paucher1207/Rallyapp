import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models.dart';
import 'average_form_dialog.dart';

class AverageListPage extends StatefulWidget {
  final Stage stage;

  const AverageListPage({super.key, required this.stage});

  @override
  State<AverageListPage> createState() => _AverageListPageState();
}

class _AverageListPageState extends State<AverageListPage> {
  final _dbHelper = DatabaseHelper();
  List<Average> _averages = [];

  @override
  void initState() {
    super.initState();
    _loadAverages();
  }

  Future<void> _loadAverages() async {
    final averages = await _dbHelper.getAveragesByStage(widget.stage.id!);
    setState(() {
      _averages = averages;
    });
  }

  Future<void> _deleteAverage(int id) async {
    await _dbHelper.deleteAverage(id);
    _loadAverages();
  }

  Future<void> _openAverageForm({Average? average}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AverageFormDialog(
        stageId: widget.stage.id!,
        average: average,
      ),
    );

    if (result == true) {
      _loadAverages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Velocidades medias - ${widget.stage.nom}"),
      ),
      body: _averages.isEmpty
          ? const Center(child: Text("No hay velocidades medias"))
          : ListView.builder(
              itemCount: _averages.length,
              itemBuilder: (context, index) {
                final avg = _averages[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text("${avg.velocidadMedia} km/h"),
                    subtitle: Text("Inicio en ${avg.distanciaInicio} m"),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "edit") {
                          _openAverageForm(average: avg);
                        } else if (value == "delete") {
                          _deleteAverage(avg.id!);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: "edit",
                          child: Text("Editar"),
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
        onPressed: () => _openAverageForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
