import 'package:drift/drift.dart';

import 'package:integrazoo/globals.dart';

import 'package:integrazoo/database/database.dart';


class BovinePersistence {
  BovinePersistence();

  static Future<List<Bovine>> readHerd() async {
    return database.select(database.bovines).get();
  }

  static Future<List<Bovine>> readCows() async {
    return (database.select(database.bovines)..where((b) => b.sex.equals(Sex.female.index))).get();
  }

  static Future<List<Bovine>> readBulls() async {
    return (database.select(database.bovines)..where((b) => b.sex.equals(Sex.male.index))).get();
  }

  static Future<void> createBovine(Bovine bovine) async {
    await database.into(database.bovines).insert(BovinesCompanion.insert(name: bovine.name, sex: bovine.sex));
  }

  static Future<void> updateBovine(Bovine bovine) async {
    await database.into(database.bovines).insertOnConflictUpdate(bovine);
  }

  static Future<Bovine> getBovine(int bovineId) async {
    return (database.select(database.bovines)..where((b) => b.id.equals(bovineId))).getSingle();
  }

  static Future<void> discardBovine(Discard discard) async {
    final companion = DiscardsCompanion.insert(
      bovine: discard.bovine,
      reason: discard.reason,
      observation: Value(discard.observation),
    );

    await database.into(database.discards).insert(companion);
  }

  static Future<bool> wasDiscarded(int bovineId) async {
    final obj =  await (database.select(database.discards)..where((d) => d.bovine.equals(bovineId))).getSingleOrNull();

    return obj != null;
  }

  static Future<void> cancelDiscard(int bovineId) async {
    await (database.delete(database.discards)..where((d) => d.bovine.equals(bovineId))).go();
  }
}
