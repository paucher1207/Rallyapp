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

  final _distanciaController = TextEditingController();
  final _velocidadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAverages();
  }

  Future<void> _loadAverages() async {
    final averages = await DatabaseService.getAverages(widget.stage.id);
    setState(() => _averages = averages);
  }

  Future<void> _addAverage() async {
    _distanciaController.clear();
    _velocidadController.clear();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nueva Velocidad Media"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _distanciaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Distancia Inicio (m)"),
            ),
            TextField(
              controller: _velocidadController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Velocidad Media"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              final distancia = int.tryParse(_distanciaController.text);
              final velocidad = double.tryParse(_velocidadController.text);

              if (distancia == null || velocidad == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Rellena todos los campos correctamente")),
                );
                return;
              }

              await DatabaseService.addAverage(widget.stage.id, distancia, velocidad);
              Navigator.pop(context);
              _loadAverages();
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
      appBar: AppBar(title: Text("Velocidades Medias: ${widget.stage.nom}")),
      body: _averages.isEmpty
          ? const Center(child: Text("No hay registros todavía"))
          : ListView.builder(
              itemCount: _averages.length,
              itemBuilder: (_, index) {
                final avg = _averages[index];
                return ListTile(
                  title: Text("Distancia: ${avg.distanciaInicio} m"),
                  subtitle: Text("Velocidad Media: ${avg.velocidadMedia.toStringAsFixed(2)}"),
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
