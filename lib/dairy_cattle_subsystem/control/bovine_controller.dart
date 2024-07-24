import 'package:integrazoo/dairy_cattle_subsystem/persistence/central_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/bovine.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/bull.dart';


class BovineController {
    CentralPersistence persistence;

    BovineController(this.persistence);

    Future<List<Bovine>> readHerd() async {
        return persistence.bovinePersistence.readHerd();
    }

    Future<List<Cow>> readCows() {
        return persistence.bovinePersistence.readCows();
    }

    Future<List<Bull>> readBulls() {
        return persistence.bovinePersistence.readBulls();
    }

    Future<void> createBovine(Bovine bovine) {
        return persistence.bovinePersistence.createBovine(bovine);
    }
}
