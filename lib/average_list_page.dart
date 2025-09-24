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
    final averages = await DatabaseService.getAverages(widget.stage.id);
    setState(() => _averages = averages);
  }

  // ------------------ Añadir Average ------------------
  Future<void> _addAverage() async {
    final controllerDist = TextEditingController();
    final controllerVel = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nuevo Average"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controllerDist,
              decoration: const InputDecoration(labelText: "Distancia inicio"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: controllerVel,
              decoration: const InputDecoration(labelText: "Velocidad media"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              final distancia = int.tryParse(controllerDist.text) ?? 0;
              final velocidad = double.tryParse(controllerVel.text) ?? 0;

              await DatabaseService.addAverage(widget.stage.id, distancia, velocidad);
              Navigator.pop(context);
              _loadAverages(); // refrescar la lista automáticamente
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  // ------------------ Editar Average ------------------
  Future<void> _editAverage(Average avg) async {
    final controllerDist = TextEditingController(text: avg.distanciaInicio.toString());
    final controllerVel = TextEditingController(text: avg.velocidadMedia.toString());

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar Average"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controllerDist,
              decoration: const InputDecoration(labelText: "Distancia inicio"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: controllerVel,
              decoration: const InputDecoration(labelText: "Velocidad media"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              avg.distanciaInicio = int.tryParse(controllerDist.text) ?? avg.distanciaInicio;
              avg.velocidadMedia = double.tryParse(controllerVel.text) ?? avg.velocidadMedia;

              await DatabaseService.updateAverage(avg); // ✅ pasamos el objeto completo
              Navigator.pop(context);
              _loadAverages();
            },
            child: const Text("Guardar cambios"),
          ),
        ],
      ),
    );
  }

  // ------------------ Eliminar Average ------------------
  Future<void> _deleteAverage(int id) async {
    await DatabaseService.deleteAverage(id);
    _loadAverages();
  }

  // ------------------ Build ------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Velocidades medias")),
      body: _averages.isEmpty
          ? const Center(child: Text("No hay Averages"))
          : ListView.builder(
              itemCount: _averages.length,
              itemBuilder: (context, i) {
                final avg = _averages[i];
                return ListTile(
                  title: Text("Distancia: ${avg.distanciaInicio} m"),
                  subtitle: Text("Velocidad media: ${avg.velocidadMedia} km/h"),
                  onTap: () => _editAverage(avg),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteAverage(avg.id),
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
