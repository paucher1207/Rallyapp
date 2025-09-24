import 'dart:io';
import 'package:isar/isar.dart';
import 'models.dart';

Future<Isar> initIsar() async {
  final dbDir = Directory('${Platform.environment['LOCALAPPDATA']}\\rallyApp');

  if (!await dbDir.exists()) {
    await dbDir.create(recursive: true);
  }

  final isar = await Isar.open(
    [StageSchema, AverageSchema, RefWaypointSchema, PaceDataSchema],
    directory: dbDir.path,
  );

  print('✅ Isar DB location: ${isar.path}');
  return isar;
}
