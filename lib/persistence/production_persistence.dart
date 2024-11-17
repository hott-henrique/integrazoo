import 'dart:developer';
import 'package:drift/drift.dart';

import 'package:integrazoo/globals.dart';

import 'package:integrazoo/database/database.dart';


class ProductionPersistence {
  ProductionPersistence();

  static Future<void> recordMilkProduction(int bovineId, Production p) async {
    final bovine = await (database.select(database.bovines)
                          ..where((b) => b.id.equals(bovineId)))
                          .getSingleOrNull();

    if (bovine == null || bovine.sex == Sex.male) {
      inspect(bovine);
      return Future.error(Exception("Trying to register a production for a male or inexistent bovine. (bovineId = $bovineId)"));
    }

    final companion = ProductionsCompanion.insert(
      cow: bovineId,
      volume: p.volume,
      date: p.date,
      discard: p.discard,
      observation: p.observation != null ? Value(p.observation) : const Value.absent(),
      dayPeriod: p.dayPeriod
    );

    await database.into(database.productions).insert(companion);
  }

  static Future<List<Production>> getMilkProduction(int bovineId, int pageSz, int page) async {
    final bovine = await (database.select(database.bovines)
                          ..where((b) => b.id.equals(bovineId)))
                          .getSingleOrNull();

    if (bovine == null || bovine.sex == Sex.male) {
      return Future.error(Exception("Trying to register a production for a male or inexistent bovine. (bovineId = $bovineId)"));
    }

    return (database.select(database.productions)
            ..where((production) => production.cow.equals(bovineId))
            ..limit(pageSz, offset: page * pageSz))
            .get();
  }
}
