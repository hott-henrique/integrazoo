import 'package:integrazoo/persistence/bovine_persistence.dart';

import 'package:integrazoo/model/bovine.dart';
import 'package:integrazoo/model/bull.dart';
import 'package:integrazoo/model/cow.dart';


class BovineController {
  BovineController();

  static Future<List<Bovine>> readHerd() async {
    return BovinePersistence.readHerd();
  }

  static Future<List<Cow>> readCows() {
    return BovinePersistence.readCows();
  }

  static Future<List<Bull>> readBulls() {
    return BovinePersistence.readBulls();
  }

  static Future<void> createBovine(Bovine bovine) {
    return BovinePersistence.createBovine(bovine);
  }
}
