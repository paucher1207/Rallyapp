// models.dart
class Stage {
  int? id;
  String nom;
  int distancia;
  DateTime horaSortida;

  Stage({
    this.id,
    required this.nom,
    required this.distancia,
    required this.horaSortida,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'distancia': distancia,
      'hora_sortida': horaSortida.toIso8601String(),
    };
  }

  factory Stage.fromMap(Map<String, dynamic> map) {
    return Stage(
      id: map['id'],
      nom: map['nom'],
      distancia: map['distancia'],
      horaSortida: DateTime.parse(map['hora_sortida']),
    );
  }
}

class Average {
  int? id;
  int stageId;
  int distanciaInicio;
  double velocidadMedia;

  Average({
    this.id,
    required this.stageId,
    required this.distanciaInicio,
    required this.velocidadMedia,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stage_id': stageId,
      'distancia_inicio': distanciaInicio,
      'velocidad_media': velocidadMedia,
    };
  }

  factory Average.fromMap(Map<String, dynamic> map) {
    return Average(
      id: map['id'],
      stageId: map['stage_id'],
      distanciaInicio: map['distancia_inicio'],
      velocidadMedia: map['velocidad_media'],
    );
  }
}

class RefWaypoint {
  int? id;
  int stageId;
  int distancia;
  double latitud;
  double longitud;
  double error;
  String mensaje;
  double cap;
  bool esManual;

  RefWaypoint({
    this.id,
    required this.stageId,
    required this.distancia,
    required this.latitud,
    required this.longitud,
    required this.error,
    required this.mensaje,
    required this.cap,
    required this.esManual,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stage_id': stageId,
      'distancia': distancia,
      'latitud': latitud,
      'longitud': longitud,
      'error': error,
      'mensaje': mensaje,
      'cap': cap,
      'es_manual': esManual ? 1 : 0,
    };
  }

  factory RefWaypoint.fromMap(Map<String, dynamic> map) {
    return RefWaypoint(
      id: map['id'],
      stageId: map['stage_id'],
      distancia: map['distancia'],
      latitud: map['latitud'],
      longitud: map['longitud'],
      error: map['error'],
      mensaje: map['mensaje'],
      cap: map['cap'],
      esManual: map['es_manual'] == 1,
    );
  }
}

class PaceData {
  int? id;
  int stageId;
  int distancia;
  int longitudCurva;
  String nota;
  double latitud;
  double longitud;

  PaceData({
    this.id,
    required this.stageId,
    required this.distancia,
    required this.longitudCurva,
    required this.nota,
    required this.latitud,
    required this.longitud,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stage_id': stageId,
      'distancia': distancia,
      'longitud_curva': longitudCurva,
      'nota': nota,
      'latitud': latitud,
      'longitud': longitud,
    };
  }

  factory PaceData.fromMap(Map<String, dynamic> map) {
    return PaceData(
      id: map['id'],
      stageId: map['stage_id'],
      distancia: map['distancia'],
      longitudCurva: map['longitud_curva'],
      nota: map['nota'],
      latitud: map['latitud'],
      longitud: map['longitud'],
    );
  }
}
