import 'package:flutter/material.dart';
import 'database.dart';
import 'models.dart';
import 'average_form_dialog.dart';

class AverageListPage extends StatefulWidget {
  final Stage stage;

  const AverageListPage({super.key, required this.stage});

  @override
  State<AverageListPage> createState() => _AverageListPageState();
}

class _AverageListPageState extends State<AverageListPage> {
  List<Average> _averages = [];

  @override
  void initState() {
    super.initState();
    _loadAverages();
  }

  Future<void> _loadAverages() async {
    final isar = await DatabaseService.openDB();
    final stageFresh = await isar.stages.get(widget.stage.id);
    await stageFresh!.averages.load();

    setState(() {
      _averages = stageFresh.averages.toList();
    });
  }

  Future<void> _openFormDialog({Average? average}) async {
    final result = await showDialog(
      context: context,
      builder: (_) => AverageFormDialog(stage: widget.stage, average: average),
    );

    if (result == true) {
      _loadAverages();
    }
  }

  Future<void> _deleteAverage(Average average) async {
    final isar = await DatabaseService.openDB();
    await isar.writeTxn(() async {
      await isar.averages.delete(average.id);
    });
    _loadAverages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Velocidades Medias"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openFormDialog(),
          )
        ],
      ),
      body: _averages.isEmpty
          ? const Center(child: Text("No hay velocidades medias"))
          : ListView.builder(
              itemCount: _averages.length,
              itemBuilder: (context, index) {
                final avg = _averages[index];
                return ListTile(
                  title: Text("Distancia: ${avg.distanciaInicio} m"),
                  subtitle: Text("Velocidad media: ${avg.velocidadMedia} km/h"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openFormDialog(average: avg),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteAverage(avg),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
