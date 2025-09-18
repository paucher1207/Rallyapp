// database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'stages_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onOpen: (db) async {
        // Activar claves foráneas
        await db.execute("PRAGMA foreign_keys = ON");
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE stages(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        distancia INTEGER NOT NULL,
        hora_sortida TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE averages(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stage_id INTEGER NOT NULL,
        distancia_inicio INTEGER NOT NULL,
        velocidad_media REAL NOT NULL,
        FOREIGN KEY (stage_id) REFERENCES stages (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE ref_waypoints(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stage_id INTEGER NOT NULL,
        distancia INTEGER NOT NULL,
        latitud REAL NOT NULL,
        longitud REAL NOT NULL,
        error REAL,
        mensaje TEXT,
        cap REAL,
        es_manual INTEGER NOT NULL CHECK (es_manual IN (0, 1)),
        FOREIGN KEY (stage_id) REFERENCES stages (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE pace_data(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stage_id INTEGER NOT NULL,
        distancia INTEGER NOT NULL,
        longitud_curva INTEGER NOT NULL,
        nota TEXT NOT NULL,
        latitud REAL NOT NULL,
        longitud REAL NOT NULL,
        FOREIGN KEY (stage_id) REFERENCES stages (id) ON DELETE CASCADE
      )
    ''');
  }

  // -----------------------------
  // CRUD para Stages
  // -----------------------------
  Future<int> insertStage(Stage stage) async {
    final db = await database;
    return await db.insert('stages', stage.toMap());
  }

  Future<List<Stage>> getStages() async {
    final db = await database;
    final maps = await db.query('stages');
    return List.generate(maps.length, (i) => Stage.fromMap(maps[i]));
  }

  Future<Stage?> getStageById(int id) async {
    final db = await database;
    final maps = await db.query(
      'stages',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) return Stage.fromMap(maps.first);
    return null;
  }

  Future<int> updateStage(Stage stage) async {
    final db = await database;
    return await db.update(
      'stages',
      stage.toMap(),
      where: 'id = ?',
      whereArgs: [stage.id],
    );
  }

  Future<int> deleteStage(int id) async {
    final db = await database;
    return await db.delete(
      'stages',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // -----------------------------
  // CRUD para Averages
  // -----------------------------
  Future<int> insertAverage(Average average) async {
    final db = await database;
    return await db.insert('averages', average.toMap());
  }

  Future<List<Average>> getAveragesByStage(int stageId) async {
    final db = await database;
    final maps = await db.query(
      'averages',
      where: 'stage_id = ?',
      whereArgs: [stageId],
    );
    return List.generate(maps.length, (i) => Average.fromMap(maps[i]));
  }

  Future<int> updateAverage(Average average) async {
    final db = await database;
    return await db.update(
      'averages',
      average.toMap(),
      where: 'id = ?',
      whereArgs: [average.id],
    );
  }

  Future<int> deleteAverage(int id) async {
    final db = await database;
    return await db.delete(
      'averages',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // -----------------------------
  // CRUD para RefWaypoints
  // -----------------------------
  Future<int> insertRefWaypoint(RefWaypoint waypoint) async {
    final db = await database;
    return await db.insert('ref_waypoints', waypoint.toMap());
  }

  Future<List<RefWaypoint>> getRefWaypointsByStage(int stageId) async {
    final db = await database;
    final maps = await db.query(
      'ref_waypoints',
      where: 'stage_id = ?',
      whereArgs: [stageId],
    );
    return List.generate(maps.length, (i) => RefWaypoint.fromMap(maps[i]));
  }

  Future<int> updateRefWaypoint(RefWaypoint waypoint) async {
    final db = await database;
    return await db.update(
      'ref_waypoints',
      waypoint.toMap(),
      where: 'id = ?',
      whereArgs: [waypoint.id],
    );
  }

  Future<int> deleteRefWaypoint(int id) async {
    final db = await database;
    return await db.delete(
      'ref_waypoints',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // -----------------------------
  // CRUD para PaceData
  // -----------------------------
  Future<int> insertPaceData(PaceData paceData) async {
    final db = await database;
    return await db.insert('pace_data', paceData.toMap());
  }

  Future<List<PaceData>> getPaceDataByStage(int stageId) async {
    final db = await database;
    final maps = await db.query(
      'pace_data',
      where: 'stage_id = ?',
      whereArgs: [stageId],
    );
    return List.generate(maps.length, (i) => PaceData.fromMap(maps[i]));
  }

  Future<int> updatePaceData(PaceData paceData) async {
    final db = await database;
    return await db.update(
      'pace_data',
      paceData.toMap(),
      where: 'id = ?',
      whereArgs: [paceData.id],
    );
  }

  Future<int> deletePaceData(int id) async {
    final db = await database;
    return await db.delete(
      'pace_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // -----------------------------
  // Cerrar la base de datos
  // -----------------------------
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
