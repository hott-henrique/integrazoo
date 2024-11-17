import 'package:integrazoo/globals.dart';

import 'package:integrazoo/database/database.dart';
import 'package:integrazoo/model/bovine/cow.dart';

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
}
