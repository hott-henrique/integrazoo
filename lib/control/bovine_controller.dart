import 'package:integrazoo/persistence/bovine_persistence.dart';

import 'package:integrazoo/database/database.dart';


class BovineController {
  BovineController();

  static Future<List<Bovine>> readHerd() async {
    return BovinePersistence.readHerd();
  }

  static Future<List<Bovine>> readCows() {
    return BovinePersistence.readCows();
  }

  static Future<List<Bovine>> readBulls() {
    return BovinePersistence.readBulls();
  }

  static Future<void> createBovine(Bovine bovine) {
    return BovinePersistence.createBovine(bovine);
  }

  static Future<Bovine> getBovine(int bovineId) {
    return BovinePersistence.getBovine(bovineId);
  }

  static Future<void> discardBovine(Discard discard) async {
    return BovinePersistence.discardBovine(discard);
  }

  static Future<bool> wasDiscarded(int bovineId) async {
    return BovinePersistence.wasDiscarded(bovineId);
  }

  static Future<void> cancelDiscard(int bovineId) async {
    return BovinePersistence.cancelDiscard(bovineId);
  }
}
