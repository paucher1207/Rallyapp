import 'package:isar/isar.dart';
import '../models.dart';
import 'dart:io';

class DatabaseService {
  static late Isar _isar;

  /// Inicializa Isar en C:\Users\<usuario>\AppData\Local\rally
  static Future<void> init() async {
    // Carpeta AppData\Local
    final baseDir = Directory('${Platform.environment['USERPROFILE']}\\AppData\\Local\\rally');

    // Crear carpeta si no existe
    if (!await baseDir.exists()) {
      await baseDir.create(recursive: true);
    }

    _isar = await Isar.open(
      [StageSchema, AverageSchema, RefWaypointSchema, PaceDataSchema],
      directory: baseDir.path,
    );

    print('Isar DB location: ${_isar.path}'); // Para verificar
  }

  static Isar get instance => _isar;

  // -----------------------
  // STAGE CRUD
  // -----------------------
  static Future<int> createStage(Stage stage) async {
    await _isar.writeTxn(() async {
      await _isar.stages.put(stage);
    });
    return stage.id;
  }

  static Future<void> updateStage(Stage stage) async {
    await _isar.writeTxn(() async {
      await _isar.stages.put(stage);
    });
  }

  static Future<void> deleteStage(int id) async {
    await _isar.writeTxn(() async {
      await _isar.stages.delete(id);
    });
  }

  static Future<List<Stage>> getStages() async {
    return await _isar.stages.where().findAll();
  }

  static Future<List<Stage>> getStagesWithExtras() async {
    final stages = await _isar.stages.where().findAll();

    await _isar.writeTxn(() async {
      for (var stage in stages) {
        await stage.averages.load();
        await stage.paceNotes.load();
        await stage.waypoints.load();

        // Guardamos los últimos elementos para StageListPage
        stage.lastAverage = stage.averages.isNotEmpty ? stage.averages.last : null;
        stage.lastPace = stage.paceNotes.isNotEmpty ? stage.paceNotes.last : null;
        stage.waypointsCount = stage.waypoints.length;
      }
    });

    return stages;
  }

  // -----------------------
  // AVERAGE CRUD
  // -----------------------
  static Future<int> addAverage(int stageId, int distanciaInicio, double velocidadMedia) async {
    final stage = await _isar.stages.get(stageId);
    if (stage == null) return -1;

    final avg = Average()
      ..distanciaInicio = distanciaInicio
      ..velocidadMedia = velocidadMedia
      ..stage.value = stage;

    await _isar.writeTxn(() async {
      await _isar.averages.put(avg);
    });

    return avg.id;
  }

  static Future<void> updateAverage(Average avg) async {
    await _isar.writeTxn(() async {
      await _isar.averages.put(avg);
    });
  }

  static Future<void> deleteAverage(int id) async {
    await _isar.writeTxn(() async {
      await _isar.averages.delete(id);
    });
  }

  static Future<List<Average>> getAveragesByStage(int stageId) async {
    final stage = await _isar.stages.get(stageId);
    if (stage == null) return [];
    await stage.averages.load();
    return stage.averages.toList();
  }

  // -----------------------
  // WAYPOINT CRUD
  // -----------------------
  static Future<int> addWaypoint(int stageId, int distancia, double lat, double lon, String mensaje) async {
    final stage = await _isar.stages.get(stageId);
    if (stage == null) return -1;

    final wp = RefWaypoint()
      ..distancia = distancia
      ..latitud = lat
      ..longitud = lon
      ..mensaje = mensaje
      ..stage.value = stage;

    await _isar.writeTxn(() async {
      await _isar.refWaypoints.put(wp);
    });

    return wp.id;
  }

  static Future<void> updateWaypoint(RefWaypoint wp) async {
    await _isar.writeTxn(() async {
      await _isar.refWaypoints.put(wp);
    });
  }

  static Future<void> deleteWaypoint(int id) async {
    await _isar.writeTxn(() async {
      await _isar.refWaypoints.delete(id);
    });
  }

  static Future<List<RefWaypoint>> getWaypointsByStage(int stageId) async {
    final stage = await _isar.stages.get(stageId);
    if (stage == null) return [];
    await stage.waypoints.load();
    return stage.waypoints.toList();
  }

  // -----------------------
  // PACE DATA CRUD
  // -----------------------
  static Future<int> addPaceData(int stageId, int distancia, int longitudCurva, String nota, double lat, double lon) async {
    final stage = await _isar.stages.get(stageId);
    if (stage == null) return -1;

    final pd = PaceData()
      ..distancia = distancia
      ..longitudCurva = longitudCurva
      ..nota = nota
      ..latitud = lat
      ..longitud = lon
      ..stage.value = stage;

    await _isar.writeTxn(() async {
      await _isar.paceDatas.put(pd);
    });

    return pd.id;
  }

  static Future<void> updatePaceData(PaceData pd) async {
    await _isar.writeTxn(() async {
      await _isar.paceDatas.put(pd);
    });
  }

  static Future<void> deletePaceData(int id) async {
    await _isar.writeTxn(() async {
      await _isar.paceDatas.delete(id);
    });
  }

  static Future<List<PaceData>> getPaceByStage(int stageId) async {
    final stage = await _isar.stages.get(stageId);
    if (stage == null) return [];
    await stage.paceNotes.load();
    return stage.paceNotes.toList();
  }
}

