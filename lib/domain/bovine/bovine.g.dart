// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bovine.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBovineCollection on Isar {
  IsarCollection<Bovine> get bovines => this.collection();
}

const BovineSchema = CollectionSchema(
  name: r'Bovine',
  id: -6121611489335986714,
  properties: {
    r'bornFrom': PropertySchema(
      id: 0,
      name: r'bornFrom',
      type: IsarType.byte,
      enumMap: _BovinebornFromEnumValueMap,
    ),
    r'breed': PropertySchema(
      id: 1,
      name: r'breed',
      type: IsarType.string,
    ),
    r'finishingReason': PropertySchema(
      id: 2,
      name: r'finishingReason',
      type: IsarType.byte,
      enumMap: _BovinefinishingReasonEnumValueMap,
    ),
    r'isBreeder': PropertySchema(
      id: 3,
      name: r'isBreeder',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'sex': PropertySchema(
      id: 5,
      name: r'sex',
      type: IsarType.string,
      enumMap: _BovinesexEnumValueMap,
    )
  },
  estimateSize: _bovineEstimateSize,
  serialize: _bovineSerialize,
  deserialize: _bovineDeserialize,
  deserializeProp: _bovineDeserializeProp,
  idName: r'earring',
  indexes: {},
  links: {
    r'birth': LinkSchema(
      id: -2424289024066943949,
      name: r'birth',
      target: r'Weighing',
      single: true,
    ),
    r'weaning': LinkSchema(
      id: 5502700445785791507,
      name: r'weaning',
      target: r'Weighing',
      single: true,
    ),
    r'entry': LinkSchema(
      id: -9107151387552079369,
      name: r'entry',
      target: r'Weighing',
      single: true,
    ),
    r'yearling': LinkSchema(
      id: 696429612694372695,
      name: r'yearling',
      target: r'Weighing',
      single: true,
    ),
    r'finish': LinkSchema(
      id: -3926986677252777922,
      name: r'finish',
      target: r'Weighing',
      single: true,
    ),
    r'naturalReproductionsFEMALE': LinkSchema(
      id: -3320585972423883783,
      name: r'naturalReproductionsFEMALE',
      target: r'NaturalReproduction',
      single: false,
      linkName: r'cow',
    ),
    r'naturalReproductionsMALE': LinkSchema(
      id: -2949160457828150985,
      name: r'naturalReproductionsMALE',
      target: r'NaturalReproduction',
      single: false,
      linkName: r'bull',
    ),
    r'artificialInseminations': LinkSchema(
      id: 8507048044794216607,
      name: r'artificialInseminations',
      target: r'ArtificialInseminationReproduction',
      single: false,
      linkName: r'cow',
    ),
    r'vaccines': LinkSchema(
      id: -4309584227982221978,
      name: r'vaccines',
      target: r'Vaccine',
      single: false,
      linkName: r'bovine',
    ),
    r'treatments': LinkSchema(
      id: 1314974582216880251,
      name: r'treatments',
      target: r'Treatment',
      single: false,
      linkName: r'bovine',
    ),
    r'weighings': LinkSchema(
      id: 9218358687171648265,
      name: r'weighings',
      target: r'Weighing',
      single: false,
      linkName: r'bovine',
    ),
    r'artificialInsemination': LinkSchema(
      id: 661970813545706758,
      name: r'artificialInsemination',
      target: r'ArtificialInseminationReproduction',
      single: true,
      linkName: r'born',
    ),
    r'naturalReproduction': LinkSchema(
      id: 2204931446052234214,
      name: r'naturalReproduction',
      target: r'NaturalReproduction',
      single: true,
      linkName: r'born',
    )
  },
  embeddedSchemas: {},
  getId: _bovineGetId,
  getLinks: _bovineGetLinks,
  attach: _bovineAttach,
  version: '3.1.0+1',
);

int _bovineEstimateSize(
  Bovine object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.breed.length * 3;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.sex.name.length * 3;
  return bytesCount;
}

void _bovineSerialize(
  Bovine object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.bornFrom.index);
  writer.writeString(offsets[1], object.breed);
  writer.writeByte(offsets[2], object.finishingReason.index);
  writer.writeBool(offsets[3], object.isBreeder);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.sex.name);
}

Bovine _bovineDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Bovine();
  object.bornFrom =
      _BovinebornFromValueEnumMap[reader.readByteOrNull(offsets[0])] ??
          ReproductionKind.unknown;
  object.breed = reader.readString(offsets[1]);
  object.earring = id;
  object.finishingReason =
      _BovinefinishingReasonValueEnumMap[reader.readByteOrNull(offsets[2])] ??
          FinishingReason.notYet;
  object.isBreeder = reader.readBool(offsets[3]);
  object.name = reader.readStringOrNull(offsets[4]);
  object.sex =
      _BovinesexValueEnumMap[reader.readStringOrNull(offsets[5])] ?? Sex.male;
  return object;
}

P _bovineDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_BovinebornFromValueEnumMap[reader.readByteOrNull(offset)] ??
          ReproductionKind.unknown) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (_BovinefinishingReasonValueEnumMap[
              reader.readByteOrNull(offset)] ??
          FinishingReason.notYet) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (_BovinesexValueEnumMap[reader.readStringOrNull(offset)] ??
          Sex.male) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _BovinebornFromEnumValueMap = {
  'unknown': 0,
  'artificialInsemination': 1,
  'natural': 2,
};
const _BovinebornFromValueEnumMap = {
  0: ReproductionKind.unknown,
  1: ReproductionKind.artificialInsemination,
  2: ReproductionKind.natural,
};
const _BovinefinishingReasonEnumValueMap = {
  'notYet': 0,
  'discard': 1,
  'sell': 2,
  'death': 3,
  'slaughter': 4,
};
const _BovinefinishingReasonValueEnumMap = {
  0: FinishingReason.notYet,
  1: FinishingReason.discard,
  2: FinishingReason.sell,
  3: FinishingReason.death,
  4: FinishingReason.slaughter,
};
const _BovinesexEnumValueMap = {
  r'male': r'male',
  r'female': r'female',
};
const _BovinesexValueEnumMap = {
  r'male': Sex.male,
  r'female': Sex.female,
};

Id _bovineGetId(Bovine object) {
  return object.earring;
}

List<IsarLinkBase<dynamic>> _bovineGetLinks(Bovine object) {
  return [
    object.birth,
    object.weaning,
    object.entry,
    object.yearling,
    object.finish,
    object.naturalReproductionsFEMALE,
    object.naturalReproductionsMALE,
    object.artificialInseminations,
    object.vaccines,
    object.treatments,
    object.weighings,
    object.artificialInsemination,
    object.naturalReproduction
  ];
}

void _bovineAttach(IsarCollection<dynamic> col, Id id, Bovine object) {
  object.earring = id;
  object.birth.attach(col, col.isar.collection<Weighing>(), r'birth', id);
  object.weaning.attach(col, col.isar.collection<Weighing>(), r'weaning', id);
  object.entry.attach(col, col.isar.collection<Weighing>(), r'entry', id);
  object.yearling.attach(col, col.isar.collection<Weighing>(), r'yearling', id);
  object.finish.attach(col, col.isar.collection<Weighing>(), r'finish', id);
  object.naturalReproductionsFEMALE.attach(
      col,
      col.isar.collection<NaturalReproduction>(),
      r'naturalReproductionsFEMALE',
      id);
  object.naturalReproductionsMALE.attach(
      col,
      col.isar.collection<NaturalReproduction>(),
      r'naturalReproductionsMALE',
      id);
  object.artificialInseminations.attach(
      col,
      col.isar.collection<ArtificialInseminationReproduction>(),
      r'artificialInseminations',
      id);
  object.vaccines.attach(col, col.isar.collection<Vaccine>(), r'vaccines', id);
  object.treatments
      .attach(col, col.isar.collection<Treatment>(), r'treatments', id);
  object.weighings
      .attach(col, col.isar.collection<Weighing>(), r'weighings', id);
  object.artificialInsemination.attach(
      col,
      col.isar.collection<ArtificialInseminationReproduction>(),
      r'artificialInsemination',
      id);
  object.naturalReproduction.attach(col,
      col.isar.collection<NaturalReproduction>(), r'naturalReproduction', id);
}

extension BovineQueryWhereSort on QueryBuilder<Bovine, Bovine, QWhere> {
  QueryBuilder<Bovine, Bovine, QAfterWhere> anyEarring() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BovineQueryWhere on QueryBuilder<Bovine, Bovine, QWhereClause> {
  QueryBuilder<Bovine, Bovine, QAfterWhereClause> earringEqualTo(Id earring) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: earring,
        upper: earring,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterWhereClause> earringNotEqualTo(
      Id earring) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: earring, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: earring, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: earring, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: earring, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterWhereClause> earringGreaterThan(Id earring,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: earring, includeLower: include),
      );
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterWhereClause> earringLessThan(Id earring,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: earring, includeUpper: include),
      );
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterWhereClause> earringBetween(
    Id lowerEarring,
    Id upperEarring, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerEarring,
        includeLower: includeLower,
        upper: upperEarring,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BovineQueryFilter on QueryBuilder<Bovine, Bovine, QFilterCondition> {
  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> bornFromEqualTo(
      ReproductionKind value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bornFrom',
        value: value,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> bornFromGreaterThan(
    ReproductionKind value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bornFrom',
        value: value,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> bornFromLessThan(
    ReproductionKind value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bornFrom',
        value: value,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> bornFromBetween(
    ReproductionKind lower,
    ReproductionKind upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bornFrom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> breedEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> breedGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> breedLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> breedBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> breedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> breedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> breedContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> breedMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'breed',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> breedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breed',
        value: '',
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> breedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'breed',
        value: '',
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> earringEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'earring',
        value: value,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> earringGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'earring',
        value: value,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> earringLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'earring',
        value: value,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> earringBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'earring',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> finishingReasonEqualTo(
      FinishingReason value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finishingReason',
        value: value,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      finishingReasonGreaterThan(
    FinishingReason value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finishingReason',
        value: value,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> finishingReasonLessThan(
    FinishingReason value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finishingReason',
        value: value,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> finishingReasonBetween(
    FinishingReason lower,
    FinishingReason upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finishingReason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> isBreederEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBreeder',
        value: value,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> sexEqualTo(
    Sex value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> sexGreaterThan(
    Sex value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> sexLessThan(
    Sex value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> sexBetween(
    Sex lower,
    Sex upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> sexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> sexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> sexContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> sexMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> sexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sex',
        value: '',
      ));
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> sexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sex',
        value: '',
      ));
    });
  }
}

extension BovineQueryObject on QueryBuilder<Bovine, Bovine, QFilterCondition> {}

extension BovineQueryLinks on QueryBuilder<Bovine, Bovine, QFilterCondition> {
  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> birth(
      FilterQuery<Weighing> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'birth');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> birthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'birth', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> weaning(
      FilterQuery<Weighing> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'weaning');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> weaningIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'weaning', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> entry(
      FilterQuery<Weighing> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'entry');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> entryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'entry', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> yearling(
      FilterQuery<Weighing> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'yearling');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> yearlingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'yearling', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> finish(
      FilterQuery<Weighing> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'finish');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> finishIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'finish', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsFEMALE(FilterQuery<NaturalReproduction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'naturalReproductionsFEMALE');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsFEMALELengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'naturalReproductionsFEMALE', length, true, length, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsFEMALEIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'naturalReproductionsFEMALE', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsFEMALEIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'naturalReproductionsFEMALE', 0, false, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsFEMALELengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'naturalReproductionsFEMALE', 0, true, length, include);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsFEMALELengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'naturalReproductionsFEMALE', length, include, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsFEMALELengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'naturalReproductionsFEMALE', lower,
          includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> naturalReproductionsMALE(
      FilterQuery<NaturalReproduction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'naturalReproductionsMALE');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsMALELengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'naturalReproductionsMALE', length, true, length, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsMALEIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'naturalReproductionsMALE', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsMALEIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'naturalReproductionsMALE', 0, false, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsMALELengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'naturalReproductionsMALE', 0, true, length, include);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsMALELengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'naturalReproductionsMALE', length, include, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionsMALELengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'naturalReproductionsMALE', lower, includeLower,
          upper, includeUpper);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> artificialInseminations(
      FilterQuery<ArtificialInseminationReproduction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'artificialInseminations');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      artificialInseminationsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'artificialInseminations', length, true, length, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      artificialInseminationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'artificialInseminations', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      artificialInseminationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'artificialInseminations', 0, false, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      artificialInseminationsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'artificialInseminations', 0, true, length, include);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      artificialInseminationsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'artificialInseminations', length, include, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      artificialInseminationsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'artificialInseminations', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> vaccines(
      FilterQuery<Vaccine> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'vaccines');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> vaccinesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'vaccines', length, true, length, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> vaccinesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'vaccines', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> vaccinesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'vaccines', 0, false, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> vaccinesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'vaccines', 0, true, length, include);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> vaccinesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'vaccines', length, include, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> vaccinesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'vaccines', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> treatments(
      FilterQuery<Treatment> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'treatments');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> treatmentsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'treatments', length, true, length, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> treatmentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'treatments', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> treatmentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'treatments', 0, false, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> treatmentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'treatments', 0, true, length, include);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      treatmentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'treatments', length, include, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> treatmentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'treatments', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> weighings(
      FilterQuery<Weighing> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'weighings');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> weighingsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'weighings', length, true, length, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> weighingsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'weighings', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> weighingsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'weighings', 0, false, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> weighingsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'weighings', 0, true, length, include);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      weighingsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'weighings', length, include, 999999, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> weighingsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'weighings', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> artificialInsemination(
      FilterQuery<ArtificialInseminationReproduction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'artificialInsemination');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      artificialInseminationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'artificialInsemination', 0, true, 0, true);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition> naturalReproduction(
      FilterQuery<NaturalReproduction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'naturalReproduction');
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterFilterCondition>
      naturalReproductionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'naturalReproduction', 0, true, 0, true);
    });
  }
}

extension BovineQuerySortBy on QueryBuilder<Bovine, Bovine, QSortBy> {
  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortByBornFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bornFrom', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortByBornFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bornFrom', Sort.desc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortByBreed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortByBreedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.desc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortByFinishingReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishingReason', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortByFinishingReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishingReason', Sort.desc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortByIsBreeder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBreeder', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortByIsBreederDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBreeder', Sort.desc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortBySex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sex', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> sortBySexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sex', Sort.desc);
    });
  }
}

extension BovineQuerySortThenBy on QueryBuilder<Bovine, Bovine, QSortThenBy> {
  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByBornFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bornFrom', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByBornFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bornFrom', Sort.desc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByBreed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByBreedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.desc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByEarring() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earring', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByEarringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earring', Sort.desc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByFinishingReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishingReason', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByFinishingReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishingReason', Sort.desc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByIsBreeder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBreeder', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByIsBreederDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBreeder', Sort.desc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenBySex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sex', Sort.asc);
    });
  }

  QueryBuilder<Bovine, Bovine, QAfterSortBy> thenBySexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sex', Sort.desc);
    });
  }
}

extension BovineQueryWhereDistinct on QueryBuilder<Bovine, Bovine, QDistinct> {
  QueryBuilder<Bovine, Bovine, QDistinct> distinctByBornFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bornFrom');
    });
  }

  QueryBuilder<Bovine, Bovine, QDistinct> distinctByBreed(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breed', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Bovine, Bovine, QDistinct> distinctByFinishingReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finishingReason');
    });
  }

  QueryBuilder<Bovine, Bovine, QDistinct> distinctByIsBreeder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBreeder');
    });
  }

  QueryBuilder<Bovine, Bovine, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Bovine, Bovine, QDistinct> distinctBySex(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sex', caseSensitive: caseSensitive);
    });
  }
}

extension BovineQueryProperty on QueryBuilder<Bovine, Bovine, QQueryProperty> {
  QueryBuilder<Bovine, int, QQueryOperations> earringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'earring');
    });
  }

  QueryBuilder<Bovine, ReproductionKind, QQueryOperations> bornFromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bornFrom');
    });
  }

  QueryBuilder<Bovine, String, QQueryOperations> breedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breed');
    });
  }

  QueryBuilder<Bovine, FinishingReason, QQueryOperations>
      finishingReasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finishingReason');
    });
  }

  QueryBuilder<Bovine, bool, QQueryOperations> isBreederProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBreeder');
    });
  }

  QueryBuilder<Bovine, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Bovine, Sex, QQueryOperations> sexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sex');
    });
  }
}
