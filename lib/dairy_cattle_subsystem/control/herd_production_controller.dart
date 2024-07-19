import 'package:integrazoo/dairy_cattle_subsystem/persistence/central_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/herd_milk_production.dart';


class HerdProductionController {
    CentralPersistence persistence;

    HerdProductionController(this.persistence);

    Future<bool> recordCowMilkProduction(HerdMilkProduction p) async {
        return persistence.herdProductionPersistence.recordHerdProduction(p);
    }


}

