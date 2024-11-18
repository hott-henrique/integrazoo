import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

enum Sex {
  male, female;

  @override
  String toString() {
    switch (this) {
      case Sex.male:
        return "Macho";

      case Sex.female:
        return "Fêmea";
    }
  }
}

enum DiscardReason {
  death,
  sell,
  discard;

  @override
  String toString() {
    switch (this) {
      case death:
        return 'Morte';

      case sell:
        return 'Venda';

      case discard:
        return 'Descarte';
    }
  }
}

class Bovines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 6, max: 32)();
  IntColumn get sex => intEnum<Sex>()();
}

enum BodyConditionScore {
  cachetic,
  lean,
  ideal,
  fat,
  obese;

  @override
  String toString() {
    switch (this) {
      case BodyConditionScore.cachetic:
        return "Caquético";

      case BodyConditionScore.lean:
        return "Magro";

      case BodyConditionScore.ideal:
        return "Ideal";

      case BodyConditionScore.fat:
        return "Gordo";

      case BodyConditionScore.obese:
        return "Obeso";
    }
  }
}

class Births extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real().check(weight.isBiggerThan(const Constant(0.0))).nullable()();
  IntColumn get bcs => intEnum<BodyConditionScore>()();

  IntColumn get bovine => integer().references(Bovines, #id)();
}

class NewbornFeedings extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  RealColumn get volume => real().check(volume.isBiggerThan(const Constant(0.0)))();

  IntColumn get bovine => integer().references(Bovines, #id)();
}

class Weanings extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get preWeaningStartingDate => dateTime()();
  DateTimeColumn get weaningDate => dateTime().nullable()();
  RealColumn get weight => real().check(weight.isBiggerThan(const Constant(0.0))).nullable()();

  IntColumn get bovine => integer().references(Bovines, #id)();
}

enum ProductionDayPeriod {
  morning,
  afternon,
  night;

  @override
  toString() {
    switch (this) {
      case morning:
        return 'Manhã';

      case afternon:
        return 'Tarde';

      case night:
        return 'Noite';
    }
  }
}

class Productions extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get volume => real().check(volume.isBiggerThan(const Constant(0.0)))();
  IntColumn get dayPeriod => intEnum<ProductionDayPeriod>()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get discard => boolean()();
  TextColumn get observation => text().nullable()();

  IntColumn get cow => integer().references(Bovines, #id)();
}

class Treatments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get reason => text()();
  TextColumn get medicine => text()();
  DateTimeColumn get startingDate => dateTime()();
  DateTimeColumn get endingDate => dateTime()();
  IntColumn get durationInDays => integer().check(durationInDays.isBiggerThan(const Constant(0)))();
  BoolColumn get drying => boolean()();

  IntColumn get bovine => integer().references(Bovines, #id)();
}

enum ReproductionDiagonostic {
  positive,
  negative,
  waiting;

  @override
  String toString() {
    switch (this) {
      case positive:
        return 'Positivo';

      case negative:
        return 'Negativo';

      case waiting:
        return 'Esperando';
    }
  }
}

enum ReproductionKind {
  artificialInsemination,
  coverage;

  @override
  String toString() {
    switch (this) {
      case artificialInsemination:
        return 'Inseminação Artificial';

      case coverage:
        return 'Monta';
    }
  }
}

class Semens extends Table {
  TextColumn get semenNumber => text().withLength(min: 1)();
  TextColumn get bullName => text().withLength(min: 1)();

  @override
  Set<Column> get primaryKey => { semenNumber };
}

class Reproductions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get kind => intEnum<ReproductionKind>()();
  IntColumn get diagnostic => intEnum<ReproductionDiagonostic>().withDefault(Constant(ReproductionDiagonostic.waiting.index))();
  DateTimeColumn get date => dateTime()();

  IntColumn get cow => integer().references(Bovines, #id)();

  IntColumn get bull => integer().references(Bovines, #id).nullable()();
  TextColumn get semen => text().references(Semens, #semenNumber).nullable()();
}

class Discards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get reason => intEnum<DiscardReason>()();
  TextColumn get observation => text().nullable()();

  IntColumn get bovine => integer().references(Bovines, #id)();
}

class SuccessfulReproductions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get observation => text().nullable()();
  DateTimeColumn get birthForecastStartingDate => dateTime()();
  DateTimeColumn get birthForecastEndingDate => dateTime()();
  IntColumn get milkWaitTimeDurationInDays => integer().check(milkWaitTimeDurationInDays.isBiggerThan(const Constant(0)))();

  IntColumn get reproduction => integer().references(Reproductions, #id)();
}

@DataClassName('Pregnancy')
class Pregnancies extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get dryingForecastStartingDate => dateTime()();
  DateTimeColumn get dryingForecastEndingDate => dateTime()();
  TextColumn get observation => text().nullable()();

  IntColumn get successfulReproduction => integer().references(SuccessfulReproductions, #id)();
}


@DriftDatabase(tables: [
  Bovines,
  Births,
  NewbornFeedings,
  Weanings,
  Productions,
  Treatments,
  Semens,
  Reproductions,
  Discards,
  SuccessfulReproductions,
  Pregnancies
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'drift-integrazoo'
    );
  }
}
