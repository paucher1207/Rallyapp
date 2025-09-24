import 'package:flutter/material.dart';
import '../models.dart';
import '../database_service.dart';

class PaceListPage extends StatefulWidget {
  final Stage stage;

  const PaceListPage({super.key, required this.stage});

  @override
  State<PaceListPage> createState() => _PaceListPageState();
}

class _PaceListPageState extends State<PaceListPage> {
  List<PaceData> _paceDataList = [];

  @override
  void initState() {
    super.initState();
    _loadPaceData();
  }

  Future<void> _loadPaceData() async {
    final paceData = await DatabaseService.getPaceByStage(widget.stage.id);
    setState(() => _paceDataList = paceData);
  }

  Future<void> _addPaceData() async {
    final distanciaController = TextEditingController();
    final longitudController = TextEditingController();
    final notaController = TextEditingController();
    final latController = TextEditingController();
    final lonController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nuevo Pace Data"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: distanciaController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Distancia")),
            TextField(controller: longitudController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Longitud Curva")),
            TextField(controller: notaController, decoration: const InputDecoration(labelText: "Nota")),
            TextField(controller: latController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Latitud")),
            TextField(controller: lonController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Longitud")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              final distancia = int.tryParse(distanciaController.text);
              final longitudCurva = int.tryParse(longitudController.text);
              final nota = notaController.text;
              final lat = double.tryParse(latController.text);
              final lon = double.tryParse(lonController.text);

              if (distancia == null || longitudCurva == null || nota.isEmpty || lat == null || lon == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Rellena todos los campos correctamente")));
                return;
              }

              final id = await DatabaseService.addPaceData(widget.stage.id, distancia, longitudCurva, nota, lat, lon);
              if (id != -1) {
                Navigator.pop(context);
                _loadPaceData(); // refresca lista
              }
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  Future<void> _deletePaceData(PaceData pd) async {
    await DatabaseService.deletePaceData(pd.id);
    _loadPaceData(); // refresca lista
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pace Notes: ${widget.stage.nom}")),
      body: _paceDataList.isEmpty
          ? const Center(child: Text("No hay Pace Notes todavía"))
          : ListView.builder(
              itemCount: _paceDataList.length,
              itemBuilder: (context, index) {
                final pd = _paceDataList[index];
                return ListTile(
                  title: Text("Distancia: ${pd.distancia} m | Curva: ${pd.longitudCurva} m"),
                  subtitle: Text("Nota: ${pd.nota}\nLat: ${pd.latitud}, Lon: ${pd.longitud}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deletePaceData(pd),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPaceData,
        child: const Icon(Icons.add),
      ),
    );
  }
}
