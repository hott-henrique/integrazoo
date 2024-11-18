import 'package:integrazoo/persistence/semen_persistence.dart';

import 'package:integrazoo/database/database.dart';


class SemenController {
  SemenController();

  static Future<int> insertSemen(Semen s) {
    return SemenPersistence.insertSemen(s);
  }

  static Future<Semen> getSemen(String semenNumber) {
    return SemenPersistence.getSemen(semenNumber);
  }
}
