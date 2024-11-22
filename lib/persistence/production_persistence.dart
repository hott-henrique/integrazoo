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

  static Future<List<Map<DateTime, double>>> getAverageProductionInLast30d(int bovineId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

    final query = await (database.select(database.productions)
                  ..where((production) => production.cow.equals(bovineId) & 
                                                                  production.date.isBiggerThanValue(thirtyDaysAgo) & 
                                                                  production.discard.equals(false)))
                  .get();
    
    Map<DateTime, List<double>> productionsByDay = {};
    for (var production in query) {
      final date = DateTime(production.date.year, production.date.month, production.date.day);
      productionsByDay.putIfAbsent(date, () => []).add(production.volume);
    }

    List<Map<DateTime, double>> averageProduction = [];
    productionsByDay.forEach((date, volumes) {
      final averageVolume = volumes.reduce((a, b) => a + b) / volumes.length;
      averageProduction.add({date: averageVolume});
    });

    return averageProduction;
  }
}