import 'package:drift/drift.dart';

import 'package:integrazoo/globals.dart';

import 'package:integrazoo/database/database.dart';


class ReproductionPersistence {
  ReproductionPersistence();

  static Future<void> registerArtificialInseminationAttempt(Reproduction r) async {
    final bovine = await (database.select(database.bovines)
                          ..where((b) => b.id.equals(r.cow)))
                          .getSingleOrNull();

    if (bovine == null || bovine.sex == Sex.male) {
      return Future.error(Exception("Trying to register a reproduction for a male or inexistent bovine. (r.cow = ${r.cow})"));
    }

    if (r.semen == null) {
      return Future.error(Exception("Trying to register a artificial insemination without a semen. (r.semen = ${r.semen})"));
    }

    final companion = ReproductionsCompanion.insert(
      cow: r.cow,
      kind: ReproductionKind.artificialInsemination,
      date: r.date,
      semen: Value(r.semen),
    );

    await database.into(database.reproductions).insert(companion);
  }

  static Future<void> registerCoverageAttempt(Reproduction r) async {
    final bovine = await (database.select(database.bovines)
                          ..where((b) => b.id.equals(r.cow)))
                          .getSingleOrNull();

    if (bovine == null || bovine.sex == Sex.male) {
      return Future.error(Exception("Trying to register a reproduction for a male or inexistent bovine. (r.cow = ${r.cow})"));
    }

    if (r.bull == null) {
      return Future.error(Exception("Trying to register a coverage without a bull. (r.bull = ${r.semen})"));
    }

    final companion = ReproductionsCompanion.insert(
      cow: r.cow,
      kind: ReproductionKind.coverage,
      date: r.date,
      bull: Value(r.bull),
    );

    await database.into(database.reproductions).insert(companion);
  }

  static Future<List<Reproduction>> getReproductionsFromCow(int cowId, int pageSz, int page) async {
    final bovine = await (database.select(database.bovines)
                          ..where((b) => b.id.equals(cowId)))
                          .getSingleOrNull();

    if (bovine == null || bovine.sex == Sex.male) {
      return Future.error(Exception("Trying to get reproductions for a male or inexistent bovine. (cow.id = $cowId)"));
    }

    return (database.select(database.reproductions)
                    ..where((r) => r.cow.equals(cowId))
                    ..limit(pageSz, offset: page * pageSz)
                    ..orderBy([ (b) => OrderingTerm(expression: b.date, mode: OrderingMode.desc) ]))
                    .get();
  }

  static Future<List<Reproduction>> getArtificialInseminationsFromCow(int cowId, int pageSz, int page) async {
    final bovine = await (database.select(database.bovines)
                          ..where((b) => b.id.equals(cowId)))
                          .getSingleOrNull();

    if (bovine == null || bovine.sex == Sex.male) {
      return Future.error(Exception("Trying to get reproductions for a male or inexistent bovine. (cow.id = $cowId)"));
    }

    return (database.select(database.reproductions)
                    ..where((r) => r.cow.equals(cowId) & r.kind.equals(ReproductionKind.artificialInsemination.index))
                    ..limit(pageSz, offset: page * pageSz)
                    ..orderBy([ (b) => OrderingTerm(expression: b.date, mode: OrderingMode.desc) ]))
                    .get();
  }

  static Future<List<Reproduction>> getCoveragesFromCow(int cowId, int pageSz, int page) async {
    final bovine = await (database.select(database.bovines)
                          ..where((b) => b.id.equals(cowId)))
                          .getSingleOrNull();

    if (bovine == null || bovine.sex == Sex.male) {
      return Future.error(Exception("Trying to get reproductions for a male or inexistent bovine. (cow.id = $cowId)"));
    }

    return (database.select(database.reproductions)
                    ..where((r) => r.cow.equals(cowId) & r.kind.equals(ReproductionKind.coverage.index))
                    ..limit(pageSz, offset: page * pageSz)
                    ..orderBy([ (b) => OrderingTerm(expression: b.date, mode: OrderingMode.desc) ]))
                    .get();
  }

  static Future<void> confirmPregnancy(int reproductionId, Pregnancy p) async {
    final companion = PregnanciesCompanion.insert(
      date: p.date,
      dryingForecast: p.dryingForecast,
      birthForecast: p.birthForecast,
      milkWaitTimeDurationInDays: p.milkWaitTimeDurationInDays,
      observation: Value(p.observation),
      reproduction: reproductionId,
    );

    await database.into(database.pregnancies).insert(companion);

    final reproduction = await (database.select(database.reproductions)..where((r) => r.id.equals(reproductionId))).getSingle();

    final reproductionCompanion = ReproductionsCompanion.insert(
      id: Value(reproduction.id),
      kind: reproduction.kind,
      diagnostic: const Value(ReproductionDiagonostic.positive),
      date: reproduction.date,
      cow: reproduction.cow,
      bull: Value(reproduction.bull),
      semen: Value(reproduction.semen)
    );

    await database.update(database.reproductions).replace(reproductionCompanion);
  }

  static Future<void> registryFailedReproduction(int reproductionId) async {
    final reproduction = await (database.select(database.reproductions)..where((r) => r.id.equals(reproductionId))).getSingle();

    if (reproduction.diagnostic == ReproductionDiagonostic.positive) {
      await (database.delete(database.pregnancies)..where((p) => p.reproduction.equals(reproductionId))).go();
    }

    final reproductionCompanion = ReproductionsCompanion.insert(
      id: Value(reproduction.id),
      kind: reproduction.kind,
      diagnostic: const Value(ReproductionDiagonostic.negative),
      date: reproduction.date,
      cow: reproduction.cow,
      bull: Value(reproduction.bull),
      semen: Value(reproduction.semen)
    );

    await database.update(database.reproductions).replace(reproductionCompanion);
  }

  static Future<void> cancelDiagnostic(int reproductionId) async {
    final reproduction = await (database.select(database.reproductions)..where((r) => r.id.equals(reproductionId))).getSingle();

    if (reproduction.diagnostic == ReproductionDiagonostic.positive) {
      await (database.delete(database.pregnancies)..where((p) => p.reproduction.equals(reproductionId))).go();
    }

    final reproductionCompanion = ReproductionsCompanion.insert(
      id: Value(reproduction.id),
      kind: reproduction.kind,
      diagnostic: const Value(ReproductionDiagonostic.waiting),
      date: reproduction.date,
      cow: reproduction.cow,
      bull: Value(reproduction.bull),
      semen: Value(reproduction.semen)
    );

    await database.update(database.reproductions).replace(reproductionCompanion);
  }

  static Future<Reproduction> getReproductionById(int reproductionId) async {
    return (database.select(database.reproductions)
            ..where((r) => r.id.equals(reproductionId)))
            .getSingle();
  }
}
