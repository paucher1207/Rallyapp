import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models.dart';
import 'pace_form_dialog.dart';

class PaceListPage extends StatefulWidget {
  final int stageId;

  const PaceListPage({super.key, required this.stageId});

  @override
  State<PaceListPage> createState() => _PaceListPageState();
}

class _PaceListPageState extends State<PaceListPage> {
  final _dbHelper = DatabaseHelper();
  List<PaceData> _paces = [];

  @override
  void initState() {
    super.initState();
    _loadPaces();
  }

  Future<void> _loadPaces() async {
    final paces = await _dbHelper.getPaceDataByStage(widget.stageId);
    setState(() {
      _paces = paces;
    });
  }

  Future<void> _openForm({PaceData? pace}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => PaceFormDialog(
        stageId: widget.stageId,
        pace: pace,
      ),
    );

    if (result == true) {
      _loadPaces();
    }
  }

  Future<void> _deletePace(int id) async {
    await _dbHelper.deletePaceData(id);
    _loadPaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pace Notes"),
      ),
      body: _paces.isEmpty
          ? const Center(child: Text("No hay pace notes"))
          : ListView.builder(
              itemCount: _paces.length,
              itemBuilder: (context, index) {
                final pace = _paces[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                        "Distancia: ${pace.distancia} m | Curva: ${pace.longitudCurva} m"),
                    subtitle: Text(
                        "Nota: ${pace.nota}\nLat: ${pace.latitud}, Lon: ${pace.longitud}"),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _openForm(pace: pace),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deletePace(pace.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
