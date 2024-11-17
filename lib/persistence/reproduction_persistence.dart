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
      kind: ReproductionKind.artificialInsemination,
      date: r.date,
      bull: Value(r.bull),
    );

    await database.into(database.reproductions).insert(companion);
  }

  static Future<List<Reproduction>> getArtificialInseminationsFromCow(int cowId, int pageSz, int page) async {
    final bovine = await (database.select(database.bovines)
                          ..where((b) => b.id.equals(cowId)))
                          .getSingleOrNull();

    if (bovine == null || bovine.sex == Sex.male) {
      return Future.error(Exception("Trying to register a reproduction for a male or inexistent bovine. (cow.id = $cowId)"));
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
      return Future.error(Exception("Trying to register a reproduction for a male or inexistent bovine. (cow.id = $cowId)"));
    }

    return (database.select(database.reproductions)
                    ..where((r) => r.cow.equals(cowId) & r.kind.equals(ReproductionKind.coverage.index))
                    ..limit(pageSz, offset: page * pageSz)
                    ..orderBy([ (b) => OrderingTerm(expression: b.date, mode: OrderingMode.desc) ]))
                    .get();
  }
}
