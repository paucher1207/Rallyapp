import 'package:flutter/material.dart';
import '../models.dart';
import 'database_service.dart';
import 'average_form_page.dart';

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
    final averages = await DatabaseService.getAveragesByStage(widget.stage.id);
    setState(() {
      _averages = averages;
    });
  }

  Future<void> _deleteAverage(Average avg) async {
    await DatabaseService.deleteAverage(avg.id);
    await _loadAverages();
  }

  Future<void> _openAverageForm({Average? avg}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AverageFormPage(stage: widget.stage, average: avg),
      ),
    );

    if (result == true) {
      await _loadAverages(); // refresca la lista al volver
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Averages: ${widget.stage.nom}")),
      body: _averages.isEmpty
          ? const Center(child: Text("No hay velocidades medias todavía"))
          : ListView.builder(
              itemCount: _averages.length,
              itemBuilder: (context, index) {
                final avg = _averages[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text("Distancia inicio: ${avg.distanciaInicio} m"),
                    subtitle: Text("Velocidad media: ${avg.velocidadMedia} m/s"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _openAverageForm(avg: avg),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteAverage(avg),
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
