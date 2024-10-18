import 'package:integrazoo/dairy_cattle_subsystem/persistence/central_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/semen.dart';


class SemenController {
  CentralPersistence persistence;

  SemenController(this.persistence);

  Future<void> insertSemen(Semen s) {
    return persistence.semenPersistence.insertSemen(s);
  }

  Future<bool> isSemenPresent(Semen s) {
    return persistence.semenPersistence.isSemenPresent(s);
  }
}
