import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models.dart'; // tus schemas: StageSchema, AverageSchema, etc.

Future<Isar> initIsar() async {
  // Para Windows: carpeta personalizada
  Directory dir;

  if (Platform.isWindows) {
    dir = Directory('${Platform.environment['USERPROFILE']}\\AppData\\Local\\rallyApp');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  } else {
    // Para otros sistemas, usa la carpeta de documentos de la app
    dir = await getApplicationDocumentsDirectory();
  }

  // Abrir Isar
  final isar = await Isar.open(
    [StageSchema, AverageSchema, RefWaypointSchema, PaceDataSchema],
    directory: dir.path,
  );

  print('Isar DB location: ${isar.path}'); // verifica dónde se crea
  return isar;
}
