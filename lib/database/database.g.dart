// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BovinesTable extends Bovines with TableInfo<$BovinesTable, Bovine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BovinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumnWithTypeConverter<Sex, int> sex =
      GeneratedColumn<int>('sex', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Sex>($BovinesTable.$convertersex);
  @override
  List<GeneratedColumn> get $columns => [id, name, sex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bovines';
  @override
  VerificationContext validateIntegrity(Insertable<Bovine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_sexMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bovine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bovine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sex: $BovinesTable.$convertersex.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sex'])!),
    );
  }

  @override
  $BovinesTable createAlias(String alias) {
    return $BovinesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Sex, int, int> $convertersex =
      const EnumIndexConverter<Sex>(Sex.values);
}

class Bovine extends DataClass implements Insertable<Bovine> {
  final int id;
  final String name;
  final Sex sex;
  const Bovine({required this.id, required this.name, required this.sex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['sex'] = Variable<int>($BovinesTable.$convertersex.toSql(sex));
    }
    return map;
  }

  BovinesCompanion toCompanion(bool nullToAbsent) {
    return BovinesCompanion(
      id: Value(id),
      name: Value(name),
      sex: Value(sex),
    );
  }

  factory Bovine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bovine(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sex: $BovinesTable.$convertersex
          .fromJson(serializer.fromJson<int>(json['sex'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'sex': serializer.toJson<int>($BovinesTable.$convertersex.toJson(sex)),
    };
  }

  Bovine copyWith({int? id, String? name, Sex? sex}) => Bovine(
        id: id ?? this.id,
        name: name ?? this.name,
        sex: sex ?? this.sex,
      );
  Bovine copyWithCompanion(BovinesCompanion data) {
    return Bovine(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sex: data.sex.present ? data.sex.value : this.sex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bovine(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sex: $sex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bovine &&
          other.id == this.id &&
          other.name == this.name &&
          other.sex == this.sex);
}

class BovinesCompanion extends UpdateCompanion<Bovine> {
  final Value<int> id;
  final Value<String> name;
  final Value<Sex> sex;
  const BovinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sex = const Value.absent(),
  });
  BovinesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required Sex sex,
  })  : name = Value(name),
        sex = Value(sex);
  static Insertable<Bovine> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? sex,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sex != null) 'sex': sex,
    });
  }

  BovinesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<Sex>? sex}) {
    return BovinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sex: sex ?? this.sex,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sex.present) {
      map['sex'] = Variable<int>($BovinesTable.$convertersex.toSql(sex.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BovinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sex: $sex')
          ..write(')'))
        .toString();
  }
}

class $BirthsTable extends Births with TableInfo<$BirthsTable, Birth> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BirthsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      check: () => ComparableExpr(weight).isBiggerThan(const Constant(0.0)),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _bcsMeta = const VerificationMeta('bcs');
  @override
  late final GeneratedColumnWithTypeConverter<BodyConditionScore, int> bcs =
      GeneratedColumn<int>('bcs', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<BodyConditionScore>($BirthsTable.$converterbcs);
  static const VerificationMeta _bovineMeta = const VerificationMeta('bovine');
  @override
  late final GeneratedColumn<int> bovine = GeneratedColumn<int>(
      'bovine', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovines (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, date, weight, bcs, bovine];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'births';
  @override
  VerificationContext validateIntegrity(Insertable<Birth> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    context.handle(_bcsMeta, const VerificationResult.success());
    if (data.containsKey('bovine')) {
      context.handle(_bovineMeta,
          bovine.isAcceptableOrUnknown(data['bovine']!, _bovineMeta));
    } else if (isInserting) {
      context.missing(_bovineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Birth map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Birth(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      bcs: $BirthsTable.$converterbcs.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bcs'])!),
      bovine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovine'])!,
    );
  }

  @override
  $BirthsTable createAlias(String alias) {
    return $BirthsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BodyConditionScore, int, int> $converterbcs =
      const EnumIndexConverter<BodyConditionScore>(BodyConditionScore.values);
}

class Birth extends DataClass implements Insertable<Birth> {
  final int id;
  final DateTime date;
  final double? weight;
  final BodyConditionScore bcs;
  final int bovine;
  const Birth(
      {required this.id,
      required this.date,
      this.weight,
      required this.bcs,
      required this.bovine});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    {
      map['bcs'] = Variable<int>($BirthsTable.$converterbcs.toSql(bcs));
    }
    map['bovine'] = Variable<int>(bovine);
    return map;
  }

  BirthsCompanion toCompanion(bool nullToAbsent) {
    return BirthsCompanion(
      id: Value(id),
      date: Value(date),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      bcs: Value(bcs),
      bovine: Value(bovine),
    );
  }

  factory Birth.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Birth(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double?>(json['weight']),
      bcs: $BirthsTable.$converterbcs
          .fromJson(serializer.fromJson<int>(json['bcs'])),
      bovine: serializer.fromJson<int>(json['bovine']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double?>(weight),
      'bcs': serializer.toJson<int>($BirthsTable.$converterbcs.toJson(bcs)),
      'bovine': serializer.toJson<int>(bovine),
    };
  }

  Birth copyWith(
          {int? id,
          DateTime? date,
          Value<double?> weight = const Value.absent(),
          BodyConditionScore? bcs,
          int? bovine}) =>
      Birth(
        id: id ?? this.id,
        date: date ?? this.date,
        weight: weight.present ? weight.value : this.weight,
        bcs: bcs ?? this.bcs,
        bovine: bovine ?? this.bovine,
      );
  Birth copyWithCompanion(BirthsCompanion data) {
    return Birth(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
      bcs: data.bcs.present ? data.bcs.value : this.bcs,
      bovine: data.bovine.present ? data.bovine.value : this.bovine,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Birth(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('bcs: $bcs, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, weight, bcs, bovine);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Birth &&
          other.id == this.id &&
          other.date == this.date &&
          other.weight == this.weight &&
          other.bcs == this.bcs &&
          other.bovine == this.bovine);
}

class BirthsCompanion extends UpdateCompanion<Birth> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<double?> weight;
  final Value<BodyConditionScore> bcs;
  final Value<int> bovine;
  const BirthsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.bcs = const Value.absent(),
    this.bovine = const Value.absent(),
  });
  BirthsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.weight = const Value.absent(),
    required BodyConditionScore bcs,
    required int bovine,
  })  : date = Value(date),
        bcs = Value(bcs),
        bovine = Value(bovine);
  static Insertable<Birth> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<double>? weight,
    Expression<int>? bcs,
    Expression<int>? bovine,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
      if (bcs != null) 'bcs': bcs,
      if (bovine != null) 'bovine': bovine,
    });
  }

  BirthsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<double?>? weight,
      Value<BodyConditionScore>? bcs,
      Value<int>? bovine}) {
    return BirthsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      bcs: bcs ?? this.bcs,
      bovine: bovine ?? this.bovine,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (bcs.present) {
      map['bcs'] = Variable<int>($BirthsTable.$converterbcs.toSql(bcs.value));
    }
    if (bovine.present) {
      map['bovine'] = Variable<int>(bovine.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BirthsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('bcs: $bcs, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }
}

class $NewbornFeedingsTable extends NewbornFeedings
    with TableInfo<$NewbornFeedingsTable, NewbornFeeding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewbornFeedingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<double> volume = GeneratedColumn<double>(
      'volume', aliasedName, false,
      check: () => ComparableExpr(volume).isBiggerThan(const Constant(0.0)),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _bovineMeta = const VerificationMeta('bovine');
  @override
  late final GeneratedColumn<int> bovine = GeneratedColumn<int>(
      'bovine', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovines (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, date, volume, bovine];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'newborn_feedings';
  @override
  VerificationContext validateIntegrity(Insertable<NewbornFeeding> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('volume')) {
      context.handle(_volumeMeta,
          volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta));
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    if (data.containsKey('bovine')) {
      context.handle(_bovineMeta,
          bovine.isAcceptableOrUnknown(data['bovine']!, _bovineMeta));
    } else if (isInserting) {
      context.missing(_bovineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewbornFeeding map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewbornFeeding(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      volume: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}volume'])!,
      bovine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovine'])!,
    );
  }

  @override
  $NewbornFeedingsTable createAlias(String alias) {
    return $NewbornFeedingsTable(attachedDatabase, alias);
  }
}

class NewbornFeeding extends DataClass implements Insertable<NewbornFeeding> {
  final int id;
  final DateTime date;
  final double volume;
  final int bovine;
  const NewbornFeeding(
      {required this.id,
      required this.date,
      required this.volume,
      required this.bovine});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['volume'] = Variable<double>(volume);
    map['bovine'] = Variable<int>(bovine);
    return map;
  }

  NewbornFeedingsCompanion toCompanion(bool nullToAbsent) {
    return NewbornFeedingsCompanion(
      id: Value(id),
      date: Value(date),
      volume: Value(volume),
      bovine: Value(bovine),
    );
  }

  factory NewbornFeeding.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewbornFeeding(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      volume: serializer.fromJson<double>(json['volume']),
      bovine: serializer.fromJson<int>(json['bovine']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'volume': serializer.toJson<double>(volume),
      'bovine': serializer.toJson<int>(bovine),
    };
  }

  NewbornFeeding copyWith(
          {int? id, DateTime? date, double? volume, int? bovine}) =>
      NewbornFeeding(
        id: id ?? this.id,
        date: date ?? this.date,
        volume: volume ?? this.volume,
        bovine: bovine ?? this.bovine,
      );
  NewbornFeeding copyWithCompanion(NewbornFeedingsCompanion data) {
    return NewbornFeeding(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      volume: data.volume.present ? data.volume.value : this.volume,
      bovine: data.bovine.present ? data.bovine.value : this.bovine,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NewbornFeeding(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('volume: $volume, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, volume, bovine);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewbornFeeding &&
          other.id == this.id &&
          other.date == this.date &&
          other.volume == this.volume &&
          other.bovine == this.bovine);
}

class NewbornFeedingsCompanion extends UpdateCompanion<NewbornFeeding> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<double> volume;
  final Value<int> bovine;
  const NewbornFeedingsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.volume = const Value.absent(),
    this.bovine = const Value.absent(),
  });
  NewbornFeedingsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required double volume,
    required int bovine,
  })  : date = Value(date),
        volume = Value(volume),
        bovine = Value(bovine);
  static Insertable<NewbornFeeding> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<double>? volume,
    Expression<int>? bovine,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (volume != null) 'volume': volume,
      if (bovine != null) 'bovine': bovine,
    });
  }

  NewbornFeedingsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<double>? volume,
      Value<int>? bovine}) {
    return NewbornFeedingsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      volume: volume ?? this.volume,
      bovine: bovine ?? this.bovine,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (volume.present) {
      map['volume'] = Variable<double>(volume.value);
    }
    if (bovine.present) {
      map['bovine'] = Variable<int>(bovine.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewbornFeedingsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('volume: $volume, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }
}

class $WeaningsTable extends Weanings with TableInfo<$WeaningsTable, Weaning> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeaningsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _preWeaningStartingDateMeta =
      const VerificationMeta('preWeaningStartingDate');
  @override
  late final GeneratedColumn<DateTime> preWeaningStartingDate =
      GeneratedColumn<DateTime>('pre_weaning_starting_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _weaningDateMeta =
      const VerificationMeta('weaningDate');
  @override
  late final GeneratedColumn<DateTime> weaningDate = GeneratedColumn<DateTime>(
      'weaning_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      check: () => ComparableExpr(weight).isBiggerThan(const Constant(0.0)),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _bovineMeta = const VerificationMeta('bovine');
  @override
  late final GeneratedColumn<int> bovine = GeneratedColumn<int>(
      'bovine', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovines (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, preWeaningStartingDate, weaningDate, weight, bovine];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weanings';
  @override
  VerificationContext validateIntegrity(Insertable<Weaning> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pre_weaning_starting_date')) {
      context.handle(
          _preWeaningStartingDateMeta,
          preWeaningStartingDate.isAcceptableOrUnknown(
              data['pre_weaning_starting_date']!, _preWeaningStartingDateMeta));
    } else if (isInserting) {
      context.missing(_preWeaningStartingDateMeta);
    }
    if (data.containsKey('weaning_date')) {
      context.handle(
          _weaningDateMeta,
          weaningDate.isAcceptableOrUnknown(
              data['weaning_date']!, _weaningDateMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('bovine')) {
      context.handle(_bovineMeta,
          bovine.isAcceptableOrUnknown(data['bovine']!, _bovineMeta));
    } else if (isInserting) {
      context.missing(_bovineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Weaning map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Weaning(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      preWeaningStartingDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}pre_weaning_starting_date'])!,
      weaningDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}weaning_date']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      bovine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovine'])!,
    );
  }

  @override
  $WeaningsTable createAlias(String alias) {
    return $WeaningsTable(attachedDatabase, alias);
  }
}

class Weaning extends DataClass implements Insertable<Weaning> {
  final int id;
  final DateTime preWeaningStartingDate;
  final DateTime? weaningDate;
  final double? weight;
  final int bovine;
  const Weaning(
      {required this.id,
      required this.preWeaningStartingDate,
      this.weaningDate,
      this.weight,
      required this.bovine});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pre_weaning_starting_date'] =
        Variable<DateTime>(preWeaningStartingDate);
    if (!nullToAbsent || weaningDate != null) {
      map['weaning_date'] = Variable<DateTime>(weaningDate);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    map['bovine'] = Variable<int>(bovine);
    return map;
  }

  WeaningsCompanion toCompanion(bool nullToAbsent) {
    return WeaningsCompanion(
      id: Value(id),
      preWeaningStartingDate: Value(preWeaningStartingDate),
      weaningDate: weaningDate == null && nullToAbsent
          ? const Value.absent()
          : Value(weaningDate),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      bovine: Value(bovine),
    );
  }

  factory Weaning.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Weaning(
      id: serializer.fromJson<int>(json['id']),
      preWeaningStartingDate:
          serializer.fromJson<DateTime>(json['preWeaningStartingDate']),
      weaningDate: serializer.fromJson<DateTime?>(json['weaningDate']),
      weight: serializer.fromJson<double?>(json['weight']),
      bovine: serializer.fromJson<int>(json['bovine']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'preWeaningStartingDate':
          serializer.toJson<DateTime>(preWeaningStartingDate),
      'weaningDate': serializer.toJson<DateTime?>(weaningDate),
      'weight': serializer.toJson<double?>(weight),
      'bovine': serializer.toJson<int>(bovine),
    };
  }

  Weaning copyWith(
          {int? id,
          DateTime? preWeaningStartingDate,
          Value<DateTime?> weaningDate = const Value.absent(),
          Value<double?> weight = const Value.absent(),
          int? bovine}) =>
      Weaning(
        id: id ?? this.id,
        preWeaningStartingDate:
            preWeaningStartingDate ?? this.preWeaningStartingDate,
        weaningDate: weaningDate.present ? weaningDate.value : this.weaningDate,
        weight: weight.present ? weight.value : this.weight,
        bovine: bovine ?? this.bovine,
      );
  Weaning copyWithCompanion(WeaningsCompanion data) {
    return Weaning(
      id: data.id.present ? data.id.value : this.id,
      preWeaningStartingDate: data.preWeaningStartingDate.present
          ? data.preWeaningStartingDate.value
          : this.preWeaningStartingDate,
      weaningDate:
          data.weaningDate.present ? data.weaningDate.value : this.weaningDate,
      weight: data.weight.present ? data.weight.value : this.weight,
      bovine: data.bovine.present ? data.bovine.value : this.bovine,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Weaning(')
          ..write('id: $id, ')
          ..write('preWeaningStartingDate: $preWeaningStartingDate, ')
          ..write('weaningDate: $weaningDate, ')
          ..write('weight: $weight, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, preWeaningStartingDate, weaningDate, weight, bovine);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Weaning &&
          other.id == this.id &&
          other.preWeaningStartingDate == this.preWeaningStartingDate &&
          other.weaningDate == this.weaningDate &&
          other.weight == this.weight &&
          other.bovine == this.bovine);
}

class WeaningsCompanion extends UpdateCompanion<Weaning> {
  final Value<int> id;
  final Value<DateTime> preWeaningStartingDate;
  final Value<DateTime?> weaningDate;
  final Value<double?> weight;
  final Value<int> bovine;
  const WeaningsCompanion({
    this.id = const Value.absent(),
    this.preWeaningStartingDate = const Value.absent(),
    this.weaningDate = const Value.absent(),
    this.weight = const Value.absent(),
    this.bovine = const Value.absent(),
  });
  WeaningsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime preWeaningStartingDate,
    this.weaningDate = const Value.absent(),
    this.weight = const Value.absent(),
    required int bovine,
  })  : preWeaningStartingDate = Value(preWeaningStartingDate),
        bovine = Value(bovine);
  static Insertable<Weaning> custom({
    Expression<int>? id,
    Expression<DateTime>? preWeaningStartingDate,
    Expression<DateTime>? weaningDate,
    Expression<double>? weight,
    Expression<int>? bovine,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (preWeaningStartingDate != null)
        'pre_weaning_starting_date': preWeaningStartingDate,
      if (weaningDate != null) 'weaning_date': weaningDate,
      if (weight != null) 'weight': weight,
      if (bovine != null) 'bovine': bovine,
    });
  }

  WeaningsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? preWeaningStartingDate,
      Value<DateTime?>? weaningDate,
      Value<double?>? weight,
      Value<int>? bovine}) {
    return WeaningsCompanion(
      id: id ?? this.id,
      preWeaningStartingDate:
          preWeaningStartingDate ?? this.preWeaningStartingDate,
      weaningDate: weaningDate ?? this.weaningDate,
      weight: weight ?? this.weight,
      bovine: bovine ?? this.bovine,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (preWeaningStartingDate.present) {
      map['pre_weaning_starting_date'] =
          Variable<DateTime>(preWeaningStartingDate.value);
    }
    if (weaningDate.present) {
      map['weaning_date'] = Variable<DateTime>(weaningDate.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (bovine.present) {
      map['bovine'] = Variable<int>(bovine.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeaningsCompanion(')
          ..write('id: $id, ')
          ..write('preWeaningStartingDate: $preWeaningStartingDate, ')
          ..write('weaningDate: $weaningDate, ')
          ..write('weight: $weight, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }
}

class $ProductionsTable extends Productions
    with TableInfo<$ProductionsTable, Production> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<double> volume = GeneratedColumn<double>(
      'volume', aliasedName, false,
      check: () => ComparableExpr(volume).isBiggerThan(const Constant(0.0)),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _dayPeriodMeta =
      const VerificationMeta('dayPeriod');
  @override
  late final GeneratedColumnWithTypeConverter<ProductionDayPeriod, int>
      dayPeriod = GeneratedColumn<int>('day_period', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ProductionDayPeriod>(
              $ProductionsTable.$converterdayPeriod);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _discardMeta =
      const VerificationMeta('discard');
  @override
  late final GeneratedColumn<bool> discard = GeneratedColumn<bool>(
      'discard', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("discard" IN (0, 1))'));
  static const VerificationMeta _observationMeta =
      const VerificationMeta('observation');
  @override
  late final GeneratedColumn<String> observation = GeneratedColumn<String>(
      'observation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cowMeta = const VerificationMeta('cow');
  @override
  late final GeneratedColumn<int> cow = GeneratedColumn<int>(
      'cow', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovines (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, volume, dayPeriod, date, discard, observation, cow];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'productions';
  @override
  VerificationContext validateIntegrity(Insertable<Production> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('volume')) {
      context.handle(_volumeMeta,
          volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta));
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    context.handle(_dayPeriodMeta, const VerificationResult.success());
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('discard')) {
      context.handle(_discardMeta,
          discard.isAcceptableOrUnknown(data['discard']!, _discardMeta));
    } else if (isInserting) {
      context.missing(_discardMeta);
    }
    if (data.containsKey('observation')) {
      context.handle(
          _observationMeta,
          observation.isAcceptableOrUnknown(
              data['observation']!, _observationMeta));
    }
    if (data.containsKey('cow')) {
      context.handle(
          _cowMeta, cow.isAcceptableOrUnknown(data['cow']!, _cowMeta));
    } else if (isInserting) {
      context.missing(_cowMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Production map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Production(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      volume: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}volume'])!,
      dayPeriod: $ProductionsTable.$converterdayPeriod.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_period'])!),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      discard: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}discard'])!,
      observation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observation']),
      cow: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cow'])!,
    );
  }

  @override
  $ProductionsTable createAlias(String alias) {
    return $ProductionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ProductionDayPeriod, int, int> $converterdayPeriod =
      const EnumIndexConverter<ProductionDayPeriod>(ProductionDayPeriod.values);
}

class Production extends DataClass implements Insertable<Production> {
  final int id;
  final double volume;
  final ProductionDayPeriod dayPeriod;
  final DateTime date;
  final bool discard;
  final String? observation;
  final int cow;
  const Production(
      {required this.id,
      required this.volume,
      required this.dayPeriod,
      required this.date,
      required this.discard,
      this.observation,
      required this.cow});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['volume'] = Variable<double>(volume);
    {
      map['day_period'] =
          Variable<int>($ProductionsTable.$converterdayPeriod.toSql(dayPeriod));
    }
    map['date'] = Variable<DateTime>(date);
    map['discard'] = Variable<bool>(discard);
    if (!nullToAbsent || observation != null) {
      map['observation'] = Variable<String>(observation);
    }
    map['cow'] = Variable<int>(cow);
    return map;
  }

  ProductionsCompanion toCompanion(bool nullToAbsent) {
    return ProductionsCompanion(
      id: Value(id),
      volume: Value(volume),
      dayPeriod: Value(dayPeriod),
      date: Value(date),
      discard: Value(discard),
      observation: observation == null && nullToAbsent
          ? const Value.absent()
          : Value(observation),
      cow: Value(cow),
    );
  }

  factory Production.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Production(
      id: serializer.fromJson<int>(json['id']),
      volume: serializer.fromJson<double>(json['volume']),
      dayPeriod: $ProductionsTable.$converterdayPeriod
          .fromJson(serializer.fromJson<int>(json['dayPeriod'])),
      date: serializer.fromJson<DateTime>(json['date']),
      discard: serializer.fromJson<bool>(json['discard']),
      observation: serializer.fromJson<String?>(json['observation']),
      cow: serializer.fromJson<int>(json['cow']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'volume': serializer.toJson<double>(volume),
      'dayPeriod': serializer
          .toJson<int>($ProductionsTable.$converterdayPeriod.toJson(dayPeriod)),
      'date': serializer.toJson<DateTime>(date),
      'discard': serializer.toJson<bool>(discard),
      'observation': serializer.toJson<String?>(observation),
      'cow': serializer.toJson<int>(cow),
    };
  }

  Production copyWith(
          {int? id,
          double? volume,
          ProductionDayPeriod? dayPeriod,
          DateTime? date,
          bool? discard,
          Value<String?> observation = const Value.absent(),
          int? cow}) =>
      Production(
        id: id ?? this.id,
        volume: volume ?? this.volume,
        dayPeriod: dayPeriod ?? this.dayPeriod,
        date: date ?? this.date,
        discard: discard ?? this.discard,
        observation: observation.present ? observation.value : this.observation,
        cow: cow ?? this.cow,
      );
  Production copyWithCompanion(ProductionsCompanion data) {
    return Production(
      id: data.id.present ? data.id.value : this.id,
      volume: data.volume.present ? data.volume.value : this.volume,
      dayPeriod: data.dayPeriod.present ? data.dayPeriod.value : this.dayPeriod,
      date: data.date.present ? data.date.value : this.date,
      discard: data.discard.present ? data.discard.value : this.discard,
      observation:
          data.observation.present ? data.observation.value : this.observation,
      cow: data.cow.present ? data.cow.value : this.cow,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Production(')
          ..write('id: $id, ')
          ..write('volume: $volume, ')
          ..write('dayPeriod: $dayPeriod, ')
          ..write('date: $date, ')
          ..write('discard: $discard, ')
          ..write('observation: $observation, ')
          ..write('cow: $cow')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, volume, dayPeriod, date, discard, observation, cow);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Production &&
          other.id == this.id &&
          other.volume == this.volume &&
          other.dayPeriod == this.dayPeriod &&
          other.date == this.date &&
          other.discard == this.discard &&
          other.observation == this.observation &&
          other.cow == this.cow);
}

class ProductionsCompanion extends UpdateCompanion<Production> {
  final Value<int> id;
  final Value<double> volume;
  final Value<ProductionDayPeriod> dayPeriod;
  final Value<DateTime> date;
  final Value<bool> discard;
  final Value<String?> observation;
  final Value<int> cow;
  const ProductionsCompanion({
    this.id = const Value.absent(),
    this.volume = const Value.absent(),
    this.dayPeriod = const Value.absent(),
    this.date = const Value.absent(),
    this.discard = const Value.absent(),
    this.observation = const Value.absent(),
    this.cow = const Value.absent(),
  });
  ProductionsCompanion.insert({
    this.id = const Value.absent(),
    required double volume,
    required ProductionDayPeriod dayPeriod,
    required DateTime date,
    required bool discard,
    this.observation = const Value.absent(),
    required int cow,
  })  : volume = Value(volume),
        dayPeriod = Value(dayPeriod),
        date = Value(date),
        discard = Value(discard),
        cow = Value(cow);
  static Insertable<Production> custom({
    Expression<int>? id,
    Expression<double>? volume,
    Expression<int>? dayPeriod,
    Expression<DateTime>? date,
    Expression<bool>? discard,
    Expression<String>? observation,
    Expression<int>? cow,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (volume != null) 'volume': volume,
      if (dayPeriod != null) 'day_period': dayPeriod,
      if (date != null) 'date': date,
      if (discard != null) 'discard': discard,
      if (observation != null) 'observation': observation,
      if (cow != null) 'cow': cow,
    });
  }

  ProductionsCompanion copyWith(
      {Value<int>? id,
      Value<double>? volume,
      Value<ProductionDayPeriod>? dayPeriod,
      Value<DateTime>? date,
      Value<bool>? discard,
      Value<String?>? observation,
      Value<int>? cow}) {
    return ProductionsCompanion(
      id: id ?? this.id,
      volume: volume ?? this.volume,
      dayPeriod: dayPeriod ?? this.dayPeriod,
      date: date ?? this.date,
      discard: discard ?? this.discard,
      observation: observation ?? this.observation,
      cow: cow ?? this.cow,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (volume.present) {
      map['volume'] = Variable<double>(volume.value);
    }
    if (dayPeriod.present) {
      map['day_period'] = Variable<int>(
          $ProductionsTable.$converterdayPeriod.toSql(dayPeriod.value));
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (discard.present) {
      map['discard'] = Variable<bool>(discard.value);
    }
    if (observation.present) {
      map['observation'] = Variable<String>(observation.value);
    }
    if (cow.present) {
      map['cow'] = Variable<int>(cow.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductionsCompanion(')
          ..write('id: $id, ')
          ..write('volume: $volume, ')
          ..write('dayPeriod: $dayPeriod, ')
          ..write('date: $date, ')
          ..write('discard: $discard, ')
          ..write('observation: $observation, ')
          ..write('cow: $cow')
          ..write(')'))
        .toString();
  }
}

class $TreatmentsTable extends Treatments
    with TableInfo<$TreatmentsTable, Treatment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreatmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _medicineMeta =
      const VerificationMeta('medicine');
  @override
  late final GeneratedColumn<String> medicine = GeneratedColumn<String>(
      'medicine', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startingDateMeta =
      const VerificationMeta('startingDate');
  @override
  late final GeneratedColumn<DateTime> startingDate = GeneratedColumn<DateTime>(
      'starting_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endingDateMeta =
      const VerificationMeta('endingDate');
  @override
  late final GeneratedColumn<DateTime> endingDate = GeneratedColumn<DateTime>(
      'ending_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationInDaysMeta =
      const VerificationMeta('durationInDays');
  @override
  late final GeneratedColumn<int> durationInDays = GeneratedColumn<int>(
      'duration_in_days', aliasedName, false,
      check: () =>
          ComparableExpr(durationInDays).isBiggerThan(const Constant(0)),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _dryingMeta = const VerificationMeta('drying');
  @override
  late final GeneratedColumn<bool> drying = GeneratedColumn<bool>(
      'drying', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("drying" IN (0, 1))'));
  static const VerificationMeta _bovineMeta = const VerificationMeta('bovine');
  @override
  late final GeneratedColumn<int> bovine = GeneratedColumn<int>(
      'bovine', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovines (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        reason,
        medicine,
        startingDate,
        endingDate,
        durationInDays,
        drying,
        bovine
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'treatments';
  @override
  VerificationContext validateIntegrity(Insertable<Treatment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('medicine')) {
      context.handle(_medicineMeta,
          medicine.isAcceptableOrUnknown(data['medicine']!, _medicineMeta));
    } else if (isInserting) {
      context.missing(_medicineMeta);
    }
    if (data.containsKey('starting_date')) {
      context.handle(
          _startingDateMeta,
          startingDate.isAcceptableOrUnknown(
              data['starting_date']!, _startingDateMeta));
    } else if (isInserting) {
      context.missing(_startingDateMeta);
    }
    if (data.containsKey('ending_date')) {
      context.handle(
          _endingDateMeta,
          endingDate.isAcceptableOrUnknown(
              data['ending_date']!, _endingDateMeta));
    } else if (isInserting) {
      context.missing(_endingDateMeta);
    }
    if (data.containsKey('duration_in_days')) {
      context.handle(
          _durationInDaysMeta,
          durationInDays.isAcceptableOrUnknown(
              data['duration_in_days']!, _durationInDaysMeta));
    } else if (isInserting) {
      context.missing(_durationInDaysMeta);
    }
    if (data.containsKey('drying')) {
      context.handle(_dryingMeta,
          drying.isAcceptableOrUnknown(data['drying']!, _dryingMeta));
    } else if (isInserting) {
      context.missing(_dryingMeta);
    }
    if (data.containsKey('bovine')) {
      context.handle(_bovineMeta,
          bovine.isAcceptableOrUnknown(data['bovine']!, _bovineMeta));
    } else if (isInserting) {
      context.missing(_bovineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Treatment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Treatment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason'])!,
      medicine: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicine'])!,
      startingDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}starting_date'])!,
      endingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ending_date'])!,
      durationInDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_in_days'])!,
      drying: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}drying'])!,
      bovine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovine'])!,
    );
  }

  @override
  $TreatmentsTable createAlias(String alias) {
    return $TreatmentsTable(attachedDatabase, alias);
  }
}

class Treatment extends DataClass implements Insertable<Treatment> {
  final int id;
  final String reason;
  final String medicine;
  final DateTime startingDate;
  final DateTime endingDate;
  final int durationInDays;
  final bool drying;
  final int bovine;
  const Treatment(
      {required this.id,
      required this.reason,
      required this.medicine,
      required this.startingDate,
      required this.endingDate,
      required this.durationInDays,
      required this.drying,
      required this.bovine});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reason'] = Variable<String>(reason);
    map['medicine'] = Variable<String>(medicine);
    map['starting_date'] = Variable<DateTime>(startingDate);
    map['ending_date'] = Variable<DateTime>(endingDate);
    map['duration_in_days'] = Variable<int>(durationInDays);
    map['drying'] = Variable<bool>(drying);
    map['bovine'] = Variable<int>(bovine);
    return map;
  }

  TreatmentsCompanion toCompanion(bool nullToAbsent) {
    return TreatmentsCompanion(
      id: Value(id),
      reason: Value(reason),
      medicine: Value(medicine),
      startingDate: Value(startingDate),
      endingDate: Value(endingDate),
      durationInDays: Value(durationInDays),
      drying: Value(drying),
      bovine: Value(bovine),
    );
  }

  factory Treatment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Treatment(
      id: serializer.fromJson<int>(json['id']),
      reason: serializer.fromJson<String>(json['reason']),
      medicine: serializer.fromJson<String>(json['medicine']),
      startingDate: serializer.fromJson<DateTime>(json['startingDate']),
      endingDate: serializer.fromJson<DateTime>(json['endingDate']),
      durationInDays: serializer.fromJson<int>(json['durationInDays']),
      drying: serializer.fromJson<bool>(json['drying']),
      bovine: serializer.fromJson<int>(json['bovine']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reason': serializer.toJson<String>(reason),
      'medicine': serializer.toJson<String>(medicine),
      'startingDate': serializer.toJson<DateTime>(startingDate),
      'endingDate': serializer.toJson<DateTime>(endingDate),
      'durationInDays': serializer.toJson<int>(durationInDays),
      'drying': serializer.toJson<bool>(drying),
      'bovine': serializer.toJson<int>(bovine),
    };
  }

  Treatment copyWith(
          {int? id,
          String? reason,
          String? medicine,
          DateTime? startingDate,
          DateTime? endingDate,
          int? durationInDays,
          bool? drying,
          int? bovine}) =>
      Treatment(
        id: id ?? this.id,
        reason: reason ?? this.reason,
        medicine: medicine ?? this.medicine,
        startingDate: startingDate ?? this.startingDate,
        endingDate: endingDate ?? this.endingDate,
        durationInDays: durationInDays ?? this.durationInDays,
        drying: drying ?? this.drying,
        bovine: bovine ?? this.bovine,
      );
  Treatment copyWithCompanion(TreatmentsCompanion data) {
    return Treatment(
      id: data.id.present ? data.id.value : this.id,
      reason: data.reason.present ? data.reason.value : this.reason,
      medicine: data.medicine.present ? data.medicine.value : this.medicine,
      startingDate: data.startingDate.present
          ? data.startingDate.value
          : this.startingDate,
      endingDate:
          data.endingDate.present ? data.endingDate.value : this.endingDate,
      durationInDays: data.durationInDays.present
          ? data.durationInDays.value
          : this.durationInDays,
      drying: data.drying.present ? data.drying.value : this.drying,
      bovine: data.bovine.present ? data.bovine.value : this.bovine,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Treatment(')
          ..write('id: $id, ')
          ..write('reason: $reason, ')
          ..write('medicine: $medicine, ')
          ..write('startingDate: $startingDate, ')
          ..write('endingDate: $endingDate, ')
          ..write('durationInDays: $durationInDays, ')
          ..write('drying: $drying, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reason, medicine, startingDate,
      endingDate, durationInDays, drying, bovine);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Treatment &&
          other.id == this.id &&
          other.reason == this.reason &&
          other.medicine == this.medicine &&
          other.startingDate == this.startingDate &&
          other.endingDate == this.endingDate &&
          other.durationInDays == this.durationInDays &&
          other.drying == this.drying &&
          other.bovine == this.bovine);
}

class TreatmentsCompanion extends UpdateCompanion<Treatment> {
  final Value<int> id;
  final Value<String> reason;
  final Value<String> medicine;
  final Value<DateTime> startingDate;
  final Value<DateTime> endingDate;
  final Value<int> durationInDays;
  final Value<bool> drying;
  final Value<int> bovine;
  const TreatmentsCompanion({
    this.id = const Value.absent(),
    this.reason = const Value.absent(),
    this.medicine = const Value.absent(),
    this.startingDate = const Value.absent(),
    this.endingDate = const Value.absent(),
    this.durationInDays = const Value.absent(),
    this.drying = const Value.absent(),
    this.bovine = const Value.absent(),
  });
  TreatmentsCompanion.insert({
    this.id = const Value.absent(),
    required String reason,
    required String medicine,
    required DateTime startingDate,
    required DateTime endingDate,
    required int durationInDays,
    required bool drying,
    required int bovine,
  })  : reason = Value(reason),
        medicine = Value(medicine),
        startingDate = Value(startingDate),
        endingDate = Value(endingDate),
        durationInDays = Value(durationInDays),
        drying = Value(drying),
        bovine = Value(bovine);
  static Insertable<Treatment> custom({
    Expression<int>? id,
    Expression<String>? reason,
    Expression<String>? medicine,
    Expression<DateTime>? startingDate,
    Expression<DateTime>? endingDate,
    Expression<int>? durationInDays,
    Expression<bool>? drying,
    Expression<int>? bovine,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reason != null) 'reason': reason,
      if (medicine != null) 'medicine': medicine,
      if (startingDate != null) 'starting_date': startingDate,
      if (endingDate != null) 'ending_date': endingDate,
      if (durationInDays != null) 'duration_in_days': durationInDays,
      if (drying != null) 'drying': drying,
      if (bovine != null) 'bovine': bovine,
    });
  }

  TreatmentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? reason,
      Value<String>? medicine,
      Value<DateTime>? startingDate,
      Value<DateTime>? endingDate,
      Value<int>? durationInDays,
      Value<bool>? drying,
      Value<int>? bovine}) {
    return TreatmentsCompanion(
      id: id ?? this.id,
      reason: reason ?? this.reason,
      medicine: medicine ?? this.medicine,
      startingDate: startingDate ?? this.startingDate,
      endingDate: endingDate ?? this.endingDate,
      durationInDays: durationInDays ?? this.durationInDays,
      drying: drying ?? this.drying,
      bovine: bovine ?? this.bovine,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (medicine.present) {
      map['medicine'] = Variable<String>(medicine.value);
    }
    if (startingDate.present) {
      map['starting_date'] = Variable<DateTime>(startingDate.value);
    }
    if (endingDate.present) {
      map['ending_date'] = Variable<DateTime>(endingDate.value);
    }
    if (durationInDays.present) {
      map['duration_in_days'] = Variable<int>(durationInDays.value);
    }
    if (drying.present) {
      map['drying'] = Variable<bool>(drying.value);
    }
    if (bovine.present) {
      map['bovine'] = Variable<int>(bovine.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentsCompanion(')
          ..write('id: $id, ')
          ..write('reason: $reason, ')
          ..write('medicine: $medicine, ')
          ..write('startingDate: $startingDate, ')
          ..write('endingDate: $endingDate, ')
          ..write('durationInDays: $durationInDays, ')
          ..write('drying: $drying, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }
}

class $SemensTable extends Semens with TableInfo<$SemensTable, Semen> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SemensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _semenNumberMeta =
      const VerificationMeta('semenNumber');
  @override
  late final GeneratedColumn<String> semenNumber =
      GeneratedColumn<String>('semen_number', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _bullNameMeta =
      const VerificationMeta('bullName');
  @override
  late final GeneratedColumn<String> bullName =
      GeneratedColumn<String>('bull_name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [semenNumber, bullName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'semens';
  @override
  VerificationContext validateIntegrity(Insertable<Semen> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('semen_number')) {
      context.handle(
          _semenNumberMeta,
          semenNumber.isAcceptableOrUnknown(
              data['semen_number']!, _semenNumberMeta));
    } else if (isInserting) {
      context.missing(_semenNumberMeta);
    }
    if (data.containsKey('bull_name')) {
      context.handle(_bullNameMeta,
          bullName.isAcceptableOrUnknown(data['bull_name']!, _bullNameMeta));
    } else if (isInserting) {
      context.missing(_bullNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {semenNumber};
  @override
  Semen map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Semen(
      semenNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}semen_number'])!,
      bullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bull_name'])!,
    );
  }

  @override
  $SemensTable createAlias(String alias) {
    return $SemensTable(attachedDatabase, alias);
  }
}

class Semen extends DataClass implements Insertable<Semen> {
  final String semenNumber;
  final String bullName;
  const Semen({required this.semenNumber, required this.bullName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['semen_number'] = Variable<String>(semenNumber);
    map['bull_name'] = Variable<String>(bullName);
    return map;
  }

  SemensCompanion toCompanion(bool nullToAbsent) {
    return SemensCompanion(
      semenNumber: Value(semenNumber),
      bullName: Value(bullName),
    );
  }

  factory Semen.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Semen(
      semenNumber: serializer.fromJson<String>(json['semenNumber']),
      bullName: serializer.fromJson<String>(json['bullName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'semenNumber': serializer.toJson<String>(semenNumber),
      'bullName': serializer.toJson<String>(bullName),
    };
  }

  Semen copyWith({String? semenNumber, String? bullName}) => Semen(
        semenNumber: semenNumber ?? this.semenNumber,
        bullName: bullName ?? this.bullName,
      );
  Semen copyWithCompanion(SemensCompanion data) {
    return Semen(
      semenNumber:
          data.semenNumber.present ? data.semenNumber.value : this.semenNumber,
      bullName: data.bullName.present ? data.bullName.value : this.bullName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Semen(')
          ..write('semenNumber: $semenNumber, ')
          ..write('bullName: $bullName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(semenNumber, bullName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Semen &&
          other.semenNumber == this.semenNumber &&
          other.bullName == this.bullName);
}

class SemensCompanion extends UpdateCompanion<Semen> {
  final Value<String> semenNumber;
  final Value<String> bullName;
  final Value<int> rowid;
  const SemensCompanion({
    this.semenNumber = const Value.absent(),
    this.bullName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SemensCompanion.insert({
    required String semenNumber,
    required String bullName,
    this.rowid = const Value.absent(),
  })  : semenNumber = Value(semenNumber),
        bullName = Value(bullName);
  static Insertable<Semen> custom({
    Expression<String>? semenNumber,
    Expression<String>? bullName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (semenNumber != null) 'semen_number': semenNumber,
      if (bullName != null) 'bull_name': bullName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SemensCompanion copyWith(
      {Value<String>? semenNumber,
      Value<String>? bullName,
      Value<int>? rowid}) {
    return SemensCompanion(
      semenNumber: semenNumber ?? this.semenNumber,
      bullName: bullName ?? this.bullName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (semenNumber.present) {
      map['semen_number'] = Variable<String>(semenNumber.value);
    }
    if (bullName.present) {
      map['bull_name'] = Variable<String>(bullName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemensCompanion(')
          ..write('semenNumber: $semenNumber, ')
          ..write('bullName: $bullName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReproductionsTable extends Reproductions
    with TableInfo<$ReproductionsTable, Reproduction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReproductionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumnWithTypeConverter<ReproductionKind, int> kind =
      GeneratedColumn<int>('kind', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ReproductionKind>($ReproductionsTable.$converterkind);
  static const VerificationMeta _diagnosticMeta =
      const VerificationMeta('diagnostic');
  @override
  late final GeneratedColumnWithTypeConverter<ReproductionDiagonostic, int>
      diagnostic = GeneratedColumn<int>('diagnostic', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: Constant(ReproductionDiagonostic.waiting.index))
          .withConverter<ReproductionDiagonostic>(
              $ReproductionsTable.$converterdiagnostic);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _cowMeta = const VerificationMeta('cow');
  @override
  late final GeneratedColumn<int> cow = GeneratedColumn<int>(
      'cow', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovines (id)'));
  static const VerificationMeta _bullMeta = const VerificationMeta('bull');
  @override
  late final GeneratedColumn<int> bull = GeneratedColumn<int>(
      'bull', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bovines (id)'));
  static const VerificationMeta _semenMeta = const VerificationMeta('semen');
  @override
  late final GeneratedColumn<String> semen = GeneratedColumn<String>(
      'semen', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES semens (semen_number)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, kind, diagnostic, date, cow, bull, semen];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reproductions';
  @override
  VerificationContext validateIntegrity(Insertable<Reproduction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_kindMeta, const VerificationResult.success());
    context.handle(_diagnosticMeta, const VerificationResult.success());
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('cow')) {
      context.handle(
          _cowMeta, cow.isAcceptableOrUnknown(data['cow']!, _cowMeta));
    } else if (isInserting) {
      context.missing(_cowMeta);
    }
    if (data.containsKey('bull')) {
      context.handle(
          _bullMeta, bull.isAcceptableOrUnknown(data['bull']!, _bullMeta));
    }
    if (data.containsKey('semen')) {
      context.handle(
          _semenMeta, semen.isAcceptableOrUnknown(data['semen']!, _semenMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reproduction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reproduction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kind: $ReproductionsTable.$converterkind.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kind'])!),
      diagnostic: $ReproductionsTable.$converterdiagnostic.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}diagnostic'])!),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      cow: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cow'])!,
      bull: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bull']),
      semen: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}semen']),
    );
  }

  @override
  $ReproductionsTable createAlias(String alias) {
    return $ReproductionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReproductionKind, int, int> $converterkind =
      const EnumIndexConverter<ReproductionKind>(ReproductionKind.values);
  static JsonTypeConverter2<ReproductionDiagonostic, int, int>
      $converterdiagnostic = const EnumIndexConverter<ReproductionDiagonostic>(
          ReproductionDiagonostic.values);
}

class Reproduction extends DataClass implements Insertable<Reproduction> {
  final int id;
  final ReproductionKind kind;
  final ReproductionDiagonostic diagnostic;
  final DateTime date;
  final int cow;
  final int? bull;
  final String? semen;
  const Reproduction(
      {required this.id,
      required this.kind,
      required this.diagnostic,
      required this.date,
      required this.cow,
      this.bull,
      this.semen});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['kind'] =
          Variable<int>($ReproductionsTable.$converterkind.toSql(kind));
    }
    {
      map['diagnostic'] = Variable<int>(
          $ReproductionsTable.$converterdiagnostic.toSql(diagnostic));
    }
    map['date'] = Variable<DateTime>(date);
    map['cow'] = Variable<int>(cow);
    if (!nullToAbsent || bull != null) {
      map['bull'] = Variable<int>(bull);
    }
    if (!nullToAbsent || semen != null) {
      map['semen'] = Variable<String>(semen);
    }
    return map;
  }

  ReproductionsCompanion toCompanion(bool nullToAbsent) {
    return ReproductionsCompanion(
      id: Value(id),
      kind: Value(kind),
      diagnostic: Value(diagnostic),
      date: Value(date),
      cow: Value(cow),
      bull: bull == null && nullToAbsent ? const Value.absent() : Value(bull),
      semen:
          semen == null && nullToAbsent ? const Value.absent() : Value(semen),
    );
  }

  factory Reproduction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reproduction(
      id: serializer.fromJson<int>(json['id']),
      kind: $ReproductionsTable.$converterkind
          .fromJson(serializer.fromJson<int>(json['kind'])),
      diagnostic: $ReproductionsTable.$converterdiagnostic
          .fromJson(serializer.fromJson<int>(json['diagnostic'])),
      date: serializer.fromJson<DateTime>(json['date']),
      cow: serializer.fromJson<int>(json['cow']),
      bull: serializer.fromJson<int?>(json['bull']),
      semen: serializer.fromJson<String?>(json['semen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer
          .toJson<int>($ReproductionsTable.$converterkind.toJson(kind)),
      'diagnostic': serializer.toJson<int>(
          $ReproductionsTable.$converterdiagnostic.toJson(diagnostic)),
      'date': serializer.toJson<DateTime>(date),
      'cow': serializer.toJson<int>(cow),
      'bull': serializer.toJson<int?>(bull),
      'semen': serializer.toJson<String?>(semen),
    };
  }

  Reproduction copyWith(
          {int? id,
          ReproductionKind? kind,
          ReproductionDiagonostic? diagnostic,
          DateTime? date,
          int? cow,
          Value<int?> bull = const Value.absent(),
          Value<String?> semen = const Value.absent()}) =>
      Reproduction(
        id: id ?? this.id,
        kind: kind ?? this.kind,
        diagnostic: diagnostic ?? this.diagnostic,
        date: date ?? this.date,
        cow: cow ?? this.cow,
        bull: bull.present ? bull.value : this.bull,
        semen: semen.present ? semen.value : this.semen,
      );
  Reproduction copyWithCompanion(ReproductionsCompanion data) {
    return Reproduction(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      diagnostic:
          data.diagnostic.present ? data.diagnostic.value : this.diagnostic,
      date: data.date.present ? data.date.value : this.date,
      cow: data.cow.present ? data.cow.value : this.cow,
      bull: data.bull.present ? data.bull.value : this.bull,
      semen: data.semen.present ? data.semen.value : this.semen,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reproduction(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('diagnostic: $diagnostic, ')
          ..write('date: $date, ')
          ..write('cow: $cow, ')
          ..write('bull: $bull, ')
          ..write('semen: $semen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kind, diagnostic, date, cow, bull, semen);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reproduction &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.diagnostic == this.diagnostic &&
          other.date == this.date &&
          other.cow == this.cow &&
          other.bull == this.bull &&
          other.semen == this.semen);
}

class ReproductionsCompanion extends UpdateCompanion<Reproduction> {
  final Value<int> id;
  final Value<ReproductionKind> kind;
  final Value<ReproductionDiagonostic> diagnostic;
  final Value<DateTime> date;
  final Value<int> cow;
  final Value<int?> bull;
  final Value<String?> semen;
  const ReproductionsCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.diagnostic = const Value.absent(),
    this.date = const Value.absent(),
    this.cow = const Value.absent(),
    this.bull = const Value.absent(),
    this.semen = const Value.absent(),
  });
  ReproductionsCompanion.insert({
    this.id = const Value.absent(),
    required ReproductionKind kind,
    this.diagnostic = const Value.absent(),
    required DateTime date,
    required int cow,
    this.bull = const Value.absent(),
    this.semen = const Value.absent(),
  })  : kind = Value(kind),
        date = Value(date),
        cow = Value(cow);
  static Insertable<Reproduction> custom({
    Expression<int>? id,
    Expression<int>? kind,
    Expression<int>? diagnostic,
    Expression<DateTime>? date,
    Expression<int>? cow,
    Expression<int>? bull,
    Expression<String>? semen,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (diagnostic != null) 'diagnostic': diagnostic,
      if (date != null) 'date': date,
      if (cow != null) 'cow': cow,
      if (bull != null) 'bull': bull,
      if (semen != null) 'semen': semen,
    });
  }

  ReproductionsCompanion copyWith(
      {Value<int>? id,
      Value<ReproductionKind>? kind,
      Value<ReproductionDiagonostic>? diagnostic,
      Value<DateTime>? date,
      Value<int>? cow,
      Value<int?>? bull,
      Value<String?>? semen}) {
    return ReproductionsCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      diagnostic: diagnostic ?? this.diagnostic,
      date: date ?? this.date,
      cow: cow ?? this.cow,
      bull: bull ?? this.bull,
      semen: semen ?? this.semen,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] =
          Variable<int>($ReproductionsTable.$converterkind.toSql(kind.value));
    }
    if (diagnostic.present) {
      map['diagnostic'] = Variable<int>(
          $ReproductionsTable.$converterdiagnostic.toSql(diagnostic.value));
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (cow.present) {
      map['cow'] = Variable<int>(cow.value);
    }
    if (bull.present) {
      map['bull'] = Variable<int>(bull.value);
    }
    if (semen.present) {
      map['semen'] = Variable<String>(semen.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReproductionsCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('diagnostic: $diagnostic, ')
          ..write('date: $date, ')
          ..write('cow: $cow, ')
          ..write('bull: $bull, ')
          ..write('semen: $semen')
          ..write(')'))
        .toString();
  }
}

class $DiscardsTable extends Discards with TableInfo<$DiscardsTable, Discard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumnWithTypeConverter<DiscardReason, int> reason =
      GeneratedColumn<int>('reason', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<DiscardReason>($DiscardsTable.$converterreason);
  static const VerificationMeta _observationMeta =
      const VerificationMeta('observation');
  @override
  late final GeneratedColumn<String> observation = GeneratedColumn<String>(
      'observation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bovineMeta = const VerificationMeta('bovine');
  @override
  late final GeneratedColumn<int> bovine = GeneratedColumn<int>(
      'bovine', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('UNIQUE REFERENCES bovines (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, reason, observation, bovine];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discards';
  @override
  VerificationContext validateIntegrity(Insertable<Discard> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_reasonMeta, const VerificationResult.success());
    if (data.containsKey('observation')) {
      context.handle(
          _observationMeta,
          observation.isAcceptableOrUnknown(
              data['observation']!, _observationMeta));
    }
    if (data.containsKey('bovine')) {
      context.handle(_bovineMeta,
          bovine.isAcceptableOrUnknown(data['bovine']!, _bovineMeta));
    } else if (isInserting) {
      context.missing(_bovineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Discard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Discard(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      reason: $DiscardsTable.$converterreason.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reason'])!),
      observation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observation']),
      bovine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovine'])!,
    );
  }

  @override
  $DiscardsTable createAlias(String alias) {
    return $DiscardsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DiscardReason, int, int> $converterreason =
      const EnumIndexConverter<DiscardReason>(DiscardReason.values);
}

class Discard extends DataClass implements Insertable<Discard> {
  final int id;
  final DiscardReason reason;
  final String? observation;
  final int bovine;
  const Discard(
      {required this.id,
      required this.reason,
      this.observation,
      required this.bovine});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['reason'] =
          Variable<int>($DiscardsTable.$converterreason.toSql(reason));
    }
    if (!nullToAbsent || observation != null) {
      map['observation'] = Variable<String>(observation);
    }
    map['bovine'] = Variable<int>(bovine);
    return map;
  }

  DiscardsCompanion toCompanion(bool nullToAbsent) {
    return DiscardsCompanion(
      id: Value(id),
      reason: Value(reason),
      observation: observation == null && nullToAbsent
          ? const Value.absent()
          : Value(observation),
      bovine: Value(bovine),
    );
  }

  factory Discard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Discard(
      id: serializer.fromJson<int>(json['id']),
      reason: $DiscardsTable.$converterreason
          .fromJson(serializer.fromJson<int>(json['reason'])),
      observation: serializer.fromJson<String?>(json['observation']),
      bovine: serializer.fromJson<int>(json['bovine']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reason': serializer
          .toJson<int>($DiscardsTable.$converterreason.toJson(reason)),
      'observation': serializer.toJson<String?>(observation),
      'bovine': serializer.toJson<int>(bovine),
    };
  }

  Discard copyWith(
          {int? id,
          DiscardReason? reason,
          Value<String?> observation = const Value.absent(),
          int? bovine}) =>
      Discard(
        id: id ?? this.id,
        reason: reason ?? this.reason,
        observation: observation.present ? observation.value : this.observation,
        bovine: bovine ?? this.bovine,
      );
  Discard copyWithCompanion(DiscardsCompanion data) {
    return Discard(
      id: data.id.present ? data.id.value : this.id,
      reason: data.reason.present ? data.reason.value : this.reason,
      observation:
          data.observation.present ? data.observation.value : this.observation,
      bovine: data.bovine.present ? data.bovine.value : this.bovine,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Discard(')
          ..write('id: $id, ')
          ..write('reason: $reason, ')
          ..write('observation: $observation, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reason, observation, bovine);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Discard &&
          other.id == this.id &&
          other.reason == this.reason &&
          other.observation == this.observation &&
          other.bovine == this.bovine);
}

class DiscardsCompanion extends UpdateCompanion<Discard> {
  final Value<int> id;
  final Value<DiscardReason> reason;
  final Value<String?> observation;
  final Value<int> bovine;
  const DiscardsCompanion({
    this.id = const Value.absent(),
    this.reason = const Value.absent(),
    this.observation = const Value.absent(),
    this.bovine = const Value.absent(),
  });
  DiscardsCompanion.insert({
    this.id = const Value.absent(),
    required DiscardReason reason,
    this.observation = const Value.absent(),
    required int bovine,
  })  : reason = Value(reason),
        bovine = Value(bovine);
  static Insertable<Discard> custom({
    Expression<int>? id,
    Expression<int>? reason,
    Expression<String>? observation,
    Expression<int>? bovine,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reason != null) 'reason': reason,
      if (observation != null) 'observation': observation,
      if (bovine != null) 'bovine': bovine,
    });
  }

  DiscardsCompanion copyWith(
      {Value<int>? id,
      Value<DiscardReason>? reason,
      Value<String?>? observation,
      Value<int>? bovine}) {
    return DiscardsCompanion(
      id: id ?? this.id,
      reason: reason ?? this.reason,
      observation: observation ?? this.observation,
      bovine: bovine ?? this.bovine,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reason.present) {
      map['reason'] =
          Variable<int>($DiscardsTable.$converterreason.toSql(reason.value));
    }
    if (observation.present) {
      map['observation'] = Variable<String>(observation.value);
    }
    if (bovine.present) {
      map['bovine'] = Variable<int>(bovine.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscardsCompanion(')
          ..write('id: $id, ')
          ..write('reason: $reason, ')
          ..write('observation: $observation, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }
}

class $SuccessfulReproductionsTable extends SuccessfulReproductions
    with TableInfo<$SuccessfulReproductionsTable, SuccessfulReproduction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuccessfulReproductionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _observationMeta =
      const VerificationMeta('observation');
  @override
  late final GeneratedColumn<String> observation = GeneratedColumn<String>(
      'observation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _birthForecastStartingDateMeta =
      const VerificationMeta('birthForecastStartingDate');
  @override
  late final GeneratedColumn<DateTime> birthForecastStartingDate =
      GeneratedColumn<DateTime>(
          'birth_forecast_starting_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _birthForecastEndingDateMeta =
      const VerificationMeta('birthForecastEndingDate');
  @override
  late final GeneratedColumn<DateTime> birthForecastEndingDate =
      GeneratedColumn<DateTime>(
          'birth_forecast_ending_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _milkWaitTimeDurationInDaysMeta =
      const VerificationMeta('milkWaitTimeDurationInDays');
  @override
  late final GeneratedColumn<int> milkWaitTimeDurationInDays =
      GeneratedColumn<int>(
          'milk_wait_time_duration_in_days', aliasedName, false,
          check: () => ComparableExpr(milkWaitTimeDurationInDays)
              .isBiggerThan(const Constant(0)),
          type: DriftSqlType.int,
          requiredDuringInsert: true);
  static const VerificationMeta _reproductionMeta =
      const VerificationMeta('reproduction');
  @override
  late final GeneratedColumn<int> reproduction = GeneratedColumn<int>(
      'reproduction', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES reproductions (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        observation,
        birthForecastStartingDate,
        birthForecastEndingDate,
        milkWaitTimeDurationInDays,
        reproduction
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'successful_reproductions';
  @override
  VerificationContext validateIntegrity(
      Insertable<SuccessfulReproduction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('observation')) {
      context.handle(
          _observationMeta,
          observation.isAcceptableOrUnknown(
              data['observation']!, _observationMeta));
    }
    if (data.containsKey('birth_forecast_starting_date')) {
      context.handle(
          _birthForecastStartingDateMeta,
          birthForecastStartingDate.isAcceptableOrUnknown(
              data['birth_forecast_starting_date']!,
              _birthForecastStartingDateMeta));
    } else if (isInserting) {
      context.missing(_birthForecastStartingDateMeta);
    }
    if (data.containsKey('birth_forecast_ending_date')) {
      context.handle(
          _birthForecastEndingDateMeta,
          birthForecastEndingDate.isAcceptableOrUnknown(
              data['birth_forecast_ending_date']!,
              _birthForecastEndingDateMeta));
    } else if (isInserting) {
      context.missing(_birthForecastEndingDateMeta);
    }
    if (data.containsKey('milk_wait_time_duration_in_days')) {
      context.handle(
          _milkWaitTimeDurationInDaysMeta,
          milkWaitTimeDurationInDays.isAcceptableOrUnknown(
              data['milk_wait_time_duration_in_days']!,
              _milkWaitTimeDurationInDaysMeta));
    } else if (isInserting) {
      context.missing(_milkWaitTimeDurationInDaysMeta);
    }
    if (data.containsKey('reproduction')) {
      context.handle(
          _reproductionMeta,
          reproduction.isAcceptableOrUnknown(
              data['reproduction']!, _reproductionMeta));
    } else if (isInserting) {
      context.missing(_reproductionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SuccessfulReproduction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SuccessfulReproduction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      observation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observation']),
      birthForecastStartingDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}birth_forecast_starting_date'])!,
      birthForecastEndingDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}birth_forecast_ending_date'])!,
      milkWaitTimeDurationInDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}milk_wait_time_duration_in_days'])!,
      reproduction: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reproduction'])!,
    );
  }

  @override
  $SuccessfulReproductionsTable createAlias(String alias) {
    return $SuccessfulReproductionsTable(attachedDatabase, alias);
  }
}

class SuccessfulReproduction extends DataClass
    implements Insertable<SuccessfulReproduction> {
  final int id;
  final String? observation;
  final DateTime birthForecastStartingDate;
  final DateTime birthForecastEndingDate;
  final int milkWaitTimeDurationInDays;
  final int reproduction;
  const SuccessfulReproduction(
      {required this.id,
      this.observation,
      required this.birthForecastStartingDate,
      required this.birthForecastEndingDate,
      required this.milkWaitTimeDurationInDays,
      required this.reproduction});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || observation != null) {
      map['observation'] = Variable<String>(observation);
    }
    map['birth_forecast_starting_date'] =
        Variable<DateTime>(birthForecastStartingDate);
    map['birth_forecast_ending_date'] =
        Variable<DateTime>(birthForecastEndingDate);
    map['milk_wait_time_duration_in_days'] =
        Variable<int>(milkWaitTimeDurationInDays);
    map['reproduction'] = Variable<int>(reproduction);
    return map;
  }

  SuccessfulReproductionsCompanion toCompanion(bool nullToAbsent) {
    return SuccessfulReproductionsCompanion(
      id: Value(id),
      observation: observation == null && nullToAbsent
          ? const Value.absent()
          : Value(observation),
      birthForecastStartingDate: Value(birthForecastStartingDate),
      birthForecastEndingDate: Value(birthForecastEndingDate),
      milkWaitTimeDurationInDays: Value(milkWaitTimeDurationInDays),
      reproduction: Value(reproduction),
    );
  }

  factory SuccessfulReproduction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SuccessfulReproduction(
      id: serializer.fromJson<int>(json['id']),
      observation: serializer.fromJson<String?>(json['observation']),
      birthForecastStartingDate:
          serializer.fromJson<DateTime>(json['birthForecastStartingDate']),
      birthForecastEndingDate:
          serializer.fromJson<DateTime>(json['birthForecastEndingDate']),
      milkWaitTimeDurationInDays:
          serializer.fromJson<int>(json['milkWaitTimeDurationInDays']),
      reproduction: serializer.fromJson<int>(json['reproduction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'observation': serializer.toJson<String?>(observation),
      'birthForecastStartingDate':
          serializer.toJson<DateTime>(birthForecastStartingDate),
      'birthForecastEndingDate':
          serializer.toJson<DateTime>(birthForecastEndingDate),
      'milkWaitTimeDurationInDays':
          serializer.toJson<int>(milkWaitTimeDurationInDays),
      'reproduction': serializer.toJson<int>(reproduction),
    };
  }

  SuccessfulReproduction copyWith(
          {int? id,
          Value<String?> observation = const Value.absent(),
          DateTime? birthForecastStartingDate,
          DateTime? birthForecastEndingDate,
          int? milkWaitTimeDurationInDays,
          int? reproduction}) =>
      SuccessfulReproduction(
        id: id ?? this.id,
        observation: observation.present ? observation.value : this.observation,
        birthForecastStartingDate:
            birthForecastStartingDate ?? this.birthForecastStartingDate,
        birthForecastEndingDate:
            birthForecastEndingDate ?? this.birthForecastEndingDate,
        milkWaitTimeDurationInDays:
            milkWaitTimeDurationInDays ?? this.milkWaitTimeDurationInDays,
        reproduction: reproduction ?? this.reproduction,
      );
  SuccessfulReproduction copyWithCompanion(
      SuccessfulReproductionsCompanion data) {
    return SuccessfulReproduction(
      id: data.id.present ? data.id.value : this.id,
      observation:
          data.observation.present ? data.observation.value : this.observation,
      birthForecastStartingDate: data.birthForecastStartingDate.present
          ? data.birthForecastStartingDate.value
          : this.birthForecastStartingDate,
      birthForecastEndingDate: data.birthForecastEndingDate.present
          ? data.birthForecastEndingDate.value
          : this.birthForecastEndingDate,
      milkWaitTimeDurationInDays: data.milkWaitTimeDurationInDays.present
          ? data.milkWaitTimeDurationInDays.value
          : this.milkWaitTimeDurationInDays,
      reproduction: data.reproduction.present
          ? data.reproduction.value
          : this.reproduction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SuccessfulReproduction(')
          ..write('id: $id, ')
          ..write('observation: $observation, ')
          ..write('birthForecastStartingDate: $birthForecastStartingDate, ')
          ..write('birthForecastEndingDate: $birthForecastEndingDate, ')
          ..write('milkWaitTimeDurationInDays: $milkWaitTimeDurationInDays, ')
          ..write('reproduction: $reproduction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, observation, birthForecastStartingDate,
      birthForecastEndingDate, milkWaitTimeDurationInDays, reproduction);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SuccessfulReproduction &&
          other.id == this.id &&
          other.observation == this.observation &&
          other.birthForecastStartingDate == this.birthForecastStartingDate &&
          other.birthForecastEndingDate == this.birthForecastEndingDate &&
          other.milkWaitTimeDurationInDays == this.milkWaitTimeDurationInDays &&
          other.reproduction == this.reproduction);
}

class SuccessfulReproductionsCompanion
    extends UpdateCompanion<SuccessfulReproduction> {
  final Value<int> id;
  final Value<String?> observation;
  final Value<DateTime> birthForecastStartingDate;
  final Value<DateTime> birthForecastEndingDate;
  final Value<int> milkWaitTimeDurationInDays;
  final Value<int> reproduction;
  const SuccessfulReproductionsCompanion({
    this.id = const Value.absent(),
    this.observation = const Value.absent(),
    this.birthForecastStartingDate = const Value.absent(),
    this.birthForecastEndingDate = const Value.absent(),
    this.milkWaitTimeDurationInDays = const Value.absent(),
    this.reproduction = const Value.absent(),
  });
  SuccessfulReproductionsCompanion.insert({
    this.id = const Value.absent(),
    this.observation = const Value.absent(),
    required DateTime birthForecastStartingDate,
    required DateTime birthForecastEndingDate,
    required int milkWaitTimeDurationInDays,
    required int reproduction,
  })  : birthForecastStartingDate = Value(birthForecastStartingDate),
        birthForecastEndingDate = Value(birthForecastEndingDate),
        milkWaitTimeDurationInDays = Value(milkWaitTimeDurationInDays),
        reproduction = Value(reproduction);
  static Insertable<SuccessfulReproduction> custom({
    Expression<int>? id,
    Expression<String>? observation,
    Expression<DateTime>? birthForecastStartingDate,
    Expression<DateTime>? birthForecastEndingDate,
    Expression<int>? milkWaitTimeDurationInDays,
    Expression<int>? reproduction,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (observation != null) 'observation': observation,
      if (birthForecastStartingDate != null)
        'birth_forecast_starting_date': birthForecastStartingDate,
      if (birthForecastEndingDate != null)
        'birth_forecast_ending_date': birthForecastEndingDate,
      if (milkWaitTimeDurationInDays != null)
        'milk_wait_time_duration_in_days': milkWaitTimeDurationInDays,
      if (reproduction != null) 'reproduction': reproduction,
    });
  }

  SuccessfulReproductionsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? observation,
      Value<DateTime>? birthForecastStartingDate,
      Value<DateTime>? birthForecastEndingDate,
      Value<int>? milkWaitTimeDurationInDays,
      Value<int>? reproduction}) {
    return SuccessfulReproductionsCompanion(
      id: id ?? this.id,
      observation: observation ?? this.observation,
      birthForecastStartingDate:
          birthForecastStartingDate ?? this.birthForecastStartingDate,
      birthForecastEndingDate:
          birthForecastEndingDate ?? this.birthForecastEndingDate,
      milkWaitTimeDurationInDays:
          milkWaitTimeDurationInDays ?? this.milkWaitTimeDurationInDays,
      reproduction: reproduction ?? this.reproduction,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (observation.present) {
      map['observation'] = Variable<String>(observation.value);
    }
    if (birthForecastStartingDate.present) {
      map['birth_forecast_starting_date'] =
          Variable<DateTime>(birthForecastStartingDate.value);
    }
    if (birthForecastEndingDate.present) {
      map['birth_forecast_ending_date'] =
          Variable<DateTime>(birthForecastEndingDate.value);
    }
    if (milkWaitTimeDurationInDays.present) {
      map['milk_wait_time_duration_in_days'] =
          Variable<int>(milkWaitTimeDurationInDays.value);
    }
    if (reproduction.present) {
      map['reproduction'] = Variable<int>(reproduction.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuccessfulReproductionsCompanion(')
          ..write('id: $id, ')
          ..write('observation: $observation, ')
          ..write('birthForecastStartingDate: $birthForecastStartingDate, ')
          ..write('birthForecastEndingDate: $birthForecastEndingDate, ')
          ..write('milkWaitTimeDurationInDays: $milkWaitTimeDurationInDays, ')
          ..write('reproduction: $reproduction')
          ..write(')'))
        .toString();
  }
}

class $PregnanciesTable extends Pregnancies
    with TableInfo<$PregnanciesTable, Pregnancy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PregnanciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dryingForecastStartingDateMeta =
      const VerificationMeta('dryingForecastStartingDate');
  @override
  late final GeneratedColumn<DateTime> dryingForecastStartingDate =
      GeneratedColumn<DateTime>(
          'drying_forecast_starting_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dryingForecastEndingDateMeta =
      const VerificationMeta('dryingForecastEndingDate');
  @override
  late final GeneratedColumn<DateTime> dryingForecastEndingDate =
      GeneratedColumn<DateTime>(
          'drying_forecast_ending_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _observationMeta =
      const VerificationMeta('observation');
  @override
  late final GeneratedColumn<String> observation = GeneratedColumn<String>(
      'observation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _successfulReproductionMeta =
      const VerificationMeta('successfulReproduction');
  @override
  late final GeneratedColumn<int> successfulReproduction = GeneratedColumn<int>(
      'successful_reproduction', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES successful_reproductions (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        dryingForecastStartingDate,
        dryingForecastEndingDate,
        observation,
        successfulReproduction
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pregnancies';
  @override
  VerificationContext validateIntegrity(Insertable<Pregnancy> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('drying_forecast_starting_date')) {
      context.handle(
          _dryingForecastStartingDateMeta,
          dryingForecastStartingDate.isAcceptableOrUnknown(
              data['drying_forecast_starting_date']!,
              _dryingForecastStartingDateMeta));
    } else if (isInserting) {
      context.missing(_dryingForecastStartingDateMeta);
    }
    if (data.containsKey('drying_forecast_ending_date')) {
      context.handle(
          _dryingForecastEndingDateMeta,
          dryingForecastEndingDate.isAcceptableOrUnknown(
              data['drying_forecast_ending_date']!,
              _dryingForecastEndingDateMeta));
    } else if (isInserting) {
      context.missing(_dryingForecastEndingDateMeta);
    }
    if (data.containsKey('observation')) {
      context.handle(
          _observationMeta,
          observation.isAcceptableOrUnknown(
              data['observation']!, _observationMeta));
    }
    if (data.containsKey('successful_reproduction')) {
      context.handle(
          _successfulReproductionMeta,
          successfulReproduction.isAcceptableOrUnknown(
              data['successful_reproduction']!, _successfulReproductionMeta));
    } else if (isInserting) {
      context.missing(_successfulReproductionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pregnancy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pregnancy(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      dryingForecastStartingDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}drying_forecast_starting_date'])!,
      dryingForecastEndingDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}drying_forecast_ending_date'])!,
      observation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observation']),
      successfulReproduction: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}successful_reproduction'])!,
    );
  }

  @override
  $PregnanciesTable createAlias(String alias) {
    return $PregnanciesTable(attachedDatabase, alias);
  }
}

class Pregnancy extends DataClass implements Insertable<Pregnancy> {
  final int id;
  final DateTime date;
  final DateTime dryingForecastStartingDate;
  final DateTime dryingForecastEndingDate;
  final String? observation;
  final int successfulReproduction;
  const Pregnancy(
      {required this.id,
      required this.date,
      required this.dryingForecastStartingDate,
      required this.dryingForecastEndingDate,
      this.observation,
      required this.successfulReproduction});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['drying_forecast_starting_date'] =
        Variable<DateTime>(dryingForecastStartingDate);
    map['drying_forecast_ending_date'] =
        Variable<DateTime>(dryingForecastEndingDate);
    if (!nullToAbsent || observation != null) {
      map['observation'] = Variable<String>(observation);
    }
    map['successful_reproduction'] = Variable<int>(successfulReproduction);
    return map;
  }

  PregnanciesCompanion toCompanion(bool nullToAbsent) {
    return PregnanciesCompanion(
      id: Value(id),
      date: Value(date),
      dryingForecastStartingDate: Value(dryingForecastStartingDate),
      dryingForecastEndingDate: Value(dryingForecastEndingDate),
      observation: observation == null && nullToAbsent
          ? const Value.absent()
          : Value(observation),
      successfulReproduction: Value(successfulReproduction),
    );
  }

  factory Pregnancy.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pregnancy(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      dryingForecastStartingDate:
          serializer.fromJson<DateTime>(json['dryingForecastStartingDate']),
      dryingForecastEndingDate:
          serializer.fromJson<DateTime>(json['dryingForecastEndingDate']),
      observation: serializer.fromJson<String?>(json['observation']),
      successfulReproduction:
          serializer.fromJson<int>(json['successfulReproduction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'dryingForecastStartingDate':
          serializer.toJson<DateTime>(dryingForecastStartingDate),
      'dryingForecastEndingDate':
          serializer.toJson<DateTime>(dryingForecastEndingDate),
      'observation': serializer.toJson<String?>(observation),
      'successfulReproduction': serializer.toJson<int>(successfulReproduction),
    };
  }

  Pregnancy copyWith(
          {int? id,
          DateTime? date,
          DateTime? dryingForecastStartingDate,
          DateTime? dryingForecastEndingDate,
          Value<String?> observation = const Value.absent(),
          int? successfulReproduction}) =>
      Pregnancy(
        id: id ?? this.id,
        date: date ?? this.date,
        dryingForecastStartingDate:
            dryingForecastStartingDate ?? this.dryingForecastStartingDate,
        dryingForecastEndingDate:
            dryingForecastEndingDate ?? this.dryingForecastEndingDate,
        observation: observation.present ? observation.value : this.observation,
        successfulReproduction:
            successfulReproduction ?? this.successfulReproduction,
      );
  Pregnancy copyWithCompanion(PregnanciesCompanion data) {
    return Pregnancy(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      dryingForecastStartingDate: data.dryingForecastStartingDate.present
          ? data.dryingForecastStartingDate.value
          : this.dryingForecastStartingDate,
      dryingForecastEndingDate: data.dryingForecastEndingDate.present
          ? data.dryingForecastEndingDate.value
          : this.dryingForecastEndingDate,
      observation:
          data.observation.present ? data.observation.value : this.observation,
      successfulReproduction: data.successfulReproduction.present
          ? data.successfulReproduction.value
          : this.successfulReproduction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pregnancy(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('dryingForecastStartingDate: $dryingForecastStartingDate, ')
          ..write('dryingForecastEndingDate: $dryingForecastEndingDate, ')
          ..write('observation: $observation, ')
          ..write('successfulReproduction: $successfulReproduction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, dryingForecastStartingDate,
      dryingForecastEndingDate, observation, successfulReproduction);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pregnancy &&
          other.id == this.id &&
          other.date == this.date &&
          other.dryingForecastStartingDate == this.dryingForecastStartingDate &&
          other.dryingForecastEndingDate == this.dryingForecastEndingDate &&
          other.observation == this.observation &&
          other.successfulReproduction == this.successfulReproduction);
}

class PregnanciesCompanion extends UpdateCompanion<Pregnancy> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<DateTime> dryingForecastStartingDate;
  final Value<DateTime> dryingForecastEndingDate;
  final Value<String?> observation;
  final Value<int> successfulReproduction;
  const PregnanciesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.dryingForecastStartingDate = const Value.absent(),
    this.dryingForecastEndingDate = const Value.absent(),
    this.observation = const Value.absent(),
    this.successfulReproduction = const Value.absent(),
  });
  PregnanciesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required DateTime dryingForecastStartingDate,
    required DateTime dryingForecastEndingDate,
    this.observation = const Value.absent(),
    required int successfulReproduction,
  })  : date = Value(date),
        dryingForecastStartingDate = Value(dryingForecastStartingDate),
        dryingForecastEndingDate = Value(dryingForecastEndingDate),
        successfulReproduction = Value(successfulReproduction);
  static Insertable<Pregnancy> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<DateTime>? dryingForecastStartingDate,
    Expression<DateTime>? dryingForecastEndingDate,
    Expression<String>? observation,
    Expression<int>? successfulReproduction,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (dryingForecastStartingDate != null)
        'drying_forecast_starting_date': dryingForecastStartingDate,
      if (dryingForecastEndingDate != null)
        'drying_forecast_ending_date': dryingForecastEndingDate,
      if (observation != null) 'observation': observation,
      if (successfulReproduction != null)
        'successful_reproduction': successfulReproduction,
    });
  }

  PregnanciesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<DateTime>? dryingForecastStartingDate,
      Value<DateTime>? dryingForecastEndingDate,
      Value<String?>? observation,
      Value<int>? successfulReproduction}) {
    return PregnanciesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      dryingForecastStartingDate:
          dryingForecastStartingDate ?? this.dryingForecastStartingDate,
      dryingForecastEndingDate:
          dryingForecastEndingDate ?? this.dryingForecastEndingDate,
      observation: observation ?? this.observation,
      successfulReproduction:
          successfulReproduction ?? this.successfulReproduction,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (dryingForecastStartingDate.present) {
      map['drying_forecast_starting_date'] =
          Variable<DateTime>(dryingForecastStartingDate.value);
    }
    if (dryingForecastEndingDate.present) {
      map['drying_forecast_ending_date'] =
          Variable<DateTime>(dryingForecastEndingDate.value);
    }
    if (observation.present) {
      map['observation'] = Variable<String>(observation.value);
    }
    if (successfulReproduction.present) {
      map['successful_reproduction'] =
          Variable<int>(successfulReproduction.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PregnanciesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('dryingForecastStartingDate: $dryingForecastStartingDate, ')
          ..write('dryingForecastEndingDate: $dryingForecastEndingDate, ')
          ..write('observation: $observation, ')
          ..write('successfulReproduction: $successfulReproduction')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BovinesTable bovines = $BovinesTable(this);
  late final $BirthsTable births = $BirthsTable(this);
  late final $NewbornFeedingsTable newbornFeedings =
      $NewbornFeedingsTable(this);
  late final $WeaningsTable weanings = $WeaningsTable(this);
  late final $ProductionsTable productions = $ProductionsTable(this);
  late final $TreatmentsTable treatments = $TreatmentsTable(this);
  late final $SemensTable semens = $SemensTable(this);
  late final $ReproductionsTable reproductions = $ReproductionsTable(this);
  late final $DiscardsTable discards = $DiscardsTable(this);
  late final $SuccessfulReproductionsTable successfulReproductions =
      $SuccessfulReproductionsTable(this);
  late final $PregnanciesTable pregnancies = $PregnanciesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        bovines,
        births,
        newbornFeedings,
        weanings,
        productions,
        treatments,
        semens,
        reproductions,
        discards,
        successfulReproductions,
        pregnancies
      ];
}

typedef $$BovinesTableCreateCompanionBuilder = BovinesCompanion Function({
  Value<int> id,
  required String name,
  required Sex sex,
});
typedef $$BovinesTableUpdateCompanionBuilder = BovinesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<Sex> sex,
});

final class $$BovinesTableReferences
    extends BaseReferences<_$AppDatabase, $BovinesTable, Bovine> {
  $$BovinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BirthsTable, List<Birth>> _birthsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.births,
          aliasName: $_aliasNameGenerator(db.bovines.id, db.births.bovine));

  $$BirthsTableProcessedTableManager get birthsRefs {
    final manager = $$BirthsTableTableManager($_db, $_db.births)
        .filter((f) => f.bovine.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_birthsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$NewbornFeedingsTable, List<NewbornFeeding>>
      _newbornFeedingsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.newbornFeedings,
              aliasName: $_aliasNameGenerator(
                  db.bovines.id, db.newbornFeedings.bovine));

  $$NewbornFeedingsTableProcessedTableManager get newbornFeedingsRefs {
    final manager =
        $$NewbornFeedingsTableTableManager($_db, $_db.newbornFeedings)
            .filter((f) => f.bovine.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_newbornFeedingsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WeaningsTable, List<Weaning>> _weaningsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.weanings,
          aliasName: $_aliasNameGenerator(db.bovines.id, db.weanings.bovine));

  $$WeaningsTableProcessedTableManager get weaningsRefs {
    final manager = $$WeaningsTableTableManager($_db, $_db.weanings)
        .filter((f) => f.bovine.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_weaningsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProductionsTable, List<Production>>
      _productionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.productions,
          aliasName: $_aliasNameGenerator(db.bovines.id, db.productions.cow));

  $$ProductionsTableProcessedTableManager get productionsRefs {
    final manager = $$ProductionsTableTableManager($_db, $_db.productions)
        .filter((f) => f.cow.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_productionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TreatmentsTable, List<Treatment>>
      _treatmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.treatments,
          aliasName: $_aliasNameGenerator(db.bovines.id, db.treatments.bovine));

  $$TreatmentsTableProcessedTableManager get treatmentsRefs {
    final manager = $$TreatmentsTableTableManager($_db, $_db.treatments)
        .filter((f) => f.bovine.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_treatmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DiscardsTable, List<Discard>> _discardsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.discards,
          aliasName: $_aliasNameGenerator(db.bovines.id, db.discards.bovine));

  $$DiscardsTableProcessedTableManager get discardsRefs {
    final manager = $$DiscardsTableTableManager($_db, $_db.discards)
        .filter((f) => f.bovine.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_discardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BovinesTableFilterComposer
    extends Composer<_$AppDatabase, $BovinesTable> {
  $$BovinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Sex, Sex, int> get sex => $composableBuilder(
      column: $table.sex,
      builder: (column) => ColumnWithTypeConverterFilters(column));

  Expression<bool> birthsRefs(
      Expression<bool> Function($$BirthsTableFilterComposer f) f) {
    final $$BirthsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.births,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BirthsTableFilterComposer(
              $db: $db,
              $table: $db.births,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> newbornFeedingsRefs(
      Expression<bool> Function($$NewbornFeedingsTableFilterComposer f) f) {
    final $$NewbornFeedingsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.newbornFeedings,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NewbornFeedingsTableFilterComposer(
              $db: $db,
              $table: $db.newbornFeedings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> weaningsRefs(
      Expression<bool> Function($$WeaningsTableFilterComposer f) f) {
    final $$WeaningsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.weanings,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeaningsTableFilterComposer(
              $db: $db,
              $table: $db.weanings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> productionsRefs(
      Expression<bool> Function($$ProductionsTableFilterComposer f) f) {
    final $$ProductionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productions,
        getReferencedColumn: (t) => t.cow,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductionsTableFilterComposer(
              $db: $db,
              $table: $db.productions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> treatmentsRefs(
      Expression<bool> Function($$TreatmentsTableFilterComposer f) f) {
    final $$TreatmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableFilterComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> discardsRefs(
      Expression<bool> Function($$DiscardsTableFilterComposer f) f) {
    final $$DiscardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.discards,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DiscardsTableFilterComposer(
              $db: $db,
              $table: $db.discards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BovinesTableOrderingComposer
    extends Composer<_$AppDatabase, $BovinesTable> {
  $$BovinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sex => $composableBuilder(
      column: $table.sex, builder: (column) => ColumnOrderings(column));
}

class $$BovinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BovinesTable> {
  $$BovinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Sex, int> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  Expression<T> birthsRefs<T extends Object>(
      Expression<T> Function($$BirthsTableAnnotationComposer a) f) {
    final $$BirthsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.births,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BirthsTableAnnotationComposer(
              $db: $db,
              $table: $db.births,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> newbornFeedingsRefs<T extends Object>(
      Expression<T> Function($$NewbornFeedingsTableAnnotationComposer a) f) {
    final $$NewbornFeedingsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.newbornFeedings,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NewbornFeedingsTableAnnotationComposer(
              $db: $db,
              $table: $db.newbornFeedings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> weaningsRefs<T extends Object>(
      Expression<T> Function($$WeaningsTableAnnotationComposer a) f) {
    final $$WeaningsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.weanings,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeaningsTableAnnotationComposer(
              $db: $db,
              $table: $db.weanings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> productionsRefs<T extends Object>(
      Expression<T> Function($$ProductionsTableAnnotationComposer a) f) {
    final $$ProductionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productions,
        getReferencedColumn: (t) => t.cow,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductionsTableAnnotationComposer(
              $db: $db,
              $table: $db.productions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> treatmentsRefs<T extends Object>(
      Expression<T> Function($$TreatmentsTableAnnotationComposer a) f) {
    final $$TreatmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> discardsRefs<T extends Object>(
      Expression<T> Function($$DiscardsTableAnnotationComposer a) f) {
    final $$DiscardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.discards,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DiscardsTableAnnotationComposer(
              $db: $db,
              $table: $db.discards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BovinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BovinesTable,
    Bovine,
    $$BovinesTableFilterComposer,
    $$BovinesTableOrderingComposer,
    $$BovinesTableAnnotationComposer,
    $$BovinesTableCreateCompanionBuilder,
    $$BovinesTableUpdateCompanionBuilder,
    (Bovine, $$BovinesTableReferences),
    Bovine,
    PrefetchHooks Function(
        {bool birthsRefs,
        bool newbornFeedingsRefs,
        bool weaningsRefs,
        bool productionsRefs,
        bool treatmentsRefs,
        bool discardsRefs})> {
  $$BovinesTableTableManager(_$AppDatabase db, $BovinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BovinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BovinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BovinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<Sex> sex = const Value.absent(),
          }) =>
              BovinesCompanion(
            id: id,
            name: name,
            sex: sex,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required Sex sex,
          }) =>
              BovinesCompanion.insert(
            id: id,
            name: name,
            sex: sex,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BovinesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {birthsRefs = false,
              newbornFeedingsRefs = false,
              weaningsRefs = false,
              productionsRefs = false,
              treatmentsRefs = false,
              discardsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (birthsRefs) db.births,
                if (newbornFeedingsRefs) db.newbornFeedings,
                if (weaningsRefs) db.weanings,
                if (productionsRefs) db.productions,
                if (treatmentsRefs) db.treatments,
                if (discardsRefs) db.discards
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (birthsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BovinesTableReferences._birthsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0).birthsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovine == item.id),
                        typedResults: items),
                  if (newbornFeedingsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$BovinesTableReferences
                            ._newbornFeedingsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0)
                                .newbornFeedingsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovine == item.id),
                        typedResults: items),
                  if (weaningsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BovinesTableReferences._weaningsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0)
                                .weaningsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovine == item.id),
                        typedResults: items),
                  if (productionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BovinesTableReferences._productionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0)
                                .productionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.cow == item.id),
                        typedResults: items),
                  if (treatmentsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BovinesTableReferences._treatmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0)
                                .treatmentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovine == item.id),
                        typedResults: items),
                  if (discardsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BovinesTableReferences._discardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0)
                                .discardsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bovine == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BovinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BovinesTable,
    Bovine,
    $$BovinesTableFilterComposer,
    $$BovinesTableOrderingComposer,
    $$BovinesTableAnnotationComposer,
    $$BovinesTableCreateCompanionBuilder,
    $$BovinesTableUpdateCompanionBuilder,
    (Bovine, $$BovinesTableReferences),
    Bovine,
    PrefetchHooks Function(
        {bool birthsRefs,
        bool newbornFeedingsRefs,
        bool weaningsRefs,
        bool productionsRefs,
        bool treatmentsRefs,
        bool discardsRefs})>;
typedef $$BirthsTableCreateCompanionBuilder = BirthsCompanion Function({
  Value<int> id,
  required DateTime date,
  Value<double?> weight,
  required BodyConditionScore bcs,
  required int bovine,
});
typedef $$BirthsTableUpdateCompanionBuilder = BirthsCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<double?> weight,
  Value<BodyConditionScore> bcs,
  Value<int> bovine,
});

final class $$BirthsTableReferences
    extends BaseReferences<_$AppDatabase, $BirthsTable, Birth> {
  $$BirthsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _bovineTable(_$AppDatabase db) => db.bovines
      .createAlias($_aliasNameGenerator(db.births.bovine, db.bovines.id));

  $$BovinesTableProcessedTableManager? get bovine {
    if ($_item.bovine == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.id($_item.bovine!));
    final item = $_typedResult.readTableOrNull(_bovineTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BirthsTableFilterComposer
    extends Composer<_$AppDatabase, $BirthsTable> {
  $$BirthsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<BodyConditionScore, BodyConditionScore, int>
      get bcs => $composableBuilder(
          column: $table.bcs,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$BovinesTableFilterComposer get bovine {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BirthsTableOrderingComposer
    extends Composer<_$AppDatabase, $BirthsTable> {
  $$BirthsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bcs => $composableBuilder(
      column: $table.bcs, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get bovine {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BirthsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BirthsTable> {
  $$BirthsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BodyConditionScore, int> get bcs =>
      $composableBuilder(column: $table.bcs, builder: (column) => column);

  $$BovinesTableAnnotationComposer get bovine {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BirthsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BirthsTable,
    Birth,
    $$BirthsTableFilterComposer,
    $$BirthsTableOrderingComposer,
    $$BirthsTableAnnotationComposer,
    $$BirthsTableCreateCompanionBuilder,
    $$BirthsTableUpdateCompanionBuilder,
    (Birth, $$BirthsTableReferences),
    Birth,
    PrefetchHooks Function({bool bovine})> {
  $$BirthsTableTableManager(_$AppDatabase db, $BirthsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BirthsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BirthsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BirthsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<BodyConditionScore> bcs = const Value.absent(),
            Value<int> bovine = const Value.absent(),
          }) =>
              BirthsCompanion(
            id: id,
            date: date,
            weight: weight,
            bcs: bcs,
            bovine: bovine,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            Value<double?> weight = const Value.absent(),
            required BodyConditionScore bcs,
            required int bovine,
          }) =>
              BirthsCompanion.insert(
            id: id,
            date: date,
            weight: weight,
            bcs: bcs,
            bovine: bovine,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BirthsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovine = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bovine) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovine,
                    referencedTable: $$BirthsTableReferences._bovineTable(db),
                    referencedColumn:
                        $$BirthsTableReferences._bovineTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BirthsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BirthsTable,
    Birth,
    $$BirthsTableFilterComposer,
    $$BirthsTableOrderingComposer,
    $$BirthsTableAnnotationComposer,
    $$BirthsTableCreateCompanionBuilder,
    $$BirthsTableUpdateCompanionBuilder,
    (Birth, $$BirthsTableReferences),
    Birth,
    PrefetchHooks Function({bool bovine})>;
typedef $$NewbornFeedingsTableCreateCompanionBuilder = NewbornFeedingsCompanion
    Function({
  Value<int> id,
  required DateTime date,
  required double volume,
  required int bovine,
});
typedef $$NewbornFeedingsTableUpdateCompanionBuilder = NewbornFeedingsCompanion
    Function({
  Value<int> id,
  Value<DateTime> date,
  Value<double> volume,
  Value<int> bovine,
});

final class $$NewbornFeedingsTableReferences extends BaseReferences<
    _$AppDatabase, $NewbornFeedingsTable, NewbornFeeding> {
  $$NewbornFeedingsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _bovineTable(_$AppDatabase db) => db.bovines.createAlias(
      $_aliasNameGenerator(db.newbornFeedings.bovine, db.bovines.id));

  $$BovinesTableProcessedTableManager? get bovine {
    if ($_item.bovine == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.id($_item.bovine!));
    final item = $_typedResult.readTableOrNull(_bovineTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$NewbornFeedingsTableFilterComposer
    extends Composer<_$AppDatabase, $NewbornFeedingsTable> {
  $$NewbornFeedingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get volume => $composableBuilder(
      column: $table.volume, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get bovine {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NewbornFeedingsTableOrderingComposer
    extends Composer<_$AppDatabase, $NewbornFeedingsTable> {
  $$NewbornFeedingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get volume => $composableBuilder(
      column: $table.volume, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get bovine {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NewbornFeedingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NewbornFeedingsTable> {
  $$NewbornFeedingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get volume =>
      $composableBuilder(column: $table.volume, builder: (column) => column);

  $$BovinesTableAnnotationComposer get bovine {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NewbornFeedingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NewbornFeedingsTable,
    NewbornFeeding,
    $$NewbornFeedingsTableFilterComposer,
    $$NewbornFeedingsTableOrderingComposer,
    $$NewbornFeedingsTableAnnotationComposer,
    $$NewbornFeedingsTableCreateCompanionBuilder,
    $$NewbornFeedingsTableUpdateCompanionBuilder,
    (NewbornFeeding, $$NewbornFeedingsTableReferences),
    NewbornFeeding,
    PrefetchHooks Function({bool bovine})> {
  $$NewbornFeedingsTableTableManager(
      _$AppDatabase db, $NewbornFeedingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NewbornFeedingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NewbornFeedingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NewbornFeedingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> volume = const Value.absent(),
            Value<int> bovine = const Value.absent(),
          }) =>
              NewbornFeedingsCompanion(
            id: id,
            date: date,
            volume: volume,
            bovine: bovine,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required double volume,
            required int bovine,
          }) =>
              NewbornFeedingsCompanion.insert(
            id: id,
            date: date,
            volume: volume,
            bovine: bovine,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$NewbornFeedingsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bovine = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bovine) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovine,
                    referencedTable:
                        $$NewbornFeedingsTableReferences._bovineTable(db),
                    referencedColumn:
                        $$NewbornFeedingsTableReferences._bovineTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$NewbornFeedingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NewbornFeedingsTable,
    NewbornFeeding,
    $$NewbornFeedingsTableFilterComposer,
    $$NewbornFeedingsTableOrderingComposer,
    $$NewbornFeedingsTableAnnotationComposer,
    $$NewbornFeedingsTableCreateCompanionBuilder,
    $$NewbornFeedingsTableUpdateCompanionBuilder,
    (NewbornFeeding, $$NewbornFeedingsTableReferences),
    NewbornFeeding,
    PrefetchHooks Function({bool bovine})>;
typedef $$WeaningsTableCreateCompanionBuilder = WeaningsCompanion Function({
  Value<int> id,
  required DateTime preWeaningStartingDate,
  Value<DateTime?> weaningDate,
  Value<double?> weight,
  required int bovine,
});
typedef $$WeaningsTableUpdateCompanionBuilder = WeaningsCompanion Function({
  Value<int> id,
  Value<DateTime> preWeaningStartingDate,
  Value<DateTime?> weaningDate,
  Value<double?> weight,
  Value<int> bovine,
});

final class $$WeaningsTableReferences
    extends BaseReferences<_$AppDatabase, $WeaningsTable, Weaning> {
  $$WeaningsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _bovineTable(_$AppDatabase db) => db.bovines
      .createAlias($_aliasNameGenerator(db.weanings.bovine, db.bovines.id));

  $$BovinesTableProcessedTableManager? get bovine {
    if ($_item.bovine == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.id($_item.bovine!));
    final item = $_typedResult.readTableOrNull(_bovineTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WeaningsTableFilterComposer
    extends Composer<_$AppDatabase, $WeaningsTable> {
  $$WeaningsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get preWeaningStartingDate => $composableBuilder(
      column: $table.preWeaningStartingDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get weaningDate => $composableBuilder(
      column: $table.weaningDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get bovine {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeaningsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeaningsTable> {
  $$WeaningsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get preWeaningStartingDate => $composableBuilder(
      column: $table.preWeaningStartingDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get weaningDate => $composableBuilder(
      column: $table.weaningDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get bovine {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeaningsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeaningsTable> {
  $$WeaningsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get preWeaningStartingDate => $composableBuilder(
      column: $table.preWeaningStartingDate, builder: (column) => column);

  GeneratedColumn<DateTime> get weaningDate => $composableBuilder(
      column: $table.weaningDate, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  $$BovinesTableAnnotationComposer get bovine {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeaningsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeaningsTable,
    Weaning,
    $$WeaningsTableFilterComposer,
    $$WeaningsTableOrderingComposer,
    $$WeaningsTableAnnotationComposer,
    $$WeaningsTableCreateCompanionBuilder,
    $$WeaningsTableUpdateCompanionBuilder,
    (Weaning, $$WeaningsTableReferences),
    Weaning,
    PrefetchHooks Function({bool bovine})> {
  $$WeaningsTableTableManager(_$AppDatabase db, $WeaningsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeaningsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeaningsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeaningsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> preWeaningStartingDate = const Value.absent(),
            Value<DateTime?> weaningDate = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<int> bovine = const Value.absent(),
          }) =>
              WeaningsCompanion(
            id: id,
            preWeaningStartingDate: preWeaningStartingDate,
            weaningDate: weaningDate,
            weight: weight,
            bovine: bovine,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime preWeaningStartingDate,
            Value<DateTime?> weaningDate = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            required int bovine,
          }) =>
              WeaningsCompanion.insert(
            id: id,
            preWeaningStartingDate: preWeaningStartingDate,
            weaningDate: weaningDate,
            weight: weight,
            bovine: bovine,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WeaningsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovine = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bovine) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovine,
                    referencedTable: $$WeaningsTableReferences._bovineTable(db),
                    referencedColumn:
                        $$WeaningsTableReferences._bovineTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WeaningsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeaningsTable,
    Weaning,
    $$WeaningsTableFilterComposer,
    $$WeaningsTableOrderingComposer,
    $$WeaningsTableAnnotationComposer,
    $$WeaningsTableCreateCompanionBuilder,
    $$WeaningsTableUpdateCompanionBuilder,
    (Weaning, $$WeaningsTableReferences),
    Weaning,
    PrefetchHooks Function({bool bovine})>;
typedef $$ProductionsTableCreateCompanionBuilder = ProductionsCompanion
    Function({
  Value<int> id,
  required double volume,
  required ProductionDayPeriod dayPeriod,
  required DateTime date,
  required bool discard,
  Value<String?> observation,
  required int cow,
});
typedef $$ProductionsTableUpdateCompanionBuilder = ProductionsCompanion
    Function({
  Value<int> id,
  Value<double> volume,
  Value<ProductionDayPeriod> dayPeriod,
  Value<DateTime> date,
  Value<bool> discard,
  Value<String?> observation,
  Value<int> cow,
});

final class $$ProductionsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductionsTable, Production> {
  $$ProductionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _cowTable(_$AppDatabase db) => db.bovines
      .createAlias($_aliasNameGenerator(db.productions.cow, db.bovines.id));

  $$BovinesTableProcessedTableManager? get cow {
    if ($_item.cow == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.id($_item.cow!));
    final item = $_typedResult.readTableOrNull(_cowTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ProductionsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductionsTable> {
  $$ProductionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get volume => $composableBuilder(
      column: $table.volume, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ProductionDayPeriod, ProductionDayPeriod, int>
      get dayPeriod => $composableBuilder(
          column: $table.dayPeriod,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get discard => $composableBuilder(
      column: $table.discard, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get cow {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductionsTable> {
  $$ProductionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get volume => $composableBuilder(
      column: $table.volume, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dayPeriod => $composableBuilder(
      column: $table.dayPeriod, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get discard => $composableBuilder(
      column: $table.discard, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get cow {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductionsTable> {
  $$ProductionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get volume =>
      $composableBuilder(column: $table.volume, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProductionDayPeriod, int> get dayPeriod =>
      $composableBuilder(column: $table.dayPeriod, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get discard =>
      $composableBuilder(column: $table.discard, builder: (column) => column);

  GeneratedColumn<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => column);

  $$BovinesTableAnnotationComposer get cow {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductionsTable,
    Production,
    $$ProductionsTableFilterComposer,
    $$ProductionsTableOrderingComposer,
    $$ProductionsTableAnnotationComposer,
    $$ProductionsTableCreateCompanionBuilder,
    $$ProductionsTableUpdateCompanionBuilder,
    (Production, $$ProductionsTableReferences),
    Production,
    PrefetchHooks Function({bool cow})> {
  $$ProductionsTableTableManager(_$AppDatabase db, $ProductionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> volume = const Value.absent(),
            Value<ProductionDayPeriod> dayPeriod = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> discard = const Value.absent(),
            Value<String?> observation = const Value.absent(),
            Value<int> cow = const Value.absent(),
          }) =>
              ProductionsCompanion(
            id: id,
            volume: volume,
            dayPeriod: dayPeriod,
            date: date,
            discard: discard,
            observation: observation,
            cow: cow,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required double volume,
            required ProductionDayPeriod dayPeriod,
            required DateTime date,
            required bool discard,
            Value<String?> observation = const Value.absent(),
            required int cow,
          }) =>
              ProductionsCompanion.insert(
            id: id,
            volume: volume,
            dayPeriod: dayPeriod,
            date: date,
            discard: discard,
            observation: observation,
            cow: cow,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProductionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({cow = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (cow) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cow,
                    referencedTable: $$ProductionsTableReferences._cowTable(db),
                    referencedColumn:
                        $$ProductionsTableReferences._cowTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ProductionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductionsTable,
    Production,
    $$ProductionsTableFilterComposer,
    $$ProductionsTableOrderingComposer,
    $$ProductionsTableAnnotationComposer,
    $$ProductionsTableCreateCompanionBuilder,
    $$ProductionsTableUpdateCompanionBuilder,
    (Production, $$ProductionsTableReferences),
    Production,
    PrefetchHooks Function({bool cow})>;
typedef $$TreatmentsTableCreateCompanionBuilder = TreatmentsCompanion Function({
  Value<int> id,
  required String reason,
  required String medicine,
  required DateTime startingDate,
  required DateTime endingDate,
  required int durationInDays,
  required bool drying,
  required int bovine,
});
typedef $$TreatmentsTableUpdateCompanionBuilder = TreatmentsCompanion Function({
  Value<int> id,
  Value<String> reason,
  Value<String> medicine,
  Value<DateTime> startingDate,
  Value<DateTime> endingDate,
  Value<int> durationInDays,
  Value<bool> drying,
  Value<int> bovine,
});

final class $$TreatmentsTableReferences
    extends BaseReferences<_$AppDatabase, $TreatmentsTable, Treatment> {
  $$TreatmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _bovineTable(_$AppDatabase db) => db.bovines
      .createAlias($_aliasNameGenerator(db.treatments.bovine, db.bovines.id));

  $$BovinesTableProcessedTableManager? get bovine {
    if ($_item.bovine == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.id($_item.bovine!));
    final item = $_typedResult.readTableOrNull(_bovineTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TreatmentsTableFilterComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicine => $composableBuilder(
      column: $table.medicine, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startingDate => $composableBuilder(
      column: $table.startingDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endingDate => $composableBuilder(
      column: $table.endingDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationInDays => $composableBuilder(
      column: $table.durationInDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get drying => $composableBuilder(
      column: $table.drying, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get bovine {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TreatmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicine => $composableBuilder(
      column: $table.medicine, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startingDate => $composableBuilder(
      column: $table.startingDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endingDate => $composableBuilder(
      column: $table.endingDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationInDays => $composableBuilder(
      column: $table.durationInDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get drying => $composableBuilder(
      column: $table.drying, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get bovine {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TreatmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get medicine =>
      $composableBuilder(column: $table.medicine, builder: (column) => column);

  GeneratedColumn<DateTime> get startingDate => $composableBuilder(
      column: $table.startingDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endingDate => $composableBuilder(
      column: $table.endingDate, builder: (column) => column);

  GeneratedColumn<int> get durationInDays => $composableBuilder(
      column: $table.durationInDays, builder: (column) => column);

  GeneratedColumn<bool> get drying =>
      $composableBuilder(column: $table.drying, builder: (column) => column);

  $$BovinesTableAnnotationComposer get bovine {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TreatmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TreatmentsTable,
    Treatment,
    $$TreatmentsTableFilterComposer,
    $$TreatmentsTableOrderingComposer,
    $$TreatmentsTableAnnotationComposer,
    $$TreatmentsTableCreateCompanionBuilder,
    $$TreatmentsTableUpdateCompanionBuilder,
    (Treatment, $$TreatmentsTableReferences),
    Treatment,
    PrefetchHooks Function({bool bovine})> {
  $$TreatmentsTableTableManager(_$AppDatabase db, $TreatmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreatmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreatmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreatmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> reason = const Value.absent(),
            Value<String> medicine = const Value.absent(),
            Value<DateTime> startingDate = const Value.absent(),
            Value<DateTime> endingDate = const Value.absent(),
            Value<int> durationInDays = const Value.absent(),
            Value<bool> drying = const Value.absent(),
            Value<int> bovine = const Value.absent(),
          }) =>
              TreatmentsCompanion(
            id: id,
            reason: reason,
            medicine: medicine,
            startingDate: startingDate,
            endingDate: endingDate,
            durationInDays: durationInDays,
            drying: drying,
            bovine: bovine,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String reason,
            required String medicine,
            required DateTime startingDate,
            required DateTime endingDate,
            required int durationInDays,
            required bool drying,
            required int bovine,
          }) =>
              TreatmentsCompanion.insert(
            id: id,
            reason: reason,
            medicine: medicine,
            startingDate: startingDate,
            endingDate: endingDate,
            durationInDays: durationInDays,
            drying: drying,
            bovine: bovine,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TreatmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bovine = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bovine) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovine,
                    referencedTable:
                        $$TreatmentsTableReferences._bovineTable(db),
                    referencedColumn:
                        $$TreatmentsTableReferences._bovineTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TreatmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TreatmentsTable,
    Treatment,
    $$TreatmentsTableFilterComposer,
    $$TreatmentsTableOrderingComposer,
    $$TreatmentsTableAnnotationComposer,
    $$TreatmentsTableCreateCompanionBuilder,
    $$TreatmentsTableUpdateCompanionBuilder,
    (Treatment, $$TreatmentsTableReferences),
    Treatment,
    PrefetchHooks Function({bool bovine})>;
typedef $$SemensTableCreateCompanionBuilder = SemensCompanion Function({
  required String semenNumber,
  required String bullName,
  Value<int> rowid,
});
typedef $$SemensTableUpdateCompanionBuilder = SemensCompanion Function({
  Value<String> semenNumber,
  Value<String> bullName,
  Value<int> rowid,
});

final class $$SemensTableReferences
    extends BaseReferences<_$AppDatabase, $SemensTable, Semen> {
  $$SemensTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ReproductionsTable, List<Reproduction>>
      _reproductionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.reproductions,
              aliasName: $_aliasNameGenerator(
                  db.semens.semenNumber, db.reproductions.semen));

  $$ReproductionsTableProcessedTableManager get reproductionsRefs {
    final manager = $$ReproductionsTableTableManager($_db, $_db.reproductions)
        .filter((f) => f.semen.semenNumber($_item.semenNumber));

    final cache = $_typedResult.readTableOrNull(_reproductionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SemensTableFilterComposer
    extends Composer<_$AppDatabase, $SemensTable> {
  $$SemensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get semenNumber => $composableBuilder(
      column: $table.semenNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bullName => $composableBuilder(
      column: $table.bullName, builder: (column) => ColumnFilters(column));

  Expression<bool> reproductionsRefs(
      Expression<bool> Function($$ReproductionsTableFilterComposer f) f) {
    final $$ReproductionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.semenNumber,
        referencedTable: $db.reproductions,
        getReferencedColumn: (t) => t.semen,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReproductionsTableFilterComposer(
              $db: $db,
              $table: $db.reproductions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SemensTableOrderingComposer
    extends Composer<_$AppDatabase, $SemensTable> {
  $$SemensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get semenNumber => $composableBuilder(
      column: $table.semenNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bullName => $composableBuilder(
      column: $table.bullName, builder: (column) => ColumnOrderings(column));
}

class $$SemensTableAnnotationComposer
    extends Composer<_$AppDatabase, $SemensTable> {
  $$SemensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get semenNumber => $composableBuilder(
      column: $table.semenNumber, builder: (column) => column);

  GeneratedColumn<String> get bullName =>
      $composableBuilder(column: $table.bullName, builder: (column) => column);

  Expression<T> reproductionsRefs<T extends Object>(
      Expression<T> Function($$ReproductionsTableAnnotationComposer a) f) {
    final $$ReproductionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.semenNumber,
        referencedTable: $db.reproductions,
        getReferencedColumn: (t) => t.semen,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReproductionsTableAnnotationComposer(
              $db: $db,
              $table: $db.reproductions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SemensTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SemensTable,
    Semen,
    $$SemensTableFilterComposer,
    $$SemensTableOrderingComposer,
    $$SemensTableAnnotationComposer,
    $$SemensTableCreateCompanionBuilder,
    $$SemensTableUpdateCompanionBuilder,
    (Semen, $$SemensTableReferences),
    Semen,
    PrefetchHooks Function({bool reproductionsRefs})> {
  $$SemensTableTableManager(_$AppDatabase db, $SemensTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SemensTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SemensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SemensTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> semenNumber = const Value.absent(),
            Value<String> bullName = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SemensCompanion(
            semenNumber: semenNumber,
            bullName: bullName,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String semenNumber,
            required String bullName,
            Value<int> rowid = const Value.absent(),
          }) =>
              SemensCompanion.insert(
            semenNumber: semenNumber,
            bullName: bullName,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SemensTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({reproductionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reproductionsRefs) db.reproductions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reproductionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$SemensTableReferences._reproductionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SemensTableReferences(db, table, p0)
                                .reproductionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.semen == item.semenNumber),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SemensTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SemensTable,
    Semen,
    $$SemensTableFilterComposer,
    $$SemensTableOrderingComposer,
    $$SemensTableAnnotationComposer,
    $$SemensTableCreateCompanionBuilder,
    $$SemensTableUpdateCompanionBuilder,
    (Semen, $$SemensTableReferences),
    Semen,
    PrefetchHooks Function({bool reproductionsRefs})>;
typedef $$ReproductionsTableCreateCompanionBuilder = ReproductionsCompanion
    Function({
  Value<int> id,
  required ReproductionKind kind,
  Value<ReproductionDiagonostic> diagnostic,
  required DateTime date,
  required int cow,
  Value<int?> bull,
  Value<String?> semen,
});
typedef $$ReproductionsTableUpdateCompanionBuilder = ReproductionsCompanion
    Function({
  Value<int> id,
  Value<ReproductionKind> kind,
  Value<ReproductionDiagonostic> diagnostic,
  Value<DateTime> date,
  Value<int> cow,
  Value<int?> bull,
  Value<String?> semen,
});

final class $$ReproductionsTableReferences
    extends BaseReferences<_$AppDatabase, $ReproductionsTable, Reproduction> {
  $$ReproductionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _cowTable(_$AppDatabase db) => db.bovines
      .createAlias($_aliasNameGenerator(db.reproductions.cow, db.bovines.id));

  $$BovinesTableProcessedTableManager? get cow {
    if ($_item.cow == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.id($_item.cow!));
    final item = $_typedResult.readTableOrNull(_cowTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BovinesTable _bullTable(_$AppDatabase db) => db.bovines
      .createAlias($_aliasNameGenerator(db.reproductions.bull, db.bovines.id));

  $$BovinesTableProcessedTableManager? get bull {
    if ($_item.bull == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.id($_item.bull!));
    final item = $_typedResult.readTableOrNull(_bullTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SemensTable _semenTable(_$AppDatabase db) => db.semens.createAlias(
      $_aliasNameGenerator(db.reproductions.semen, db.semens.semenNumber));

  $$SemensTableProcessedTableManager? get semen {
    if ($_item.semen == null) return null;
    final manager = $$SemensTableTableManager($_db, $_db.semens)
        .filter((f) => f.semenNumber($_item.semen!));
    final item = $_typedResult.readTableOrNull(_semenTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SuccessfulReproductionsTable,
      List<SuccessfulReproduction>> _successfulReproductionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.successfulReproductions,
          aliasName: $_aliasNameGenerator(
              db.reproductions.id, db.successfulReproductions.reproduction));

  $$SuccessfulReproductionsTableProcessedTableManager
      get successfulReproductionsRefs {
    final manager = $$SuccessfulReproductionsTableTableManager(
            $_db, $_db.successfulReproductions)
        .filter((f) => f.reproduction.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_successfulReproductionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ReproductionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReproductionsTable> {
  $$ReproductionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ReproductionKind, ReproductionKind, int>
      get kind => $composableBuilder(
          column: $table.kind,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<ReproductionDiagonostic,
          ReproductionDiagonostic, int>
      get diagnostic => $composableBuilder(
          column: $table.diagnostic,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get cow {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableFilterComposer get bull {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bull,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SemensTableFilterComposer get semen {
    final $$SemensTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.semen,
        referencedTable: $db.semens,
        getReferencedColumn: (t) => t.semenNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SemensTableFilterComposer(
              $db: $db,
              $table: $db.semens,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> successfulReproductionsRefs(
      Expression<bool> Function($$SuccessfulReproductionsTableFilterComposer f)
          f) {
    final $$SuccessfulReproductionsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.successfulReproductions,
            getReferencedColumn: (t) => t.reproduction,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SuccessfulReproductionsTableFilterComposer(
                  $db: $db,
                  $table: $db.successfulReproductions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ReproductionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReproductionsTable> {
  $$ReproductionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diagnostic => $composableBuilder(
      column: $table.diagnostic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get cow {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableOrderingComposer get bull {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bull,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SemensTableOrderingComposer get semen {
    final $$SemensTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.semen,
        referencedTable: $db.semens,
        getReferencedColumn: (t) => t.semenNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SemensTableOrderingComposer(
              $db: $db,
              $table: $db.semens,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReproductionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReproductionsTable> {
  $$ReproductionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReproductionKind, int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReproductionDiagonostic, int>
      get diagnostic => $composableBuilder(
          column: $table.diagnostic, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$BovinesTableAnnotationComposer get cow {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableAnnotationComposer get bull {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bull,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SemensTableAnnotationComposer get semen {
    final $$SemensTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.semen,
        referencedTable: $db.semens,
        getReferencedColumn: (t) => t.semenNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SemensTableAnnotationComposer(
              $db: $db,
              $table: $db.semens,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> successfulReproductionsRefs<T extends Object>(
      Expression<T> Function($$SuccessfulReproductionsTableAnnotationComposer a)
          f) {
    final $$SuccessfulReproductionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.successfulReproductions,
            getReferencedColumn: (t) => t.reproduction,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SuccessfulReproductionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.successfulReproductions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ReproductionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReproductionsTable,
    Reproduction,
    $$ReproductionsTableFilterComposer,
    $$ReproductionsTableOrderingComposer,
    $$ReproductionsTableAnnotationComposer,
    $$ReproductionsTableCreateCompanionBuilder,
    $$ReproductionsTableUpdateCompanionBuilder,
    (Reproduction, $$ReproductionsTableReferences),
    Reproduction,
    PrefetchHooks Function(
        {bool cow, bool bull, bool semen, bool successfulReproductionsRefs})> {
  $$ReproductionsTableTableManager(_$AppDatabase db, $ReproductionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReproductionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReproductionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReproductionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<ReproductionKind> kind = const Value.absent(),
            Value<ReproductionDiagonostic> diagnostic = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> cow = const Value.absent(),
            Value<int?> bull = const Value.absent(),
            Value<String?> semen = const Value.absent(),
          }) =>
              ReproductionsCompanion(
            id: id,
            kind: kind,
            diagnostic: diagnostic,
            date: date,
            cow: cow,
            bull: bull,
            semen: semen,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required ReproductionKind kind,
            Value<ReproductionDiagonostic> diagnostic = const Value.absent(),
            required DateTime date,
            required int cow,
            Value<int?> bull = const Value.absent(),
            Value<String?> semen = const Value.absent(),
          }) =>
              ReproductionsCompanion.insert(
            id: id,
            kind: kind,
            diagnostic: diagnostic,
            date: date,
            cow: cow,
            bull: bull,
            semen: semen,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ReproductionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {cow = false,
              bull = false,
              semen = false,
              successfulReproductionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (successfulReproductionsRefs) db.successfulReproductions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (cow) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cow,
                    referencedTable:
                        $$ReproductionsTableReferences._cowTable(db),
                    referencedColumn:
                        $$ReproductionsTableReferences._cowTable(db).id,
                  ) as T;
                }
                if (bull) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bull,
                    referencedTable:
                        $$ReproductionsTableReferences._bullTable(db),
                    referencedColumn:
                        $$ReproductionsTableReferences._bullTable(db).id,
                  ) as T;
                }
                if (semen) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.semen,
                    referencedTable:
                        $$ReproductionsTableReferences._semenTable(db),
                    referencedColumn: $$ReproductionsTableReferences
                        ._semenTable(db)
                        .semenNumber,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (successfulReproductionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ReproductionsTableReferences
                            ._successfulReproductionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ReproductionsTableReferences(db, table, p0)
                                .successfulReproductionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.reproduction == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ReproductionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReproductionsTable,
    Reproduction,
    $$ReproductionsTableFilterComposer,
    $$ReproductionsTableOrderingComposer,
    $$ReproductionsTableAnnotationComposer,
    $$ReproductionsTableCreateCompanionBuilder,
    $$ReproductionsTableUpdateCompanionBuilder,
    (Reproduction, $$ReproductionsTableReferences),
    Reproduction,
    PrefetchHooks Function(
        {bool cow, bool bull, bool semen, bool successfulReproductionsRefs})>;
typedef $$DiscardsTableCreateCompanionBuilder = DiscardsCompanion Function({
  Value<int> id,
  required DiscardReason reason,
  Value<String?> observation,
  required int bovine,
});
typedef $$DiscardsTableUpdateCompanionBuilder = DiscardsCompanion Function({
  Value<int> id,
  Value<DiscardReason> reason,
  Value<String?> observation,
  Value<int> bovine,
});

final class $$DiscardsTableReferences
    extends BaseReferences<_$AppDatabase, $DiscardsTable, Discard> {
  $$DiscardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _bovineTable(_$AppDatabase db) => db.bovines
      .createAlias($_aliasNameGenerator(db.discards.bovine, db.bovines.id));

  $$BovinesTableProcessedTableManager? get bovine {
    if ($_item.bovine == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.id($_item.bovine!));
    final item = $_typedResult.readTableOrNull(_bovineTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DiscardsTableFilterComposer
    extends Composer<_$AppDatabase, $DiscardsTable> {
  $$DiscardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<DiscardReason, DiscardReason, int>
      get reason => $composableBuilder(
          column: $table.reason,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get bovine {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DiscardsTableOrderingComposer
    extends Composer<_$AppDatabase, $DiscardsTable> {
  $$DiscardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get bovine {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DiscardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiscardsTable> {
  $$DiscardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DiscardReason, int> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => column);

  $$BovinesTableAnnotationComposer get bovine {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DiscardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DiscardsTable,
    Discard,
    $$DiscardsTableFilterComposer,
    $$DiscardsTableOrderingComposer,
    $$DiscardsTableAnnotationComposer,
    $$DiscardsTableCreateCompanionBuilder,
    $$DiscardsTableUpdateCompanionBuilder,
    (Discard, $$DiscardsTableReferences),
    Discard,
    PrefetchHooks Function({bool bovine})> {
  $$DiscardsTableTableManager(_$AppDatabase db, $DiscardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiscardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiscardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiscardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DiscardReason> reason = const Value.absent(),
            Value<String?> observation = const Value.absent(),
            Value<int> bovine = const Value.absent(),
          }) =>
              DiscardsCompanion(
            id: id,
            reason: reason,
            observation: observation,
            bovine: bovine,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DiscardReason reason,
            Value<String?> observation = const Value.absent(),
            required int bovine,
          }) =>
              DiscardsCompanion.insert(
            id: id,
            reason: reason,
            observation: observation,
            bovine: bovine,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DiscardsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovine = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bovine) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovine,
                    referencedTable: $$DiscardsTableReferences._bovineTable(db),
                    referencedColumn:
                        $$DiscardsTableReferences._bovineTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DiscardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DiscardsTable,
    Discard,
    $$DiscardsTableFilterComposer,
    $$DiscardsTableOrderingComposer,
    $$DiscardsTableAnnotationComposer,
    $$DiscardsTableCreateCompanionBuilder,
    $$DiscardsTableUpdateCompanionBuilder,
    (Discard, $$DiscardsTableReferences),
    Discard,
    PrefetchHooks Function({bool bovine})>;
typedef $$SuccessfulReproductionsTableCreateCompanionBuilder
    = SuccessfulReproductionsCompanion Function({
  Value<int> id,
  Value<String?> observation,
  required DateTime birthForecastStartingDate,
  required DateTime birthForecastEndingDate,
  required int milkWaitTimeDurationInDays,
  required int reproduction,
});
typedef $$SuccessfulReproductionsTableUpdateCompanionBuilder
    = SuccessfulReproductionsCompanion Function({
  Value<int> id,
  Value<String?> observation,
  Value<DateTime> birthForecastStartingDate,
  Value<DateTime> birthForecastEndingDate,
  Value<int> milkWaitTimeDurationInDays,
  Value<int> reproduction,
});

final class $$SuccessfulReproductionsTableReferences extends BaseReferences<
    _$AppDatabase, $SuccessfulReproductionsTable, SuccessfulReproduction> {
  $$SuccessfulReproductionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ReproductionsTable _reproductionTable(_$AppDatabase db) =>
      db.reproductions.createAlias($_aliasNameGenerator(
          db.successfulReproductions.reproduction, db.reproductions.id));

  $$ReproductionsTableProcessedTableManager? get reproduction {
    if ($_item.reproduction == null) return null;
    final manager = $$ReproductionsTableTableManager($_db, $_db.reproductions)
        .filter((f) => f.id($_item.reproduction!));
    final item = $_typedResult.readTableOrNull(_reproductionTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PregnanciesTable, List<Pregnancy>>
      _pregnanciesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.pregnancies,
              aliasName: $_aliasNameGenerator(db.successfulReproductions.id,
                  db.pregnancies.successfulReproduction));

  $$PregnanciesTableProcessedTableManager get pregnanciesRefs {
    final manager = $$PregnanciesTableTableManager($_db, $_db.pregnancies)
        .filter((f) => f.successfulReproduction.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_pregnanciesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SuccessfulReproductionsTableFilterComposer
    extends Composer<_$AppDatabase, $SuccessfulReproductionsTable> {
  $$SuccessfulReproductionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get birthForecastStartingDate => $composableBuilder(
      column: $table.birthForecastStartingDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get birthForecastEndingDate => $composableBuilder(
      column: $table.birthForecastEndingDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get milkWaitTimeDurationInDays => $composableBuilder(
      column: $table.milkWaitTimeDurationInDays,
      builder: (column) => ColumnFilters(column));

  $$ReproductionsTableFilterComposer get reproduction {
    final $$ReproductionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.reproduction,
        referencedTable: $db.reproductions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReproductionsTableFilterComposer(
              $db: $db,
              $table: $db.reproductions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> pregnanciesRefs(
      Expression<bool> Function($$PregnanciesTableFilterComposer f) f) {
    final $$PregnanciesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pregnancies,
        getReferencedColumn: (t) => t.successfulReproduction,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PregnanciesTableFilterComposer(
              $db: $db,
              $table: $db.pregnancies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SuccessfulReproductionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SuccessfulReproductionsTable> {
  $$SuccessfulReproductionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get birthForecastStartingDate => $composableBuilder(
      column: $table.birthForecastStartingDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get birthForecastEndingDate => $composableBuilder(
      column: $table.birthForecastEndingDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get milkWaitTimeDurationInDays => $composableBuilder(
      column: $table.milkWaitTimeDurationInDays,
      builder: (column) => ColumnOrderings(column));

  $$ReproductionsTableOrderingComposer get reproduction {
    final $$ReproductionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.reproduction,
        referencedTable: $db.reproductions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReproductionsTableOrderingComposer(
              $db: $db,
              $table: $db.reproductions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SuccessfulReproductionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuccessfulReproductionsTable> {
  $$SuccessfulReproductionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => column);

  GeneratedColumn<DateTime> get birthForecastStartingDate => $composableBuilder(
      column: $table.birthForecastStartingDate, builder: (column) => column);

  GeneratedColumn<DateTime> get birthForecastEndingDate => $composableBuilder(
      column: $table.birthForecastEndingDate, builder: (column) => column);

  GeneratedColumn<int> get milkWaitTimeDurationInDays => $composableBuilder(
      column: $table.milkWaitTimeDurationInDays, builder: (column) => column);

  $$ReproductionsTableAnnotationComposer get reproduction {
    final $$ReproductionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.reproduction,
        referencedTable: $db.reproductions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReproductionsTableAnnotationComposer(
              $db: $db,
              $table: $db.reproductions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> pregnanciesRefs<T extends Object>(
      Expression<T> Function($$PregnanciesTableAnnotationComposer a) f) {
    final $$PregnanciesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pregnancies,
        getReferencedColumn: (t) => t.successfulReproduction,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PregnanciesTableAnnotationComposer(
              $db: $db,
              $table: $db.pregnancies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SuccessfulReproductionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SuccessfulReproductionsTable,
    SuccessfulReproduction,
    $$SuccessfulReproductionsTableFilterComposer,
    $$SuccessfulReproductionsTableOrderingComposer,
    $$SuccessfulReproductionsTableAnnotationComposer,
    $$SuccessfulReproductionsTableCreateCompanionBuilder,
    $$SuccessfulReproductionsTableUpdateCompanionBuilder,
    (SuccessfulReproduction, $$SuccessfulReproductionsTableReferences),
    SuccessfulReproduction,
    PrefetchHooks Function({bool reproduction, bool pregnanciesRefs})> {
  $$SuccessfulReproductionsTableTableManager(
      _$AppDatabase db, $SuccessfulReproductionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuccessfulReproductionsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$SuccessfulReproductionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuccessfulReproductionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> observation = const Value.absent(),
            Value<DateTime> birthForecastStartingDate = const Value.absent(),
            Value<DateTime> birthForecastEndingDate = const Value.absent(),
            Value<int> milkWaitTimeDurationInDays = const Value.absent(),
            Value<int> reproduction = const Value.absent(),
          }) =>
              SuccessfulReproductionsCompanion(
            id: id,
            observation: observation,
            birthForecastStartingDate: birthForecastStartingDate,
            birthForecastEndingDate: birthForecastEndingDate,
            milkWaitTimeDurationInDays: milkWaitTimeDurationInDays,
            reproduction: reproduction,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> observation = const Value.absent(),
            required DateTime birthForecastStartingDate,
            required DateTime birthForecastEndingDate,
            required int milkWaitTimeDurationInDays,
            required int reproduction,
          }) =>
              SuccessfulReproductionsCompanion.insert(
            id: id,
            observation: observation,
            birthForecastStartingDate: birthForecastStartingDate,
            birthForecastEndingDate: birthForecastEndingDate,
            milkWaitTimeDurationInDays: milkWaitTimeDurationInDays,
            reproduction: reproduction,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SuccessfulReproductionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {reproduction = false, pregnanciesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pregnanciesRefs) db.pregnancies],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (reproduction) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.reproduction,
                    referencedTable: $$SuccessfulReproductionsTableReferences
                        ._reproductionTable(db),
                    referencedColumn: $$SuccessfulReproductionsTableReferences
                        ._reproductionTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pregnanciesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$SuccessfulReproductionsTableReferences
                                ._pregnanciesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SuccessfulReproductionsTableReferences(
                                    db, table, p0)
                                .pregnanciesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.successfulReproduction == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SuccessfulReproductionsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SuccessfulReproductionsTable,
        SuccessfulReproduction,
        $$SuccessfulReproductionsTableFilterComposer,
        $$SuccessfulReproductionsTableOrderingComposer,
        $$SuccessfulReproductionsTableAnnotationComposer,
        $$SuccessfulReproductionsTableCreateCompanionBuilder,
        $$SuccessfulReproductionsTableUpdateCompanionBuilder,
        (SuccessfulReproduction, $$SuccessfulReproductionsTableReferences),
        SuccessfulReproduction,
        PrefetchHooks Function({bool reproduction, bool pregnanciesRefs})>;
typedef $$PregnanciesTableCreateCompanionBuilder = PregnanciesCompanion
    Function({
  Value<int> id,
  required DateTime date,
  required DateTime dryingForecastStartingDate,
  required DateTime dryingForecastEndingDate,
  Value<String?> observation,
  required int successfulReproduction,
});
typedef $$PregnanciesTableUpdateCompanionBuilder = PregnanciesCompanion
    Function({
  Value<int> id,
  Value<DateTime> date,
  Value<DateTime> dryingForecastStartingDate,
  Value<DateTime> dryingForecastEndingDate,
  Value<String?> observation,
  Value<int> successfulReproduction,
});

final class $$PregnanciesTableReferences
    extends BaseReferences<_$AppDatabase, $PregnanciesTable, Pregnancy> {
  $$PregnanciesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SuccessfulReproductionsTable _successfulReproductionTable(
          _$AppDatabase db) =>
      db.successfulReproductions.createAlias($_aliasNameGenerator(
          db.pregnancies.successfulReproduction,
          db.successfulReproductions.id));

  $$SuccessfulReproductionsTableProcessedTableManager?
      get successfulReproduction {
    if ($_item.successfulReproduction == null) return null;
    final manager = $$SuccessfulReproductionsTableTableManager(
            $_db, $_db.successfulReproductions)
        .filter((f) => f.id($_item.successfulReproduction!));
    final item =
        $_typedResult.readTableOrNull(_successfulReproductionTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PregnanciesTableFilterComposer
    extends Composer<_$AppDatabase, $PregnanciesTable> {
  $$PregnanciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dryingForecastStartingDate => $composableBuilder(
      column: $table.dryingForecastStartingDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dryingForecastEndingDate => $composableBuilder(
      column: $table.dryingForecastEndingDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnFilters(column));

  $$SuccessfulReproductionsTableFilterComposer get successfulReproduction {
    final $$SuccessfulReproductionsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.successfulReproduction,
            referencedTable: $db.successfulReproductions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SuccessfulReproductionsTableFilterComposer(
                  $db: $db,
                  $table: $db.successfulReproductions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$PregnanciesTableOrderingComposer
    extends Composer<_$AppDatabase, $PregnanciesTable> {
  $$PregnanciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dryingForecastStartingDate =>
      $composableBuilder(
          column: $table.dryingForecastStartingDate,
          builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dryingForecastEndingDate => $composableBuilder(
      column: $table.dryingForecastEndingDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnOrderings(column));

  $$SuccessfulReproductionsTableOrderingComposer get successfulReproduction {
    final $$SuccessfulReproductionsTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.successfulReproduction,
            referencedTable: $db.successfulReproductions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SuccessfulReproductionsTableOrderingComposer(
                  $db: $db,
                  $table: $db.successfulReproductions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$PregnanciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PregnanciesTable> {
  $$PregnanciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get dryingForecastStartingDate =>
      $composableBuilder(
          column: $table.dryingForecastStartingDate,
          builder: (column) => column);

  GeneratedColumn<DateTime> get dryingForecastEndingDate => $composableBuilder(
      column: $table.dryingForecastEndingDate, builder: (column) => column);

  GeneratedColumn<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => column);

  $$SuccessfulReproductionsTableAnnotationComposer get successfulReproduction {
    final $$SuccessfulReproductionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.successfulReproduction,
            referencedTable: $db.successfulReproductions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SuccessfulReproductionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.successfulReproductions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$PregnanciesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PregnanciesTable,
    Pregnancy,
    $$PregnanciesTableFilterComposer,
    $$PregnanciesTableOrderingComposer,
    $$PregnanciesTableAnnotationComposer,
    $$PregnanciesTableCreateCompanionBuilder,
    $$PregnanciesTableUpdateCompanionBuilder,
    (Pregnancy, $$PregnanciesTableReferences),
    Pregnancy,
    PrefetchHooks Function({bool successfulReproduction})> {
  $$PregnanciesTableTableManager(_$AppDatabase db, $PregnanciesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PregnanciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PregnanciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PregnanciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<DateTime> dryingForecastStartingDate = const Value.absent(),
            Value<DateTime> dryingForecastEndingDate = const Value.absent(),
            Value<String?> observation = const Value.absent(),
            Value<int> successfulReproduction = const Value.absent(),
          }) =>
              PregnanciesCompanion(
            id: id,
            date: date,
            dryingForecastStartingDate: dryingForecastStartingDate,
            dryingForecastEndingDate: dryingForecastEndingDate,
            observation: observation,
            successfulReproduction: successfulReproduction,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required DateTime dryingForecastStartingDate,
            required DateTime dryingForecastEndingDate,
            Value<String?> observation = const Value.absent(),
            required int successfulReproduction,
          }) =>
              PregnanciesCompanion.insert(
            id: id,
            date: date,
            dryingForecastStartingDate: dryingForecastStartingDate,
            dryingForecastEndingDate: dryingForecastEndingDate,
            observation: observation,
            successfulReproduction: successfulReproduction,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PregnanciesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({successfulReproduction = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (successfulReproduction) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.successfulReproduction,
                    referencedTable: $$PregnanciesTableReferences
                        ._successfulReproductionTable(db),
                    referencedColumn: $$PregnanciesTableReferences
                        ._successfulReproductionTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PregnanciesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PregnanciesTable,
    Pregnancy,
    $$PregnanciesTableFilterComposer,
    $$PregnanciesTableOrderingComposer,
    $$PregnanciesTableAnnotationComposer,
    $$PregnanciesTableCreateCompanionBuilder,
    $$PregnanciesTableUpdateCompanionBuilder,
    (Pregnancy, $$PregnanciesTableReferences),
    Pregnancy,
    PrefetchHooks Function({bool successfulReproduction})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BovinesTableTableManager get bovines =>
      $$BovinesTableTableManager(_db, _db.bovines);
  $$BirthsTableTableManager get births =>
      $$BirthsTableTableManager(_db, _db.births);
  $$NewbornFeedingsTableTableManager get newbornFeedings =>
      $$NewbornFeedingsTableTableManager(_db, _db.newbornFeedings);
  $$WeaningsTableTableManager get weanings =>
      $$WeaningsTableTableManager(_db, _db.weanings);
  $$ProductionsTableTableManager get productions =>
      $$ProductionsTableTableManager(_db, _db.productions);
  $$TreatmentsTableTableManager get treatments =>
      $$TreatmentsTableTableManager(_db, _db.treatments);
  $$SemensTableTableManager get semens =>
      $$SemensTableTableManager(_db, _db.semens);
  $$ReproductionsTableTableManager get reproductions =>
      $$ReproductionsTableTableManager(_db, _db.reproductions);
  $$DiscardsTableTableManager get discards =>
      $$DiscardsTableTableManager(_db, _db.discards);
  $$SuccessfulReproductionsTableTableManager get successfulReproductions =>
      $$SuccessfulReproductionsTableTableManager(
          _db, _db.successfulReproductions);
  $$PregnanciesTableTableManager get pregnancies =>
      $$PregnanciesTableTableManager(_db, _db.pregnancies);
}
