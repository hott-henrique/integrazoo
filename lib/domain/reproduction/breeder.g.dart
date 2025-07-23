// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeder.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBreederCollection on Isar {
  IsarCollection<Breeder> get breeders => this.collection();
}

const BreederSchema = CollectionSchema(
  name: r'Breeder',
  id: 1362462279712110032,
  properties: {
    r'breed': PropertySchema(
      id: 0,
      name: r'breed',
      type: IsarType.string,
    ),
    r'epd': PropertySchema(
      id: 1,
      name: r'epd',
      type: IsarType.object,
      target: r'BreederEPD',
    ),
    r'fatherGrandParents': PropertySchema(
      id: 2,
      name: r'fatherGrandParents',
      type: IsarType.object,
      target: r'BreederParents',
    ),
    r'identifier': PropertySchema(
      id: 3,
      name: r'identifier',
      type: IsarType.string,
    ),
    r'motherGrandParents': PropertySchema(
      id: 4,
      name: r'motherGrandParents',
      type: IsarType.object,
      target: r'BreederParents',
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'parents': PropertySchema(
      id: 6,
      name: r'parents',
      type: IsarType.object,
      target: r'BreederParents',
    ),
    r'sex': PropertySchema(
      id: 7,
      name: r'sex',
      type: IsarType.string,
      enumMap: _BreedersexEnumValueMap,
    )
  },
  estimateSize: _breederEstimateSize,
  serialize: _breederSerialize,
  deserialize: _breederDeserialize,
  deserializeProp: _breederDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'artificialInseminations': LinkSchema(
      id: 8507048044794216607,
      name: r'artificialInseminations',
      target: r'ArtificialInseminationReproduction',
      single: false,
      linkName: r'cow',
    )
  },
  embeddedSchemas: {
    r'BreederParents': BreederParentsSchema,
    r'BreederEPD': BreederEPDSchema
  },
  getId: _breederGetId,
  getLinks: _breederGetLinks,
  attach: _breederAttach,
  version: '3.1.0+1',
);

int _breederEstimateSize(
  Breeder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.breed.length * 3;
  {
    final value = object.epd;
    if (value != null) {
      bytesCount += 3 +
          BreederEPDSchema.estimateSize(
              value, allOffsets[BreederEPD]!, allOffsets);
    }
  }
  {
    final value = object.fatherGrandParents;
    if (value != null) {
      bytesCount += 3 +
          BreederParentsSchema.estimateSize(
              value, allOffsets[BreederParents]!, allOffsets);
    }
  }
  bytesCount += 3 + object.identifier.length * 3;
  {
    final value = object.motherGrandParents;
    if (value != null) {
      bytesCount += 3 +
          BreederParentsSchema.estimateSize(
              value, allOffsets[BreederParents]!, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.parents;
    if (value != null) {
      bytesCount += 3 +
          BreederParentsSchema.estimateSize(
              value, allOffsets[BreederParents]!, allOffsets);
    }
  }
  bytesCount += 3 + object.sex.name.length * 3;
  return bytesCount;
}

void _breederSerialize(
  Breeder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.breed);
  writer.writeObject<BreederEPD>(
    offsets[1],
    allOffsets,
    BreederEPDSchema.serialize,
    object.epd,
  );
  writer.writeObject<BreederParents>(
    offsets[2],
    allOffsets,
    BreederParentsSchema.serialize,
    object.fatherGrandParents,
  );
  writer.writeString(offsets[3], object.identifier);
  writer.writeObject<BreederParents>(
    offsets[4],
    allOffsets,
    BreederParentsSchema.serialize,
    object.motherGrandParents,
  );
  writer.writeString(offsets[5], object.name);
  writer.writeObject<BreederParents>(
    offsets[6],
    allOffsets,
    BreederParentsSchema.serialize,
    object.parents,
  );
  writer.writeString(offsets[7], object.sex.name);
}

Breeder _breederDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Breeder();
  object.breed = reader.readString(offsets[0]);
  object.epd = reader.readObjectOrNull<BreederEPD>(
    offsets[1],
    BreederEPDSchema.deserialize,
    allOffsets,
  );
  object.fatherGrandParents = reader.readObjectOrNull<BreederParents>(
    offsets[2],
    BreederParentsSchema.deserialize,
    allOffsets,
  );
  object.id = id;
  object.identifier = reader.readString(offsets[3]);
  object.motherGrandParents = reader.readObjectOrNull<BreederParents>(
    offsets[4],
    BreederParentsSchema.deserialize,
    allOffsets,
  );
  object.name = reader.readString(offsets[5]);
  object.parents = reader.readObjectOrNull<BreederParents>(
    offsets[6],
    BreederParentsSchema.deserialize,
    allOffsets,
  );
  object.sex =
      _BreedersexValueEnumMap[reader.readStringOrNull(offsets[7])] ?? Sex.male;
  return object;
}

P _breederDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<BreederEPD>(
        offset,
        BreederEPDSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readObjectOrNull<BreederParents>(
        offset,
        BreederParentsSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readObjectOrNull<BreederParents>(
        offset,
        BreederParentsSchema.deserialize,
        allOffsets,
      )) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readObjectOrNull<BreederParents>(
        offset,
        BreederParentsSchema.deserialize,
        allOffsets,
      )) as P;
    case 7:
      return (_BreedersexValueEnumMap[reader.readStringOrNull(offset)] ??
          Sex.male) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _BreedersexEnumValueMap = {
  r'male': r'male',
  r'female': r'female',
};
const _BreedersexValueEnumMap = {
  r'male': Sex.male,
  r'female': Sex.female,
};

Id _breederGetId(Breeder object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _breederGetLinks(Breeder object) {
  return [object.artificialInseminations];
}

void _breederAttach(IsarCollection<dynamic> col, Id id, Breeder object) {
  object.id = id;
  object.artificialInseminations.attach(
      col,
      col.isar.collection<ArtificialInseminationReproduction>(),
      r'artificialInseminations',
      id);
}

extension BreederQueryWhereSort on QueryBuilder<Breeder, Breeder, QWhere> {
  QueryBuilder<Breeder, Breeder, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BreederQueryWhere on QueryBuilder<Breeder, Breeder, QWhereClause> {
  QueryBuilder<Breeder, Breeder, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Breeder, Breeder, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterWhereClause> idBetween(
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

extension BreederQueryFilter
    on QueryBuilder<Breeder, Breeder, QFilterCondition> {
  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> breedEqualTo(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> breedGreaterThan(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> breedLessThan(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> breedBetween(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> breedStartsWith(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> breedEndsWith(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> breedContains(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> breedMatches(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> breedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breed',
        value: '',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> breedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'breed',
        value: '',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> epdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'epd',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> epdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'epd',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition>
      fatherGrandParentsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fatherGrandParents',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition>
      fatherGrandParentsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fatherGrandParents',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> identifierEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> identifierGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> identifierLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> identifierBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'identifier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> identifierStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> identifierEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> identifierContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> identifierMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'identifier',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> identifierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'identifier',
        value: '',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> identifierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'identifier',
        value: '',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition>
      motherGrandParentsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motherGrandParents',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition>
      motherGrandParentsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motherGrandParents',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> nameEqualTo(
    String value, {
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> nameGreaterThan(
    String value, {
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> nameLessThan(
    String value, {
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> parentsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parents',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> parentsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parents',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> sexEqualTo(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> sexGreaterThan(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> sexLessThan(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> sexBetween(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> sexStartsWith(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> sexEndsWith(
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

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> sexContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> sexMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> sexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sex',
        value: '',
      ));
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> sexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sex',
        value: '',
      ));
    });
  }
}

extension BreederQueryObject
    on QueryBuilder<Breeder, Breeder, QFilterCondition> {
  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> epd(
      FilterQuery<BreederEPD> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'epd');
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> fatherGrandParents(
      FilterQuery<BreederParents> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fatherGrandParents');
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> motherGrandParents(
      FilterQuery<BreederParents> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'motherGrandParents');
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> parents(
      FilterQuery<BreederParents> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'parents');
    });
  }
}

extension BreederQueryLinks
    on QueryBuilder<Breeder, Breeder, QFilterCondition> {
  QueryBuilder<Breeder, Breeder, QAfterFilterCondition> artificialInseminations(
      FilterQuery<ArtificialInseminationReproduction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'artificialInseminations');
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition>
      artificialInseminationsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'artificialInseminations', length, true, length, true);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition>
      artificialInseminationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'artificialInseminations', 0, true, 0, true);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition>
      artificialInseminationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'artificialInseminations', 0, false, 999999, true);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition>
      artificialInseminationsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'artificialInseminations', 0, true, length, include);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition>
      artificialInseminationsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'artificialInseminations', length, include, 999999, true);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterFilterCondition>
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
}

extension BreederQuerySortBy on QueryBuilder<Breeder, Breeder, QSortBy> {
  QueryBuilder<Breeder, Breeder, QAfterSortBy> sortByBreed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.asc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> sortByBreedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.desc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> sortByIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.asc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> sortByIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.desc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> sortBySex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sex', Sort.asc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> sortBySexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sex', Sort.desc);
    });
  }
}

extension BreederQuerySortThenBy
    on QueryBuilder<Breeder, Breeder, QSortThenBy> {
  QueryBuilder<Breeder, Breeder, QAfterSortBy> thenByBreed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.asc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> thenByBreedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.desc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> thenByIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.asc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> thenByIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.desc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> thenBySex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sex', Sort.asc);
    });
  }

  QueryBuilder<Breeder, Breeder, QAfterSortBy> thenBySexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sex', Sort.desc);
    });
  }
}

extension BreederQueryWhereDistinct
    on QueryBuilder<Breeder, Breeder, QDistinct> {
  QueryBuilder<Breeder, Breeder, QDistinct> distinctByBreed(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breed', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Breeder, Breeder, QDistinct> distinctByIdentifier(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'identifier', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Breeder, Breeder, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Breeder, Breeder, QDistinct> distinctBySex(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sex', caseSensitive: caseSensitive);
    });
  }
}

extension BreederQueryProperty
    on QueryBuilder<Breeder, Breeder, QQueryProperty> {
  QueryBuilder<Breeder, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Breeder, String, QQueryOperations> breedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breed');
    });
  }

  QueryBuilder<Breeder, BreederEPD?, QQueryOperations> epdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'epd');
    });
  }

  QueryBuilder<Breeder, BreederParents?, QQueryOperations>
      fatherGrandParentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fatherGrandParents');
    });
  }

  QueryBuilder<Breeder, String, QQueryOperations> identifierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'identifier');
    });
  }

  QueryBuilder<Breeder, BreederParents?, QQueryOperations>
      motherGrandParentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motherGrandParents');
    });
  }

  QueryBuilder<Breeder, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Breeder, BreederParents?, QQueryOperations> parentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parents');
    });
  }

  QueryBuilder<Breeder, Sex, QQueryOperations> sexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sex');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const BreederParentsSchema = Schema(
  name: r'BreederParents',
  id: -8763480556843673105,
  properties: {
    r'father': PropertySchema(
      id: 0,
      name: r'father',
      type: IsarType.string,
    ),
    r'mother': PropertySchema(
      id: 1,
      name: r'mother',
      type: IsarType.string,
    )
  },
  estimateSize: _breederParentsEstimateSize,
  serialize: _breederParentsSerialize,
  deserialize: _breederParentsDeserialize,
  deserializeProp: _breederParentsDeserializeProp,
);

int _breederParentsEstimateSize(
  BreederParents object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.father;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mother;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _breederParentsSerialize(
  BreederParents object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.father);
  writer.writeString(offsets[1], object.mother);
}

BreederParents _breederParentsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BreederParents();
  object.father = reader.readStringOrNull(offsets[0]);
  object.mother = reader.readStringOrNull(offsets[1]);
  return object;
}

P _breederParentsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension BreederParentsQueryFilter
    on QueryBuilder<BreederParents, BreederParents, QFilterCondition> {
  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'father',
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'father',
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'father',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'father',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'father',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'father',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'father',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'father',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'father',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'father',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'father',
        value: '',
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      fatherIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'father',
        value: '',
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mother',
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mother',
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mother',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mother',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mother',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mother',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mother',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mother',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mother',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mother',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mother',
        value: '',
      ));
    });
  }

  QueryBuilder<BreederParents, BreederParents, QAfterFilterCondition>
      motherIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mother',
        value: '',
      ));
    });
  }
}

extension BreederParentsQueryObject
    on QueryBuilder<BreederParents, BreederParents, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const BreederEPDSchema = Schema(
  name: r'BreederEPD',
  id: -2580109998942678742,
  properties: {
    r'birthWeight': PropertySchema(
      id: 0,
      name: r'birthWeight',
      type: IsarType.double,
    ),
    r'weaningWeight': PropertySchema(
      id: 1,
      name: r'weaningWeight',
      type: IsarType.double,
    ),
    r'yearlingWeight': PropertySchema(
      id: 2,
      name: r'yearlingWeight',
      type: IsarType.double,
    )
  },
  estimateSize: _breederEPDEstimateSize,
  serialize: _breederEPDSerialize,
  deserialize: _breederEPDDeserialize,
  deserializeProp: _breederEPDDeserializeProp,
);

int _breederEPDEstimateSize(
  BreederEPD object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _breederEPDSerialize(
  BreederEPD object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.birthWeight);
  writer.writeDouble(offsets[1], object.weaningWeight);
  writer.writeDouble(offsets[2], object.yearlingWeight);
}

BreederEPD _breederEPDDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BreederEPD();
  object.birthWeight = reader.readDoubleOrNull(offsets[0]);
  object.weaningWeight = reader.readDoubleOrNull(offsets[1]);
  object.yearlingWeight = reader.readDoubleOrNull(offsets[2]);
  return object;
}

P _breederEPDDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension BreederEPDQueryFilter
    on QueryBuilder<BreederEPD, BreederEPD, QFilterCondition> {
  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      birthWeightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'birthWeight',
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      birthWeightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'birthWeight',
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      birthWeightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'birthWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      birthWeightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'birthWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      birthWeightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'birthWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      birthWeightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'birthWeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      weaningWeightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weaningWeight',
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      weaningWeightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weaningWeight',
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      weaningWeightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weaningWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      weaningWeightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weaningWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      weaningWeightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weaningWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      weaningWeightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weaningWeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      yearlingWeightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'yearlingWeight',
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      yearlingWeightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'yearlingWeight',
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      yearlingWeightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yearlingWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      yearlingWeightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yearlingWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      yearlingWeightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yearlingWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BreederEPD, BreederEPD, QAfterFilterCondition>
      yearlingWeightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yearlingWeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension BreederEPDQueryObject
    on QueryBuilder<BreederEPD, BreederEPD, QFilterCondition> {}
