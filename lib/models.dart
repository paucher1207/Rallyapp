import 'package:isar/isar.dart';

part 'models.g.dart';

@collection
class Stage {
  Id id = Isar.autoIncrement;
  late String nom;
  late int distancia;
  late DateTime horaSortida;

  final averages = IsarLinks<Average>();
  final waypoints = IsarLinks<RefWaypoint>();
  final paceNotes = IsarLinks<PaceData>();

  // Campos temporales para la UI (no se guardan en Isar)
  @ignore
  Average? lastAverage;
  @ignore
  PaceData? lastPace;
  @ignore
  int waypointsCount = 0;
}

@collection
class Average {
  Id id = Isar.autoIncrement;
  late int distanciaInicio;
  late double velocidadMedia;
  final stage = IsarLink<Stage>();
}

@collection
class RefWaypoint {
  Id id = Isar.autoIncrement;
  late int distancia;
  late double latitud;
  late double longitud;
  late double error;
  late String mensaje;
  late double cap;
  late bool esManual;

  final stage = IsarLink<Stage>();
}

@collection
class PaceData {
  Id id = Isar.autoIncrement;
  late int distancia;
  late int longitudCurva;
  late String nota;
  late double latitud;
  late double longitud;

  final stage = IsarLink<Stage>();
}
