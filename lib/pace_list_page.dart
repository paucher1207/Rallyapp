import 'package:flutter/material.dart';
import '../models.dart';
import '../database_service.dart';

class PaceDataListPage extends StatefulWidget {
  final Stage stage;
  const PaceDataListPage({super.key, required this.stage});

  @override
  State<PaceDataListPage> createState() => _PaceDataListPageState();
}

class _PaceDataListPageState extends State<PaceDataListPage> {
  List<PaceData> _paceDataList = [];

  @override
  void initState() {
    super.initState();
    _loadPaceData();
  }

  Future<void> _loadPaceData() async {
    final list = await DatabaseService.getPaceData(widget.stage.id);
    setState(() => _paceDataList = list);
  }

  Future<void> _addPaceData() async {
    final controllerDist = TextEditingController();
    final controllerCurva = TextEditingController();
    final controllerNota = TextEditingController();
    final controllerLat = TextEditingController();
    final controllerLon = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nuevo Pace Data"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: controllerDist, decoration: const InputDecoration(labelText: "Distancia"), keyboardType: TextInputType.number),
            TextField(controller: controllerCurva, decoration: const InputDecoration(labelText: "Longitud curva"), keyboardType: TextInputType.number),
            TextField(controller: controllerNota, decoration: const InputDecoration(labelText: "Nota")),
            TextField(controller: controllerLat, decoration: const InputDecoration(labelText: "Latitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
            TextField(controller: controllerLon, decoration: const InputDecoration(labelText: "Longitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              await DatabaseService.addPaceData(
                widget.stage.id,
                int.tryParse(controllerDist.text) ?? 0,
                int.tryParse(controllerCurva.text) ?? 0,
                controllerNota.text,
                double.tryParse(controllerLat.text) ?? 0,
                double.tryParse(controllerLon.text) ?? 0,
              );
              Navigator.pop(context);
              _loadPaceData();
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  Future<void> _editPaceData(PaceData pd) async {
    final controllerDist = TextEditingController(text: pd.distancia.toString());
    final controllerCurva = TextEditingController(text: pd.longitudCurva.toString());
    final controllerNota = TextEditingController(text: pd.nota);
    final controllerLat = TextEditingController(text: pd.latitud.toString());
    final controllerLon = TextEditingController(text: pd.longitud.toString());

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar Pace Data"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: controllerDist, decoration: const InputDecoration(labelText: "Distancia"), keyboardType: TextInputType.number),
            TextField(controller: controllerCurva, decoration: const InputDecoration(labelText: "Longitud curva"), keyboardType: TextInputType.number),
            TextField(controller: controllerNota, decoration: const InputDecoration(labelText: "Nota")),
            TextField(controller: controllerLat, decoration: const InputDecoration(labelText: "Latitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
            TextField(controller: controllerLon, decoration: const InputDecoration(labelText: "Longitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              pd.distancia = int.tryParse(controllerDist.text) ?? pd.distancia;
              pd.longitudCurva = int.tryParse(controllerCurva.text) ?? pd.longitudCurva;
              pd.nota = controllerNota.text;
              pd.latitud = double.tryParse(controllerLat.text) ?? pd.latitud;
              pd.longitud = double.tryParse(controllerLon.text) ?? pd.longitud;

              await DatabaseService.updatePaceData(pd);
              Navigator.pop(context);
              _loadPaceData();
            },
            child: const Text("Guardar cambios"),
          ),
        ],
      ),
    );
  }

  Future<void> _deletePaceData(int id) async {
    await DatabaseService.deletePaceData(id);
    _loadPaceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pace Notes")),
      body: _paceDataList.isEmpty
          ? const Center(child: Text("No hay Pace Data"))
          : ListView.builder(
              itemCount: _paceDataList.length,
              itemBuilder: (context, i) {
                final pd = _paceDataList[i];
                return ListTile(
                  title: Text("Distancia: ${pd.distancia} | Nota: ${pd.nota}"),
                  subtitle: Text("Lat: ${pd.latitud}, Lon: ${pd.longitud}"),
                  onTap: () => _editPaceData(pd),
                  trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deletePaceData(pd.id)),
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

