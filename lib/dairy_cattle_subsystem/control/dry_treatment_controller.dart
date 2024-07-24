import 'package:integrazoo/dairy_cattle_subsystem/persistence/central_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/dry_treatment.dart';


class DryTreatmentController {
    CentralPersistence persistence;

    DryTreatmentController(this.persistence);

    Future<bool> initiateTreatment(Cow cow, DryTreatment treatment) {
        return persistence.dryTreatmentPersistence.initiateTreatment(cow, treatment);
    }
}
