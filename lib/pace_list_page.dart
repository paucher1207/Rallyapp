import 'package:flutter/material.dart';
import '../models.dart';
import 'database_service.dart';
import 'pace_form_page.dart';

class PaceDataListPage extends StatefulWidget {
  final Stage stage;

  const PaceDataListPage({super.key, required this.stage});

  @override
  State<PaceDataListPage> createState() => _PaceDataListPageState();
}

class _PaceDataListPageState extends State<PaceDataListPage> {
  List<PaceData> _paces = [];

  @override
  void initState() {
    super.initState();
    _loadPace();
  }

  Future<void> _loadPace() async {
    final paces = await DatabaseService.getPaceDataByStage(widget.stage.id);
    setState(() {
      _paces = paces;
    });
  }

  Future<void> _deletePace(PaceData pd) async {
    await DatabaseService.deletePaceData(pd.id);
    await _loadPace();
  }

  Future<void> _openPaceForm({PaceData? pd}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaceFormPage(stage: widget.stage, pace: pd),
      ),
    );

    if (result == true) {
      await _loadPace();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pace Notes: ${widget.stage.nom}")),
      body: _paces.isEmpty
          ? const Center(child: Text("No hay Pace Notes todavía"))
          : ListView.builder(
              itemCount: _paces.length,
              itemBuilder: (context, index) {
                final pd = _paces[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text("Distancia: ${pd.distancia} m | Longitud curva: ${pd.longitudCurva}"),
                    subtitle: Text("Nota: ${pd.nota}\nLat: ${pd.latitud}, Lon: ${pd.longitud}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _openPaceForm(pd: pd),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deletePace(pd),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openPaceForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
