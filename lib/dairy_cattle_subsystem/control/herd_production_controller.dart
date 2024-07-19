import 'package:integrazoo/dairy_cattle_subsystem/persistence/central_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/herd_milk_production.dart';


class HerdProductionController {
    CentralPersistence persistence;

    HerdProductionController(this.persistence);

    Future<bool> recordHerdMilkProduction(HerdMilkProduction p) async {
      return persistence.herdProductionPersistence.recordHerdMilkProduction(p);
    }

}
