import 'package:drift/drift.dart';

import 'package:integrazoo/globals.dart';

import 'package:integrazoo/database/database.dart';
import 'package:tuple_dart/tuple_dart.dart';


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

  static Future<List<Tuple2<DateTime, double>>> getAverageProductionInLast30d(int bovineId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

    final query = await (database.select(database.productions)
                  ..where((production) => production.cow.equals(bovineId) & 
                                          production.date.isBiggerThanValue(thirtyDaysAgo) & 
                                          production.discard.equals(false)))
                  .get();
    
    List<Tuple2<DateTime, double>> averageProduction = [];

    for (var production in query) {
      final date = DateTime(production.date.year, production.date.month, production.date.day);

      var existentTuple = averageProduction.firstWhere(
        (tuple) => tuple.item1.isAtSameMomentAs(date),
        orElse: () => Tuple2(date, 0.0)
      );

      if (existentTuple.item2 == 0.0) {
        averageProduction.add(Tuple2(date, production.volume));
      } else {
        final index = averageProduction.indexOf(existentTuple);
        final currentVolume = existentTuple.item2;
        final newVolume = currentVolume + production.volume;
        averageProduction[index] = Tuple2(date, newVolume / (index + 1));
      }
    }

    return averageProduction;
  }

  static Future<List<Tuple2<DateTime, double>>> getYTDProduction(int bovineId) async {
    final startOfYear = DateTime(DateTime.now().year, 1, 1);

    final query = await (database.select(database.productions)
                ..where((production) => production.cow.equals(bovineId) & 
                                        production.date.isBiggerThanValue(startOfYear) & 
                                        production.discard.equals(false)))
                .get();

    List<Tuple2<DateTime, double>> averageProduction = [];

    for (var production in query) {
      final date = DateTime(production.date.year, production.date.month, production.date.day);

      var existentTuple = averageProduction.firstWhere(
        (tuple) => tuple.item1 == date,
        orElse: () => Tuple2(date, 0.0)
      );

      if (existentTuple.item1 == date) {
        averageProduction.remove(existentTuple);
        averageProduction.add(Tuple2(date, (existentTuple.item2 + production.volume) / 2));
      } else {
        averageProduction.add(Tuple2(date, production.volume));
      }
    }

    return averageProduction;
  }
}