import 'package:flutter/material.dart';
import '../models.dart';
import '../database_service.dart';


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
    final averages = await DatabaseService.getAveragesByStage(widget.stage);
    setState(() => _averages = averages);
  }

  Future<void> _addAverage() async {
    final distanciaController = TextEditingController();
    final velocidadController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nuevo Average"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: distanciaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Distancia inicio"),
            ),
            TextField(
              controller: velocidadController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Velocidad media"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              final distancia = int.tryParse(distanciaController.text);
              final velocidad = double.tryParse(velocidadController.text);

              if (distancia == null || velocidad == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Rellena todos los campos correctamente")),
                );
                return;
              }

              await DatabaseService.addAverage(widget.stage.id, distancia, velocidad);
              Navigator.pop(context);
              _loadAverages(); // refresca la lista
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAverage(Average avg) async {
    await DatabaseService.deleteAverage(avg.id);
    _loadAverages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Averages: ${widget.stage.nom}")),
      body: _averages.isEmpty
          ? const Center(child: Text("No hay averages todavía"))
          : ListView.builder(
              itemCount: _averages.length,
              itemBuilder: (context, index) {
                final avg = _averages[index];
                return ListTile(
                  title: Text("Distancia: ${avg.distanciaInicio} m"),
                  subtitle: Text("Velocidad media: ${avg.velocidadMedia.toStringAsFixed(2)}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteAverage(avg),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAverage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
