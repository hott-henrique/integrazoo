// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reproduction.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNaturalReproductionCollection on Isar {
  IsarCollection<NaturalReproduction> get naturalReproductions =>
      this.collection();
}

const NaturalReproductionSchema = CollectionSchema(
  name: r'NaturalReproduction',
  id: -7110182655082231045,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'diagnostic': PropertySchema(
      id: 1,
      name: r'diagnostic',
      type: IsarType.string,
      enumMap: _NaturalReproductiondiagnosticEnumValueMap,
    ),
    r'diagnosticDate': PropertySchema(
      id: 2,
      name: r'diagnosticDate',
      type: IsarType.dateTime,
    ),
    r'pregnancy': PropertySchema(
      id: 3,
      name: r'pregnancy',
      type: IsarType.object,
      target: r'Pregnancy',
    )
  },
  estimateSize: _naturalReproductionEstimateSize,
  serialize: _naturalReproductionSerialize,
  deserialize: _naturalReproductionDeserialize,
  deserializeProp: _naturalReproductionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'cow': LinkSchema(
      id: -6153808956904128379,
      name: r'cow',
      target: r'Bovine',
      single: true,
    ),
    r'bull': LinkSchema(
      id: 3285966712724116470,
      name: r'bull',
      target: r'Bovine',
      single: true,
    ),
    r'born': LinkSchema(
      id: 2107583759698134186,
      name: r'born',
      target: r'Bovine',
      single: true,
    )
  },
  embeddedSchemas: {r'Pregnancy': PregnancySchema},
  getId: _naturalReproductionGetId,
  getLinks: _naturalReproductionGetLinks,
  attach: _naturalReproductionAttach,
  version: '3.1.0+1',
);

int _naturalReproductionEstimateSize(
  NaturalReproduction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.diagnostic.name.length * 3;
  {
    final value = object.pregnancy;
    if (value != null) {
      bytesCount += 3 +
          PregnancySchema.estimateSize(
              value, allOffsets[Pregnancy]!, allOffsets);
    }
  }
  return bytesCount;
}

void _naturalReproductionSerialize(
  NaturalReproduction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeString(offsets[1], object.diagnostic.name);
  writer.writeDateTime(offsets[2], object.diagnosticDate);
  writer.writeObject<Pregnancy>(
    offsets[3],
    allOffsets,
    PregnancySchema.serialize,
    object.pregnancy,
  );
}

NaturalReproduction _naturalReproductionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NaturalReproduction();
  object.date = reader.readDateTime(offsets[0]);
  object.diagnostic = _NaturalReproductiondiagnosticValueEnumMap[
          reader.readStringOrNull(offsets[1])] ??
      ReproductionDiagnostic.waiting;
  object.diagnosticDate = reader.readDateTimeOrNull(offsets[2]);
  object.id = id;
  object.pregnancy = reader.readObjectOrNull<Pregnancy>(
    offsets[3],
    PregnancySchema.deserialize,
    allOffsets,
  );
  return object;
}

P _naturalReproductionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (_NaturalReproductiondiagnosticValueEnumMap[
              reader.readStringOrNull(offset)] ??
          ReproductionDiagnostic.waiting) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<Pregnancy>(
        offset,
        PregnancySchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _NaturalReproductiondiagnosticEnumValueMap = {
  r'waiting': r'waiting',
  r'positive': r'positive',
  r'negative': r'negative',
};
const _NaturalReproductiondiagnosticValueEnumMap = {
  r'waiting': ReproductionDiagnostic.waiting,
  r'positive': ReproductionDiagnostic.positive,
  r'negative': ReproductionDiagnostic.negative,
};

Id _naturalReproductionGetId(NaturalReproduction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _naturalReproductionGetLinks(
    NaturalReproduction object) {
  return [object.cow, object.bull, object.born];
}

void _naturalReproductionAttach(
    IsarCollection<dynamic> col, Id id, NaturalReproduction object) {
  object.id = id;
  object.cow.attach(col, col.isar.collection<Bovine>(), r'cow', id);
  object.bull.attach(col, col.isar.collection<Bovine>(), r'bull', id);
  object.born.attach(col, col.isar.collection<Bovine>(), r'born', id);
}

extension NaturalReproductionQueryWhereSort
    on QueryBuilder<NaturalReproduction, NaturalReproduction, QWhere> {
  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NaturalReproductionQueryWhere
    on QueryBuilder<NaturalReproduction, NaturalReproduction, QWhereClause> {
  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterWhereClause>
      idBetween(
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

extension NaturalReproductionQueryFilter on QueryBuilder<NaturalReproduction,
    NaturalReproduction, QFilterCondition> {
  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticEqualTo(
    ReproductionDiagnostic value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticGreaterThan(
    ReproductionDiagnostic value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticLessThan(
    ReproductionDiagnostic value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticBetween(
    ReproductionDiagnostic lower,
    ReproductionDiagnostic upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diagnostic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'diagnostic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diagnostic',
        value: '',
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'diagnostic',
        value: '',
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'diagnosticDate',
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'diagnosticDate',
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diagnosticDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diagnosticDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diagnosticDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      diagnosticDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diagnosticDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      pregnancyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pregnancy',
      ));
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      pregnancyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pregnancy',
      ));
    });
  }
}

extension NaturalReproductionQueryObject on QueryBuilder<NaturalReproduction,
    NaturalReproduction, QFilterCondition> {
  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      pregnancy(FilterQuery<Pregnancy> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pregnancy');
    });
  }
}

extension NaturalReproductionQueryLinks on QueryBuilder<NaturalReproduction,
    NaturalReproduction, QFilterCondition> {
  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      cow(FilterQuery<Bovine> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'cow');
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      cowIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cow', 0, true, 0, true);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      bull(FilterQuery<Bovine> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'bull');
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      bullIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'bull', 0, true, 0, true);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      born(FilterQuery<Bovine> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'born');
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterFilterCondition>
      bornIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'born', 0, true, 0, true);
    });
  }
}

extension NaturalReproductionQuerySortBy
    on QueryBuilder<NaturalReproduction, NaturalReproduction, QSortBy> {
  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      sortByDiagnostic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnostic', Sort.asc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      sortByDiagnosticDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnostic', Sort.desc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      sortByDiagnosticDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosticDate', Sort.asc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      sortByDiagnosticDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosticDate', Sort.desc);
    });
  }
}

extension NaturalReproductionQuerySortThenBy
    on QueryBuilder<NaturalReproduction, NaturalReproduction, QSortThenBy> {
  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      thenByDiagnostic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnostic', Sort.asc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      thenByDiagnosticDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnostic', Sort.desc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      thenByDiagnosticDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosticDate', Sort.asc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      thenByDiagnosticDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosticDate', Sort.desc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension NaturalReproductionQueryWhereDistinct
    on QueryBuilder<NaturalReproduction, NaturalReproduction, QDistinct> {
  QueryBuilder<NaturalReproduction, NaturalReproduction, QDistinct>
      distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QDistinct>
      distinctByDiagnostic({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diagnostic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NaturalReproduction, NaturalReproduction, QDistinct>
      distinctByDiagnosticDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diagnosticDate');
    });
  }
}

extension NaturalReproductionQueryProperty
    on QueryBuilder<NaturalReproduction, NaturalReproduction, QQueryProperty> {
  QueryBuilder<NaturalReproduction, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NaturalReproduction, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<NaturalReproduction, ReproductionDiagnostic, QQueryOperations>
      diagnosticProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diagnostic');
    });
  }

  QueryBuilder<NaturalReproduction, DateTime?, QQueryOperations>
      diagnosticDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diagnosticDate');
    });
  }

  QueryBuilder<NaturalReproduction, Pregnancy?, QQueryOperations>
      pregnancyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pregnancy');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetArtificialInseminationReproductionCollection on Isar {
  IsarCollection<ArtificialInseminationReproduction>
      get artificialInseminationReproductions => this.collection();
}

const ArtificialInseminationReproductionSchema = CollectionSchema(
  name: r'ArtificialInseminationReproduction',
  id: 8958411353578333609,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'diagnostic': PropertySchema(
      id: 1,
      name: r'diagnostic',
      type: IsarType.string,
      enumMap: _ArtificialInseminationReproductiondiagnosticEnumValueMap,
    ),
    r'diagnosticDate': PropertySchema(
      id: 2,
      name: r'diagnosticDate',
      type: IsarType.dateTime,
    ),
    r'pregnancy': PropertySchema(
      id: 3,
      name: r'pregnancy',
      type: IsarType.object,
      target: r'Pregnancy',
    ),
    r'straw': PropertySchema(
      id: 4,
      name: r'straw',
      type: IsarType.string,
    )
  },
  estimateSize: _artificialInseminationReproductionEstimateSize,
  serialize: _artificialInseminationReproductionSerialize,
  deserialize: _artificialInseminationReproductionDeserialize,
  deserializeProp: _artificialInseminationReproductionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'cow': LinkSchema(
      id: -722564969223952720,
      name: r'cow',
      target: r'Bovine',
      single: true,
    ),
    r'breeder': LinkSchema(
      id: 4137927702141913449,
      name: r'breeder',
      target: r'Breeder',
      single: true,
    ),
    r'born': LinkSchema(
      id: 3319030893601354102,
      name: r'born',
      target: r'Bovine',
      single: true,
    )
  },
  embeddedSchemas: {r'Pregnancy': PregnancySchema},
  getId: _artificialInseminationReproductionGetId,
  getLinks: _artificialInseminationReproductionGetLinks,
  attach: _artificialInseminationReproductionAttach,
  version: '3.1.0+1',
);

int _artificialInseminationReproductionEstimateSize(
  ArtificialInseminationReproduction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.diagnostic.name.length * 3;
  {
    final value = object.pregnancy;
    if (value != null) {
      bytesCount += 3 +
          PregnancySchema.estimateSize(
              value, allOffsets[Pregnancy]!, allOffsets);
    }
  }
  bytesCount += 3 + object.straw.length * 3;
  return bytesCount;
}

void _artificialInseminationReproductionSerialize(
  ArtificialInseminationReproduction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeString(offsets[1], object.diagnostic.name);
  writer.writeDateTime(offsets[2], object.diagnosticDate);
  writer.writeObject<Pregnancy>(
    offsets[3],
    allOffsets,
    PregnancySchema.serialize,
    object.pregnancy,
  );
  writer.writeString(offsets[4], object.straw);
}

ArtificialInseminationReproduction
    _artificialInseminationReproductionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ArtificialInseminationReproduction();
  object.date = reader.readDateTime(offsets[0]);
  object.diagnostic = _ArtificialInseminationReproductiondiagnosticValueEnumMap[
          reader.readStringOrNull(offsets[1])] ??
      ReproductionDiagnostic.waiting;
  object.diagnosticDate = reader.readDateTimeOrNull(offsets[2]);
  object.id = id;
  object.pregnancy = reader.readObjectOrNull<Pregnancy>(
    offsets[3],
    PregnancySchema.deserialize,
    allOffsets,
  );
  object.straw = reader.readString(offsets[4]);
  return object;
}

P _artificialInseminationReproductionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (_ArtificialInseminationReproductiondiagnosticValueEnumMap[
              reader.readStringOrNull(offset)] ??
          ReproductionDiagnostic.waiting) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<Pregnancy>(
        offset,
        PregnancySchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ArtificialInseminationReproductiondiagnosticEnumValueMap = {
  r'waiting': r'waiting',
  r'positive': r'positive',
  r'negative': r'negative',
};
const _ArtificialInseminationReproductiondiagnosticValueEnumMap = {
  r'waiting': ReproductionDiagnostic.waiting,
  r'positive': ReproductionDiagnostic.positive,
  r'negative': ReproductionDiagnostic.negative,
};

Id _artificialInseminationReproductionGetId(
    ArtificialInseminationReproduction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _artificialInseminationReproductionGetLinks(
    ArtificialInseminationReproduction object) {
  return [object.cow, object.breeder, object.born];
}

void _artificialInseminationReproductionAttach(IsarCollection<dynamic> col,
    Id id, ArtificialInseminationReproduction object) {
  object.id = id;
  object.cow.attach(col, col.isar.collection<Bovine>(), r'cow', id);
  object.breeder.attach(col, col.isar.collection<Breeder>(), r'breeder', id);
  object.born.attach(col, col.isar.collection<Bovine>(), r'born', id);
}

extension ArtificialInseminationReproductionQueryWhereSort on QueryBuilder<
    ArtificialInseminationReproduction,
    ArtificialInseminationReproduction,
    QWhere> {
  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ArtificialInseminationReproductionQueryWhere on QueryBuilder<
    ArtificialInseminationReproduction,
    ArtificialInseminationReproduction,
    QWhereClause> {
  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterWhereClause> idBetween(
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

extension ArtificialInseminationReproductionQueryFilter on QueryBuilder<
    ArtificialInseminationReproduction,
    ArtificialInseminationReproduction,
    QFilterCondition> {
  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticEqualTo(
    ReproductionDiagnostic value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticGreaterThan(
    ReproductionDiagnostic value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticLessThan(
    ReproductionDiagnostic value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticBetween(
    ReproductionDiagnostic lower,
    ReproductionDiagnostic upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diagnostic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
          ArtificialInseminationReproduction, QAfterFilterCondition>
      diagnosticContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'diagnostic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
          ArtificialInseminationReproduction, QAfterFilterCondition>
      diagnosticMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'diagnostic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diagnostic',
        value: '',
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'diagnostic',
        value: '',
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'diagnosticDate',
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'diagnosticDate',
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diagnosticDate',
        value: value,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diagnosticDate',
        value: value,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diagnosticDate',
        value: value,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> diagnosticDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diagnosticDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterFilterCondition> idBetween(
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

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> pregnancyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pregnancy',
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> pregnancyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pregnancy',
      ));
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterFilterCondition> strawEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'straw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> strawGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'straw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterFilterCondition> strawLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'straw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterFilterCondition> strawBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'straw',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> strawStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'straw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterFilterCondition> strawEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'straw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
          ArtificialInseminationReproduction, QAfterFilterCondition>
      strawContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'straw',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
          ArtificialInseminationReproduction, QAfterFilterCondition>
      strawMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'straw',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> strawIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'straw',
        value: '',
      ));
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> strawIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'straw',
        value: '',
      ));
    });
  }
}

extension ArtificialInseminationReproductionQueryObject on QueryBuilder<
    ArtificialInseminationReproduction,
    ArtificialInseminationReproduction,
    QFilterCondition> {
  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> pregnancy(FilterQuery<Pregnancy> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pregnancy');
    });
  }
}

extension ArtificialInseminationReproductionQueryLinks on QueryBuilder<
    ArtificialInseminationReproduction,
    ArtificialInseminationReproduction,
    QFilterCondition> {
  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> cow(FilterQuery<Bovine> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'cow');
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterFilterCondition> cowIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cow', 0, true, 0, true);
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> breeder(FilterQuery<Breeder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'breeder');
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> breederIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'breeder', 0, true, 0, true);
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterFilterCondition> born(FilterQuery<Bovine> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'born');
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterFilterCondition> bornIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'born', 0, true, 0, true);
    });
  }
}

extension ArtificialInseminationReproductionQuerySortBy on QueryBuilder<
    ArtificialInseminationReproduction,
    ArtificialInseminationReproduction,
    QSortBy> {
  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> sortByDiagnostic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnostic', Sort.asc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> sortByDiagnosticDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnostic', Sort.desc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> sortByDiagnosticDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosticDate', Sort.asc);
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterSortBy> sortByDiagnosticDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosticDate', Sort.desc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> sortByStraw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'straw', Sort.asc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> sortByStrawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'straw', Sort.desc);
    });
  }
}

extension ArtificialInseminationReproductionQuerySortThenBy on QueryBuilder<
    ArtificialInseminationReproduction,
    ArtificialInseminationReproduction,
    QSortThenBy> {
  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> thenByDiagnostic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnostic', Sort.asc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> thenByDiagnosticDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnostic', Sort.desc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> thenByDiagnosticDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosticDate', Sort.asc);
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QAfterSortBy> thenByDiagnosticDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosticDate', Sort.desc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> thenByStraw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'straw', Sort.asc);
    });
  }

  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QAfterSortBy> thenByStrawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'straw', Sort.desc);
    });
  }
}

extension ArtificialInseminationReproductionQueryWhereDistinct on QueryBuilder<
    ArtificialInseminationReproduction,
    ArtificialInseminationReproduction,
    QDistinct> {
  QueryBuilder<ArtificialInseminationReproduction,
      ArtificialInseminationReproduction, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QDistinct> distinctByDiagnostic({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diagnostic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QDistinct> distinctByDiagnosticDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diagnosticDate');
    });
  }

  QueryBuilder<
      ArtificialInseminationReproduction,
      ArtificialInseminationReproduction,
      QDistinct> distinctByStraw({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'straw', caseSensitive: caseSensitive);
    });
  }
}

extension ArtificialInseminationReproductionQueryProperty on QueryBuilder<
    ArtificialInseminationReproduction,
    ArtificialInseminationReproduction,
    QQueryProperty> {
  QueryBuilder<ArtificialInseminationReproduction, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ArtificialInseminationReproduction, DateTime, QQueryOperations>
      dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<ArtificialInseminationReproduction, ReproductionDiagnostic,
      QQueryOperations> diagnosticProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diagnostic');
    });
  }

  QueryBuilder<ArtificialInseminationReproduction, DateTime?, QQueryOperations>
      diagnosticDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diagnosticDate');
    });
  }

  QueryBuilder<ArtificialInseminationReproduction, Pregnancy?, QQueryOperations>
      pregnancyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pregnancy');
    });
  }

  QueryBuilder<ArtificialInseminationReproduction, String, QQueryOperations>
      strawProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'straw');
    });
  }
}
