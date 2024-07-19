import 'package:integrazoo/dairy_cattle_subsystem/persistence/central_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow_milk_production.dart';


class CowProductionController {
    CentralPersistence persistence;

    CowProductionController(this.persistence);

    Future<bool> recordCowMilkProduction(Cow c, CowMilkProduction m) async {
        return persistence.cowProductionPersistence.recordCowMilkProduction(c, m);
    }


}

