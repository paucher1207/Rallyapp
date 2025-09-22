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

  static Future<List<Stage>> getStages() async {
    return await _isar.stages.where().findAll();
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

  // -----------------------
  // AVERAGE CRUD
  // -----------------------
  static Future<int> createAverage(Average avg, Stage stage) async {
    await _isar.writeTxn(() async {
      avg.stage.value = stage;
      await avg.stage.save();
      await _isar.averages.put(avg);
    });
    return avg.id;
  }

  static Future<List<Average>> getAveragesByStage(Stage stage) async {
    await stage.averages.load();
    return stage.averages.toList(); // <-- Corregido
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

  // -----------------------
  // REFWAYPOINT CRUD
  // -----------------------
  static Future<int> createRefWaypoint(RefWaypoint wp, Stage stage) async {
    await _isar.writeTxn(() async {
      wp.stage.value = stage;
      await wp.stage.save();
      await _isar.refWaypoints.put(wp);
    });
    return wp.id;
  }

  static Future<List<RefWaypoint>> getWaypointsByStage(Stage stage) async {
    await stage.waypoints.load();
    return stage.waypoints.toList(); // <-- Corregido
  }

  static Future<void> updateRefWaypoint(RefWaypoint wp) async {
    await _isar.writeTxn(() async {
      await _isar.refWaypoints.put(wp);
    });
  }

  static Future<void> deleteRefWaypoint(int id) async {
    await _isar.writeTxn(() async {
      await _isar.refWaypoints.delete(id);
    });
  }

  // -----------------------
  // PACE DATA CRUD
  // -----------------------
  static Future<int> createPace(PaceData pace, Stage stage) async {
    await _isar.writeTxn(() async {
      pace.stage.value = stage;
      await pace.stage.save();
      await _isar.paceDatas.put(pace);
    });
    return pace.id;
  }

  static Future<List<PaceData>> getPaceByStage(Stage stage) async {
    await stage.paceNotes.load();
    return stage.paceNotes.toList(); // <-- Corregido
  }

  static Future<void> updatePace(PaceData pace) async {
    await _isar.writeTxn(() async {
      await _isar.paceDatas.put(pace);
    });
  }

  static Future<void> deletePace(int id) async {
    await _isar.writeTxn(() async {
      await _isar.paceDatas.delete(id);
    });
  }
}
