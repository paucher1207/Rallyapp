import 'package:flutter/material.dart';
import 'database.dart';
import 'models.dart';
import 'pace_form_dialog.dart';

class PaceListPage extends StatefulWidget {
  final Stage stage;

  const PaceListPage({super.key, required this.stage});

  @override
  State<PaceListPage> createState() => _PaceListPageState();
}

class _PaceListPageState extends State<PaceListPage> {
  List<PaceData> _paceNotes = [];

  @override
  void initState() {
    super.initState();
    _loadPaceNotes();
  }

  Future<void> _loadPaceNotes() async {
    final isar = await DatabaseService.openDB();
    final stageFresh = await isar.stages.get(widget.stage.id);
    await stageFresh!.paceNotes.load();

    setState(() {
      _paceNotes = stageFresh.paceNotes.toList();
    });
  }

  Future<void> _openFormDialog({PaceData? pace}) async {
    final result = await showDialog(
      context: context,
      builder: (_) => PaceFormDialog(stage: widget.stage, pace: pace),
    );
    if (result == true) _loadPaceNotes();
  }

  Future<void> _deletePace(PaceData pace) async {
    final isar = await DatabaseService.openDB();
    await isar.writeTxn(() async {
      await isar.paceDatas.delete(pace.id);
    });
    _loadPaceNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pace Notes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openFormDialog(),
          ),
        ],
      ),
      body: _paceNotes.isEmpty
          ? const Center(child: Text("No hay pace notes"))
          : ListView.builder(
              itemCount: _paceNotes.length,
              itemBuilder: (context, index) {
                final pace = _paceNotes[index];
                return ListTile(
                  title: Text("Distancia: ${pace.distancia} m"),
                  subtitle: Text("Nota: ${pace.nota}, Longitud curva: ${pace.longitudCurva} m"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openFormDialog(pace: pace),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deletePace(pace),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
