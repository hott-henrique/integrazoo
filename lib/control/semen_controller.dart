import 'package:integrazoo/persistence/semen_persistence.dart';

import 'package:integrazoo/model/semen.dart';


class SemenController {
  SemenController();

  static Future<void> insertSemen(Semen s) {
    return SemenPersistence.insertSemen(s);
  }

  static Future<bool> isSemenPresent(Semen s) {
    return SemenPersistence.isSemenPresent(s);
  }
}
