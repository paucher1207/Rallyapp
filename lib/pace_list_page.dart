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

  final _distanciaController = TextEditingController();
  final _longitudController = TextEditingController();
  final _notaController = TextEditingController();
  final _latController = TextEditingController();
  final _lonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPaceData();
  }

  Future<void> _loadPaceData() async {
    final paceData = await DatabaseService.getPaceData(widget.stage.id);
    setState(() => _paceDataList = paceData);
  }

  Future<void> _addPaceData() async {
    _distanciaController.clear();
    _longitudController.clear();
    _notaController.clear();
    _latController.clear();
    _lonController.clear();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nuevo Pace Note"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _distanciaController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Distancia")),
              TextField(controller: _longitudController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Longitud Curva")),
              TextField(controller: _notaController, decoration: const InputDecoration(labelText: "Nota")),
              TextField(controller: _latController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Latitud")),
              TextField(controller: _lonController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Longitud")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              final distancia = int.tryParse(_distanciaController.text);
              final longitud = int.tryParse(_longitudController.text);
              final nota = _notaController.text;
              final lat = double.tryParse(_latController.text);
              final lon = double.tryParse(_lonController.text);

              if (distancia == null || longitud == null || nota.isEmpty || lat == null || lon == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Rellena todos los campos correctamente")),
                );
                return;
              }

              await DatabaseService.addPaceData(widget.stage.id, distancia, longitud, nota, lat, lon);
              Navigator.pop(context);
              _loadPaceData();
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  Future<void> _deletePace(PaceData pd) async {
    await DatabaseService.deletePaceData(pd.id);
    _loadPaceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pace Notes: ${widget.stage.nom}")),
      body: _paceDataList.isEmpty
          ? const Center(child: Text("No hay registros todavía"))
          : ListView.builder(
              itemCount: _paceDataList.length,
              itemBuilder: (_, index) {
                final pd = _paceDataList[index];
                return ListTile(
                  title: Text("Distancia: ${pd.distancia} m | Curva: ${pd.longitudCurva}"),
                  subtitle: Text("Nota: ${pd.nota}\nLat: ${pd.latitud}, Lon: ${pd.longitud}"),
                  trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deletePace(pd)),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(onPressed: _addPaceData, child: const Icon(Icons.add)),
    );
  }
}
