import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models.dart';

class DatabaseService {
  static late Isar _isar;

  /// Inicializa Isar
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [StageSchema, AverageSchema, RefWaypointSchema, PaceDataSchema],
      directory: dir.path,
    );
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

  static Future<List<Average>> getAveragesByStage(Stage stage) async {
    final stageFromDb = await _isar.stages.get(stage.id);
    if (stageFromDb == null) return [];
    await stageFromDb.averages.load();
    return stageFromDb.averages.toList();
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

  static Future<List<RefWaypoint>> getWaypointsByStage(Stage stage) async {
    final stageFromDb = await _isar.stages.get(stage.id);
    if (stageFromDb == null) return [];
    await stageFromDb.waypoints.load();
    return stageFromDb.waypoints.toList();
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

  static Future<List<PaceData>> getPaceByStage(Stage stage) async {
    final stageFromDb = await _isar.stages.get(stage.id);
    if (stageFromDb == null) return [];
    await stageFromDb.paceNotes.load();
    return stageFromDb.paceNotes.toList();
  }
}

