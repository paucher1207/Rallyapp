import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models.dart';

class DatabaseService {
  static Isar? _isar;

  static Future<Isar> openDB() async {
    if (_isar != null) return _isar!;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [StageSchema, AverageSchema, RefWaypointSchema, PaceDataSchema],
      directory: dir.path,
    );
    return _isar!;
  }
}
