// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStageCollection on Isar {
  IsarCollection<Stage> get stages => this.collection();
}

const StageSchema = CollectionSchema(
  name: r'Stage',
  id: -7840862827543848208,
  properties: {
    r'distancia': PropertySchema(
      id: 0,
      name: r'distancia',
      type: IsarType.long,
    ),
    r'horaSortida': PropertySchema(
      id: 1,
      name: r'horaSortida',
      type: IsarType.dateTime,
    ),
    r'nom': PropertySchema(
      id: 2,
      name: r'nom',
      type: IsarType.string,
    )
  },
  estimateSize: _stageEstimateSize,
  serialize: _stageSerialize,
  deserialize: _stageDeserialize,
  deserializeProp: _stageDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'averages': LinkSchema(
      id: -3641818131744654561,
      name: r'averages',
      target: r'Average',
      single: false,
    ),
    r'waypoints': LinkSchema(
      id: 140688216887311940,
      name: r'waypoints',
      target: r'RefWaypoint',
      single: false,
    ),
    r'paceNotes': LinkSchema(
      id: 5897273510123438254,
      name: r'paceNotes',
      target: r'PaceData',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _stageGetId,
  getLinks: _stageGetLinks,
  attach: _stageAttach,
  version: '3.1.0+1',
);

int _stageEstimateSize(
  Stage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nom.length * 3;
  return bytesCount;
}

void _stageSerialize(
  Stage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.distancia);
  writer.writeDateTime(offsets[1], object.horaSortida);
  writer.writeString(offsets[2], object.nom);
}

Stage _stageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Stage();
  object.distancia = reader.readLong(offsets[0]);
  object.horaSortida = reader.readDateTime(offsets[1]);
  object.id = id;
  object.nom = reader.readString(offsets[2]);
  return object;
}

P _stageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stageGetId(Stage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _stageGetLinks(Stage object) {
  return [object.averages, object.waypoints, object.paceNotes];
}

void _stageAttach(IsarCollection<dynamic> col, Id id, Stage object) {
  object.id = id;
  object.averages.attach(col, col.isar.collection<Average>(), r'averages', id);
  object.waypoints
      .attach(col, col.isar.collection<RefWaypoint>(), r'waypoints', id);
  object.paceNotes
      .attach(col, col.isar.collection<PaceData>(), r'paceNotes', id);
}

extension StageQueryWhereSort on QueryBuilder<Stage, Stage, QWhere> {
  QueryBuilder<Stage, Stage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StageQueryWhere on QueryBuilder<Stage, Stage, QWhereClause> {
  QueryBuilder<Stage, Stage, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Stage, Stage, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Stage, Stage, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Stage, Stage, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StageQueryFilter on QueryBuilder<Stage, Stage, QFilterCondition> {
  QueryBuilder<Stage, Stage, QAfterFilterCondition> distanciaEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distancia',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> distanciaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distancia',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> distanciaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distancia',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> distanciaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distancia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> horaSortidaEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'horaSortida',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> horaSortidaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'horaSortida',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> horaSortidaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'horaSortida',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> horaSortidaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'horaSortida',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nomEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nomGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nomLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nomBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nomStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nomEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nomContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nomMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nom',
        value: '',
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nom',
        value: '',
      ));
    });
  }
}

extension StageQueryObject on QueryBuilder<Stage, Stage, QFilterCondition> {}

extension StageQueryLinks on QueryBuilder<Stage, Stage, QFilterCondition> {
  QueryBuilder<Stage, Stage, QAfterFilterCondition> averages(
      FilterQuery<Average> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'averages');
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> averagesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'averages', length, true, length, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> averagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'averages', 0, true, 0, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> averagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'averages', 0, false, 999999, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> averagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'averages', 0, true, length, include);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> averagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'averages', length, include, 999999, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> averagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'averages', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> waypoints(
      FilterQuery<RefWaypoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'waypoints');
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> waypointsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'waypoints', length, true, length, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> waypointsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'waypoints', 0, true, 0, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> waypointsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'waypoints', 0, false, 999999, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> waypointsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'waypoints', 0, true, length, include);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> waypointsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'waypoints', length, include, 999999, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> waypointsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'waypoints', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> paceNotes(
      FilterQuery<PaceData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'paceNotes');
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> paceNotesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'paceNotes', length, true, length, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> paceNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'paceNotes', 0, true, 0, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> paceNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'paceNotes', 0, false, 999999, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> paceNotesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'paceNotes', 0, true, length, include);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> paceNotesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'paceNotes', length, include, 999999, true);
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> paceNotesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'paceNotes', lower, includeLower, upper, includeUpper);
    });
  }
}

extension StageQuerySortBy on QueryBuilder<Stage, Stage, QSortBy> {
  QueryBuilder<Stage, Stage, QAfterSortBy> sortByDistancia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortByDistanciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortByHoraSortida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaSortida', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortByHoraSortidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaSortida', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortByNom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortByNomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.desc);
    });
  }
}

extension StageQuerySortThenBy on QueryBuilder<Stage, Stage, QSortThenBy> {
  QueryBuilder<Stage, Stage, QAfterSortBy> thenByDistancia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByDistanciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByHoraSortida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaSortida', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByHoraSortidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horaSortida', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByNom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByNomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nom', Sort.desc);
    });
  }
}

extension StageQueryWhereDistinct on QueryBuilder<Stage, Stage, QDistinct> {
  QueryBuilder<Stage, Stage, QDistinct> distinctByDistancia() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distancia');
    });
  }

  QueryBuilder<Stage, Stage, QDistinct> distinctByHoraSortida() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'horaSortida');
    });
  }

  QueryBuilder<Stage, Stage, QDistinct> distinctByNom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nom', caseSensitive: caseSensitive);
    });
  }
}

extension StageQueryProperty on QueryBuilder<Stage, Stage, QQueryProperty> {
  QueryBuilder<Stage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Stage, int, QQueryOperations> distanciaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distancia');
    });
  }

  QueryBuilder<Stage, DateTime, QQueryOperations> horaSortidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'horaSortida');
    });
  }

  QueryBuilder<Stage, String, QQueryOperations> nomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nom');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAverageCollection on Isar {
  IsarCollection<Average> get averages => this.collection();
}

const AverageSchema = CollectionSchema(
  name: r'Average',
  id: -8616148700530538206,
  properties: {
    r'distanciaInicio': PropertySchema(
      id: 0,
      name: r'distanciaInicio',
      type: IsarType.long,
    ),
    r'velocidadMedia': PropertySchema(
      id: 1,
      name: r'velocidadMedia',
      type: IsarType.double,
    )
  },
  estimateSize: _averageEstimateSize,
  serialize: _averageSerialize,
  deserialize: _averageDeserialize,
  deserializeProp: _averageDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'stage': LinkSchema(
      id: -1055243583988411790,
      name: r'stage',
      target: r'Stage',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _averageGetId,
  getLinks: _averageGetLinks,
  attach: _averageAttach,
  version: '3.1.0+1',
);

int _averageEstimateSize(
  Average object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _averageSerialize(
  Average object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.distanciaInicio);
  writer.writeDouble(offsets[1], object.velocidadMedia);
}

Average _averageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Average();
  object.distanciaInicio = reader.readLong(offsets[0]);
  object.id = id;
  object.velocidadMedia = reader.readDouble(offsets[1]);
  return object;
}

P _averageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _averageGetId(Average object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _averageGetLinks(Average object) {
  return [object.stage];
}

void _averageAttach(IsarCollection<dynamic> col, Id id, Average object) {
  object.id = id;
  object.stage.attach(col, col.isar.collection<Stage>(), r'stage', id);
}

extension AverageQueryWhereSort on QueryBuilder<Average, Average, QWhere> {
  QueryBuilder<Average, Average, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AverageQueryWhere on QueryBuilder<Average, Average, QWhereClause> {
  QueryBuilder<Average, Average, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Average, Average, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Average, Average, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Average, Average, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AverageQueryFilter
    on QueryBuilder<Average, Average, QFilterCondition> {
  QueryBuilder<Average, Average, QAfterFilterCondition> distanciaInicioEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distanciaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition>
      distanciaInicioGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distanciaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition> distanciaInicioLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distanciaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition> distanciaInicioBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distanciaInicio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition> velocidadMediaEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'velocidadMedia',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition>
      velocidadMediaGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'velocidadMedia',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition> velocidadMediaLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'velocidadMedia',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition> velocidadMediaBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'velocidadMedia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension AverageQueryObject
    on QueryBuilder<Average, Average, QFilterCondition> {}

extension AverageQueryLinks
    on QueryBuilder<Average, Average, QFilterCondition> {
  QueryBuilder<Average, Average, QAfterFilterCondition> stage(
      FilterQuery<Stage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'stage');
    });
  }

  QueryBuilder<Average, Average, QAfterFilterCondition> stageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stage', 0, true, 0, true);
    });
  }
}

extension AverageQuerySortBy on QueryBuilder<Average, Average, QSortBy> {
  QueryBuilder<Average, Average, QAfterSortBy> sortByDistanciaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanciaInicio', Sort.asc);
    });
  }

  QueryBuilder<Average, Average, QAfterSortBy> sortByDistanciaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanciaInicio', Sort.desc);
    });
  }

  QueryBuilder<Average, Average, QAfterSortBy> sortByVelocidadMedia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'velocidadMedia', Sort.asc);
    });
  }

  QueryBuilder<Average, Average, QAfterSortBy> sortByVelocidadMediaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'velocidadMedia', Sort.desc);
    });
  }
}

extension AverageQuerySortThenBy
    on QueryBuilder<Average, Average, QSortThenBy> {
  QueryBuilder<Average, Average, QAfterSortBy> thenByDistanciaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanciaInicio', Sort.asc);
    });
  }

  QueryBuilder<Average, Average, QAfterSortBy> thenByDistanciaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanciaInicio', Sort.desc);
    });
  }

  QueryBuilder<Average, Average, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Average, Average, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Average, Average, QAfterSortBy> thenByVelocidadMedia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'velocidadMedia', Sort.asc);
    });
  }

  QueryBuilder<Average, Average, QAfterSortBy> thenByVelocidadMediaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'velocidadMedia', Sort.desc);
    });
  }
}

extension AverageQueryWhereDistinct
    on QueryBuilder<Average, Average, QDistinct> {
  QueryBuilder<Average, Average, QDistinct> distinctByDistanciaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanciaInicio');
    });
  }

  QueryBuilder<Average, Average, QDistinct> distinctByVelocidadMedia() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'velocidadMedia');
    });
  }
}

extension AverageQueryProperty
    on QueryBuilder<Average, Average, QQueryProperty> {
  QueryBuilder<Average, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Average, int, QQueryOperations> distanciaInicioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanciaInicio');
    });
  }

  QueryBuilder<Average, double, QQueryOperations> velocidadMediaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'velocidadMedia');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRefWaypointCollection on Isar {
  IsarCollection<RefWaypoint> get refWaypoints => this.collection();
}

const RefWaypointSchema = CollectionSchema(
  name: r'RefWaypoint',
  id: 4223636861071431655,
  properties: {
    r'cap': PropertySchema(
      id: 0,
      name: r'cap',
      type: IsarType.double,
    ),
    r'distancia': PropertySchema(
      id: 1,
      name: r'distancia',
      type: IsarType.long,
    ),
    r'error': PropertySchema(
      id: 2,
      name: r'error',
      type: IsarType.double,
    ),
    r'esManual': PropertySchema(
      id: 3,
      name: r'esManual',
      type: IsarType.bool,
    ),
    r'latitud': PropertySchema(
      id: 4,
      name: r'latitud',
      type: IsarType.double,
    ),
    r'longitud': PropertySchema(
      id: 5,
      name: r'longitud',
      type: IsarType.double,
    ),
    r'mensaje': PropertySchema(
      id: 6,
      name: r'mensaje',
      type: IsarType.string,
    )
  },
  estimateSize: _refWaypointEstimateSize,
  serialize: _refWaypointSerialize,
  deserialize: _refWaypointDeserialize,
  deserializeProp: _refWaypointDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'stage': LinkSchema(
      id: 2129982785844824421,
      name: r'stage',
      target: r'Stage',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _refWaypointGetId,
  getLinks: _refWaypointGetLinks,
  attach: _refWaypointAttach,
  version: '3.1.0+1',
);

int _refWaypointEstimateSize(
  RefWaypoint object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.mensaje.length * 3;
  return bytesCount;
}

void _refWaypointSerialize(
  RefWaypoint object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cap);
  writer.writeLong(offsets[1], object.distancia);
  writer.writeDouble(offsets[2], object.error);
  writer.writeBool(offsets[3], object.esManual);
  writer.writeDouble(offsets[4], object.latitud);
  writer.writeDouble(offsets[5], object.longitud);
  writer.writeString(offsets[6], object.mensaje);
}

RefWaypoint _refWaypointDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RefWaypoint();
  object.cap = reader.readDouble(offsets[0]);
  object.distancia = reader.readLong(offsets[1]);
  object.error = reader.readDouble(offsets[2]);
  object.esManual = reader.readBool(offsets[3]);
  object.id = id;
  object.latitud = reader.readDouble(offsets[4]);
  object.longitud = reader.readDouble(offsets[5]);
  object.mensaje = reader.readString(offsets[6]);
  return object;
}

P _refWaypointDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _refWaypointGetId(RefWaypoint object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _refWaypointGetLinks(RefWaypoint object) {
  return [object.stage];
}

void _refWaypointAttach(
    IsarCollection<dynamic> col, Id id, RefWaypoint object) {
  object.id = id;
  object.stage.attach(col, col.isar.collection<Stage>(), r'stage', id);
}

extension RefWaypointQueryWhereSort
    on QueryBuilder<RefWaypoint, RefWaypoint, QWhere> {
  QueryBuilder<RefWaypoint, RefWaypoint, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RefWaypointQueryWhere
    on QueryBuilder<RefWaypoint, RefWaypoint, QWhereClause> {
  QueryBuilder<RefWaypoint, RefWaypoint, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RefWaypointQueryFilter
    on QueryBuilder<RefWaypoint, RefWaypoint, QFilterCondition> {
  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> capEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> capGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> capLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> capBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cap',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      distanciaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distancia',
        value: value,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      distanciaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distancia',
        value: value,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      distanciaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distancia',
        value: value,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      distanciaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distancia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> errorEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'error',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      errorGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'error',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> errorLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'error',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> errorBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'error',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> esManualEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'esManual',
        value: value,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> latitudEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      latitudGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> latitudLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> latitudBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> longitudEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      longitudGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      longitudLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> longitudBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> mensajeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mensaje',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      mensajeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mensaje',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> mensajeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mensaje',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> mensajeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mensaje',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      mensajeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mensaje',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> mensajeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mensaje',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> mensajeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mensaje',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> mensajeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mensaje',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      mensajeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mensaje',
        value: '',
      ));
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition>
      mensajeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mensaje',
        value: '',
      ));
    });
  }
}

extension RefWaypointQueryObject
    on QueryBuilder<RefWaypoint, RefWaypoint, QFilterCondition> {}

extension RefWaypointQueryLinks
    on QueryBuilder<RefWaypoint, RefWaypoint, QFilterCondition> {
  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> stage(
      FilterQuery<Stage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'stage');
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterFilterCondition> stageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stage', 0, true, 0, true);
    });
  }
}

extension RefWaypointQuerySortBy
    on QueryBuilder<RefWaypoint, RefWaypoint, QSortBy> {
  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cap', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cap', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByDistancia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByDistanciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'error', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'error', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByEsManual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esManual', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByEsManualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esManual', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByLatitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByLatitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByLongitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByLongitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByMensaje() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mensaje', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> sortByMensajeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mensaje', Sort.desc);
    });
  }
}

extension RefWaypointQuerySortThenBy
    on QueryBuilder<RefWaypoint, RefWaypoint, QSortThenBy> {
  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cap', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cap', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByDistancia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByDistanciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'error', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'error', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByEsManual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esManual', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByEsManualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esManual', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByLatitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByLatitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByLongitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByLongitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.desc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByMensaje() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mensaje', Sort.asc);
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QAfterSortBy> thenByMensajeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mensaje', Sort.desc);
    });
  }
}

extension RefWaypointQueryWhereDistinct
    on QueryBuilder<RefWaypoint, RefWaypoint, QDistinct> {
  QueryBuilder<RefWaypoint, RefWaypoint, QDistinct> distinctByCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cap');
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QDistinct> distinctByDistancia() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distancia');
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QDistinct> distinctByError() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'error');
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QDistinct> distinctByEsManual() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'esManual');
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QDistinct> distinctByLatitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitud');
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QDistinct> distinctByLongitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitud');
    });
  }

  QueryBuilder<RefWaypoint, RefWaypoint, QDistinct> distinctByMensaje(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mensaje', caseSensitive: caseSensitive);
    });
  }
}

extension RefWaypointQueryProperty
    on QueryBuilder<RefWaypoint, RefWaypoint, QQueryProperty> {
  QueryBuilder<RefWaypoint, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RefWaypoint, double, QQueryOperations> capProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cap');
    });
  }

  QueryBuilder<RefWaypoint, int, QQueryOperations> distanciaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distancia');
    });
  }

  QueryBuilder<RefWaypoint, double, QQueryOperations> errorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'error');
    });
  }

  QueryBuilder<RefWaypoint, bool, QQueryOperations> esManualProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'esManual');
    });
  }

  QueryBuilder<RefWaypoint, double, QQueryOperations> latitudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitud');
    });
  }

  QueryBuilder<RefWaypoint, double, QQueryOperations> longitudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitud');
    });
  }

  QueryBuilder<RefWaypoint, String, QQueryOperations> mensajeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mensaje');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPaceDataCollection on Isar {
  IsarCollection<PaceData> get paceDatas => this.collection();
}

const PaceDataSchema = CollectionSchema(
  name: r'PaceData',
  id: 6252817418291104537,
  properties: {
    r'distancia': PropertySchema(
      id: 0,
      name: r'distancia',
      type: IsarType.long,
    ),
    r'latitud': PropertySchema(
      id: 1,
      name: r'latitud',
      type: IsarType.double,
    ),
    r'longitud': PropertySchema(
      id: 2,
      name: r'longitud',
      type: IsarType.double,
    ),
    r'longitudCurva': PropertySchema(
      id: 3,
      name: r'longitudCurva',
      type: IsarType.long,
    ),
    r'nota': PropertySchema(
      id: 4,
      name: r'nota',
      type: IsarType.string,
    )
  },
  estimateSize: _paceDataEstimateSize,
  serialize: _paceDataSerialize,
  deserialize: _paceDataDeserialize,
  deserializeProp: _paceDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'stage': LinkSchema(
      id: 2449287433239503271,
      name: r'stage',
      target: r'Stage',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _paceDataGetId,
  getLinks: _paceDataGetLinks,
  attach: _paceDataAttach,
  version: '3.1.0+1',
);

int _paceDataEstimateSize(
  PaceData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nota.length * 3;
  return bytesCount;
}

void _paceDataSerialize(
  PaceData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.distancia);
  writer.writeDouble(offsets[1], object.latitud);
  writer.writeDouble(offsets[2], object.longitud);
  writer.writeLong(offsets[3], object.longitudCurva);
  writer.writeString(offsets[4], object.nota);
}

PaceData _paceDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PaceData();
  object.distancia = reader.readLong(offsets[0]);
  object.id = id;
  object.latitud = reader.readDouble(offsets[1]);
  object.longitud = reader.readDouble(offsets[2]);
  object.longitudCurva = reader.readLong(offsets[3]);
  object.nota = reader.readString(offsets[4]);
  return object;
}

P _paceDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _paceDataGetId(PaceData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _paceDataGetLinks(PaceData object) {
  return [object.stage];
}

void _paceDataAttach(IsarCollection<dynamic> col, Id id, PaceData object) {
  object.id = id;
  object.stage.attach(col, col.isar.collection<Stage>(), r'stage', id);
}

extension PaceDataQueryWhereSort on QueryBuilder<PaceData, PaceData, QWhere> {
  QueryBuilder<PaceData, PaceData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PaceDataQueryWhere on QueryBuilder<PaceData, PaceData, QWhereClause> {
  QueryBuilder<PaceData, PaceData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PaceDataQueryFilter
    on QueryBuilder<PaceData, PaceData, QFilterCondition> {
  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> distanciaEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distancia',
        value: value,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> distanciaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distancia',
        value: value,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> distanciaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distancia',
        value: value,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> distanciaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distancia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> latitudEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> latitudGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> latitudLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> latitudBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> longitudEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> longitudGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> longitudLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitud',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> longitudBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> longitudCurvaEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitudCurva',
        value: value,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition>
      longitudCurvaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitudCurva',
        value: value,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> longitudCurvaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitudCurva',
        value: value,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> longitudCurvaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitudCurva',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> notaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> notaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> notaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> notaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nota',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> notaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> notaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> notaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> notaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nota',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> notaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nota',
        value: '',
      ));
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> notaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nota',
        value: '',
      ));
    });
  }
}

extension PaceDataQueryObject
    on QueryBuilder<PaceData, PaceData, QFilterCondition> {}

extension PaceDataQueryLinks
    on QueryBuilder<PaceData, PaceData, QFilterCondition> {
  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> stage(
      FilterQuery<Stage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'stage');
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterFilterCondition> stageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stage', 0, true, 0, true);
    });
  }
}

extension PaceDataQuerySortBy on QueryBuilder<PaceData, PaceData, QSortBy> {
  QueryBuilder<PaceData, PaceData, QAfterSortBy> sortByDistancia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.asc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> sortByDistanciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.desc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> sortByLatitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.asc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> sortByLatitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.desc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> sortByLongitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.asc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> sortByLongitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.desc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> sortByLongitudCurva() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitudCurva', Sort.asc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> sortByLongitudCurvaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitudCurva', Sort.desc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> sortByNota() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.asc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> sortByNotaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.desc);
    });
  }
}

extension PaceDataQuerySortThenBy
    on QueryBuilder<PaceData, PaceData, QSortThenBy> {
  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenByDistancia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.asc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenByDistanciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distancia', Sort.desc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenByLatitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.asc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenByLatitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitud', Sort.desc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenByLongitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.asc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenByLongitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitud', Sort.desc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenByLongitudCurva() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitudCurva', Sort.asc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenByLongitudCurvaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitudCurva', Sort.desc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenByNota() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.asc);
    });
  }

  QueryBuilder<PaceData, PaceData, QAfterSortBy> thenByNotaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.desc);
    });
  }
}

extension PaceDataQueryWhereDistinct
    on QueryBuilder<PaceData, PaceData, QDistinct> {
  QueryBuilder<PaceData, PaceData, QDistinct> distinctByDistancia() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distancia');
    });
  }

  QueryBuilder<PaceData, PaceData, QDistinct> distinctByLatitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitud');
    });
  }

  QueryBuilder<PaceData, PaceData, QDistinct> distinctByLongitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitud');
    });
  }

  QueryBuilder<PaceData, PaceData, QDistinct> distinctByLongitudCurva() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitudCurva');
    });
  }

  QueryBuilder<PaceData, PaceData, QDistinct> distinctByNota(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nota', caseSensitive: caseSensitive);
    });
  }
}

extension PaceDataQueryProperty
    on QueryBuilder<PaceData, PaceData, QQueryProperty> {
  QueryBuilder<PaceData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PaceData, int, QQueryOperations> distanciaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distancia');
    });
  }

  QueryBuilder<PaceData, double, QQueryOperations> latitudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitud');
    });
  }

  QueryBuilder<PaceData, double, QQueryOperations> longitudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitud');
    });
  }

  QueryBuilder<PaceData, int, QQueryOperations> longitudCurvaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitudCurva');
    });
  }

  QueryBuilder<PaceData, String, QQueryOperations> notaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nota');
    });
  }
}
