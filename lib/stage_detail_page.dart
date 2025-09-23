import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../models.dart';

class StageDetailPage extends StatefulWidget {
  final Isar isar;
  final Stage stage;

  const StageDetailPage({super.key, required this.isar, required this.stage});

  @override
  State<StageDetailPage> createState() => _StageDetailPageState();
}

class _StageDetailPageState extends State<StageDetailPage> {
  List<Average> averages = [];
  List<RefWaypoint> waypoints = [];
  List<PaceData> paceNotes = [];

  @override
  void initState() {
    super.initState();
    _loadStageDetails();
  }

  void _loadStageDetails() {
    averages = widget.stage.averages.toList();
    waypoints = widget.stage.waypoints.toList();
    paceNotes = widget.stage.paceNotes.toList();
    setState(() {});
  }

  // ------------------ CRUD Averages ------------------
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
              final avg = Average()
                ..distanciaInicio = int.tryParse(controllerDist.text) ?? 0
                ..velocidadMedia = double.tryParse(controllerVel.text) ?? 0
                ..stage.value = widget.stage;

              await widget.isar.writeTxn(() async {
                await widget.isar.averages.put(avg);
                await avg.stage.save();
              });

              Navigator.pop(context);
              _loadStageDetails();
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

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
              avg.distanciaInicio = int.tryParse(controllerDist.text) ?? 0;
              avg.velocidadMedia = double.tryParse(controllerVel.text) ?? 0;

              await widget.isar.writeTxn(() async {
                await widget.isar.averages.put(avg);
              });

              Navigator.pop(context);
              _loadStageDetails();
            },
            child: const Text("Guardar cambios"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAverage(Average avg) async {
    await widget.isar.writeTxn(() async {
      await widget.isar.averages.delete(avg.id);
    });
    _loadStageDetails();
  }

  // ------------------ CRUD Waypoints ------------------
  Future<void> _addWaypoint() async {
    final controllerDist = TextEditingController();
    final controllerLat = TextEditingController();
    final controllerLon = TextEditingController();
    final controllerError = TextEditingController();
    final controllerMensaje = TextEditingController();
    final controllerCap = TextEditingController();
    bool esManual = false;

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: const Text("Nuevo Waypoint"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: controllerDist, decoration: const InputDecoration(labelText: "Distancia"), keyboardType: TextInputType.number),
                TextField(controller: controllerLat, decoration: const InputDecoration(labelText: "Latitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
                TextField(controller: controllerLon, decoration: const InputDecoration(labelText: "Longitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
                TextField(controller: controllerError, decoration: const InputDecoration(labelText: "Error"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
                TextField(controller: controllerMensaje, decoration: const InputDecoration(labelText: "Mensaje")),
                TextField(controller: controllerCap, decoration: const InputDecoration(labelText: "Cap"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
                Row(
                  children: [
                    const Text("Manual"),
                    Checkbox(value: esManual, onChanged: (val) => setStateDialog(() => esManual = val ?? false)),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
            ElevatedButton(
              onPressed: () async {
                final wpt = RefWaypoint()
                  ..distancia = int.tryParse(controllerDist.text) ?? 0
                  ..latitud = double.tryParse(controllerLat.text) ?? 0
                  ..longitud = double.tryParse(controllerLon.text) ?? 0
                  ..error = double.tryParse(controllerError.text) ?? 0
                  ..mensaje = controllerMensaje.text
                  ..cap = double.tryParse(controllerCap.text) ?? 0
                  ..esManual = esManual
                  ..stage.value = widget.stage;

                await widget.isar.writeTxn(() async {
                  await widget.isar.refWaypoints.put(wpt);
                  await wpt.stage.save();
                });

                Navigator.pop(context);
                _loadStageDetails();
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editWaypoint(RefWaypoint wpt) async {
    final controllerDist = TextEditingController(text: wpt.distancia.toString());
    final controllerLat = TextEditingController(text: wpt.latitud.toString());
    final controllerLon = TextEditingController(text: wpt.longitud.toString());
    final controllerError = TextEditingController(text: wpt.error.toString());
    final controllerMensaje = TextEditingController(text: wpt.mensaje);
    final controllerCap = TextEditingController(text: wpt.cap.toString());
    bool esManual = wpt.esManual;

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: const Text("Editar Waypoint"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: controllerDist, decoration: const InputDecoration(labelText: "Distancia"), keyboardType: TextInputType.number),
                TextField(controller: controllerLat, decoration: const InputDecoration(labelText: "Latitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
                TextField(controller: controllerLon, decoration: const InputDecoration(labelText: "Longitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
                TextField(controller: controllerError, decoration: const InputDecoration(labelText: "Error"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
                TextField(controller: controllerMensaje, decoration: const InputDecoration(labelText: "Mensaje")),
                TextField(controller: controllerCap, decoration: const InputDecoration(labelText: "Cap"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
                Row(
                  children: [
                    const Text("Manual"),
                    Checkbox(value: esManual, onChanged: (val) => setStateDialog(() => esManual = val ?? false)),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
            ElevatedButton(
              onPressed: () async {
                wpt.distancia = int.tryParse(controllerDist.text) ?? 0;
                wpt.latitud = double.tryParse(controllerLat.text) ?? 0;
                wpt.longitud = double.tryParse(controllerLon.text) ?? 0;
                wpt.error = double.tryParse(controllerError.text) ?? 0;
                wpt.mensaje = controllerMensaje.text;
                wpt.cap = double.tryParse(controllerCap.text) ?? 0;
                wpt.esManual = esManual;

                await widget.isar.writeTxn(() async {
                  await widget.isar.refWaypoints.put(wpt);
                });

                Navigator.pop(context);
                _loadStageDetails();
              },
              child: const Text("Guardar cambios"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteWaypoint(RefWaypoint wpt) async {
    await widget.isar.writeTxn(() async {
      await widget.isar.refWaypoints.delete(wpt.id);
    });
    _loadStageDetails();
  }

  // ------------------ CRUD PaceNotes ------------------
  Future<void> _addPaceNote() async {
    final controllerDist = TextEditingController();
    final controllerLongCurva = TextEditingController();
    final controllerNota = TextEditingController();
    final controllerLat = TextEditingController();
    final controllerLon = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nueva Pace Note"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: controllerDist, decoration: const InputDecoration(labelText: "Distancia"), keyboardType: TextInputType.number),
              TextField(controller: controllerLongCurva, decoration: const InputDecoration(labelText: "Longitud curva"), keyboardType: TextInputType.number),
              TextField(controller: controllerNota, decoration: const InputDecoration(labelText: "Nota")),
              TextField(controller: controllerLat, decoration: const InputDecoration(labelText: "Latitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
              TextField(controller: controllerLon, decoration: const InputDecoration(labelText: "Longitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
                            final pace = PaceData()
                ..distancia = int.tryParse(controllerDist.text) ?? 0
                ..longitudCurva = int.tryParse(controllerLongCurva.text) ?? 0
                ..nota = controllerNota.text
                ..latitud = double.tryParse(controllerLat.text) ?? 0
                ..longitud = double.tryParse(controllerLon.text) ?? 0
                ..stage.value = widget.stage;

              await widget.isar.writeTxn(() async {
                await widget.isar.paceDatas.put(pace);
                await pace.stage.save();
              });

              Navigator.pop(context);
              _loadStageDetails();
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  Future<void> _editPaceNote(PaceData p) async {
    final controllerDist = TextEditingController(text: p.distancia.toString());
    final controllerLongCurva = TextEditingController(text: p.longitudCurva.toString());
    final controllerNota = TextEditingController(text: p.nota);
    final controllerLat = TextEditingController(text: p.latitud.toString());
    final controllerLon = TextEditingController(text: p.longitud.toString());

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar Pace Note"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: controllerDist, decoration: const InputDecoration(labelText: "Distancia"), keyboardType: TextInputType.number),
              TextField(controller: controllerLongCurva, decoration: const InputDecoration(labelText: "Longitud curva"), keyboardType: TextInputType.number),
              TextField(controller: controllerNota, decoration: const InputDecoration(labelText: "Nota")),
              TextField(controller: controllerLat, decoration: const InputDecoration(labelText: "Latitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
              TextField(controller: controllerLon, decoration: const InputDecoration(labelText: "Longitud"), keyboardType: TextInputType.numberWithOptions(decimal: true)),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              p.distancia = int.tryParse(controllerDist.text) ?? 0;
              p.longitudCurva = int.tryParse(controllerLongCurva.text) ?? 0;
              p.nota = controllerNota.text;
              p.latitud = double.tryParse(controllerLat.text) ?? 0;
              p.longitud = double.tryParse(controllerLon.text) ?? 0;

              await widget.isar.writeTxn(() async {
                await widget.isar.paceDatas.put(p);
              });

              Navigator.pop(context);
              _loadStageDetails();
            },
            child: const Text("Guardar cambios"),
          ),
        ],
      ),
    );
  }

  Future<void> _deletePaceNote(PaceData p) async {
    await widget.isar.writeTxn(() async {
      await widget.isar.paceDatas.delete(p.id);
    });
    _loadStageDetails();
  }

  // ------------------ Build ------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.stage.nom)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Distancia: ${widget.stage.distancia} m"),
            Text("Hora salida: ${widget.stage.horaSortida.toLocal().toString().substring(0,16)}"),
            const SizedBox(height: 20),

            // Averages
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Averages", style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.add), onPressed: _addAverage),
              ],
            ),
            averages.isEmpty
                ? const Text("No hay averages")
                : Column(
                    children: averages.map((a) {
                      return ListTile(
                        title: Text("Distancia inicio: ${a.distanciaInicio}"),
                        subtitle: Text("Velocidad media: ${a.velocidadMedia}"),
                        onTap: () => _editAverage(a),
                        trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteAverage(a)),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 20),

            // Waypoints
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Waypoints", style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.add), onPressed: _addWaypoint),
              ],
            ),
            waypoints.isEmpty
                ? const Text("No hay waypoints")
                : Column(
                    children: waypoints.map((w) {
                      return ListTile(
                        title: Text("Distancia: ${w.distancia}"),
                        subtitle: Text(
                          "Lat: ${w.latitud}, Lon: ${w.longitud}\nMensaje: ${w.mensaje}\nError: ${w.error}\nCap: ${w.cap}\nManual: ${w.esManual}",
                        ),
                        onTap: () => _editWaypoint(w),
                        trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteWaypoint(w)),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 20),

            // PaceNotes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pace Notes", style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.add), onPressed: _addPaceNote),
              ],
            ),
            paceNotes.isEmpty
                ? const Text("No hay pace notes")
                : Column(
                    children: paceNotes.map((p) {
                      return ListTile(
                        title: Text("Distancia: ${p.distancia}, Long curva: ${p.longitudCurva}"),
                        subtitle: Text("Nota: ${p.nota}\nLat: ${p.latitud}, Lon: ${p.longitud}"),
                        onTap: () => _editPaceNote(p),
                        trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deletePaceNote(p)),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
