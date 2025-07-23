// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pregnancy.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PregnancySchema = Schema(
  name: r'Pregnancy',
  id: 7227108191498555627,
  properties: {
    r'birthForecast': PropertySchema(
      id: 0,
      name: r'birthForecast',
      type: IsarType.dateTime,
    ),
    r'ending': PropertySchema(
      id: 1,
      name: r'ending',
      type: IsarType.string,
      enumMap: _PregnancyendingEnumValueMap,
    ),
    r'endingDate': PropertySchema(
      id: 2,
      name: r'endingDate',
      type: IsarType.dateTime,
    ),
    r'failureObservation': PropertySchema(
      id: 3,
      name: r'failureObservation',
      type: IsarType.string,
    ),
    r'observation': PropertySchema(
      id: 4,
      name: r'observation',
      type: IsarType.string,
    )
  },
  estimateSize: _pregnancyEstimateSize,
  serialize: _pregnancySerialize,
  deserialize: _pregnancyDeserialize,
  deserializeProp: _pregnancyDeserializeProp,
);

int _pregnancyEstimateSize(
  Pregnancy object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.ending;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.failureObservation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.observation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _pregnancySerialize(
  Pregnancy object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.birthForecast);
  writer.writeString(offsets[1], object.ending?.name);
  writer.writeDateTime(offsets[2], object.endingDate);
  writer.writeString(offsets[3], object.failureObservation);
  writer.writeString(offsets[4], object.observation);
}

Pregnancy _pregnancyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Pregnancy();
  object.birthForecast = reader.readDateTime(offsets[0]);
  object.ending =
      _PregnancyendingValueEnumMap[reader.readStringOrNull(offsets[1])];
  object.endingDate = reader.readDateTimeOrNull(offsets[2]);
  object.failureObservation = reader.readStringOrNull(offsets[3]);
  object.observation = reader.readStringOrNull(offsets[4]);
  return object;
}

P _pregnancyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (_PregnancyendingValueEnumMap[reader.readStringOrNull(offset)])
          as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PregnancyendingEnumValueMap = {
  r'birth': r'birth',
  r'fail': r'fail',
};
const _PregnancyendingValueEnumMap = {
  r'birth': PregnancyEndingReason.birth,
  r'fail': PregnancyEndingReason.fail,
};

extension PregnancyQueryFilter
    on QueryBuilder<Pregnancy, Pregnancy, QFilterCondition> {
  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      birthForecastEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'birthForecast',
        value: value,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      birthForecastGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'birthForecast',
        value: value,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      birthForecastLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'birthForecast',
        value: value,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      birthForecastBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'birthForecast',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ending',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ending',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingEqualTo(
    PregnancyEndingReason? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ending',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingGreaterThan(
    PregnancyEndingReason? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ending',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingLessThan(
    PregnancyEndingReason? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ending',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingBetween(
    PregnancyEndingReason? lower,
    PregnancyEndingReason? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ending',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ending',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ending',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ending',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ending',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ending',
        value: '',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ending',
        value: '',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endingDate',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      endingDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endingDate',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endingDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      endingDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endingDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endingDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> endingDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endingDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'failureObservation',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'failureObservation',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'failureObservation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'failureObservation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'failureObservation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'failureObservation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'failureObservation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'failureObservation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'failureObservation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'failureObservation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'failureObservation',
        value: '',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      failureObservationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'failureObservation',
        value: '',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      observationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'observation',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      observationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'observation',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> observationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      observationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'observation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> observationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'observation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> observationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'observation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      observationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'observation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> observationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'observation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> observationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'observation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition> observationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'observation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      observationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observation',
        value: '',
      ));
    });
  }

  QueryBuilder<Pregnancy, Pregnancy, QAfterFilterCondition>
      observationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'observation',
        value: '',
      ));
    });
  }
}

extension PregnancyQueryObject
    on QueryBuilder<Pregnancy, Pregnancy, QFilterCondition> {}
