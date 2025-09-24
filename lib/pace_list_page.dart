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
  final paceData = await DatabaseService.getPaceByStage(widget.stage);
  setState(() => _paceDataList = paceData);
}

Future<void> _addPaceData() async {
  final distanciaController = TextEditingController();
  final curvaController = TextEditingController();
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
          TextField(controller: curvaController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Longitud curva")),
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
            final curva = int.tryParse(curvaController.text);
            final lat = double.tryParse(latController.text);
            final lon = double.tryParse(lonController.text);
            final nota = notaController.text;
            if (distancia == null || curva == null || lat == null || lon == null || nota.isEmpty) return;

            await DatabaseService.addPaceData(widget.stage.id, distancia, curva, nota, lat, lon);
            Navigator.pop(context);
            await _loadPaceData(); // refresca lista automáticamente
          },
          child: const Text("Guardar"),
        ),
      ],
    ),
  );
}

  Future<void> _deletePaceData(PaceData pd) async {
    await DatabaseService.deletePaceData(pd.id);
    _loadPaceData();
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
                  title: Text("Distancia: ${pd.distancia} m"),
                  subtitle: Text("Nota: ${pd.nota}\nLongitud curva: ${pd.longitudCurva} m\nLat: ${pd.latitud}, Lon: ${pd.longitud}"),
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
