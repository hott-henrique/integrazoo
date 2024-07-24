import 'package:integrazoo/dairy_cattle_subsystem/persistence/central_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/treatment.dart';


class TreatmentController {
    CentralPersistence persistence;

    TreatmentController(this.persistence);

    Future<void> initiateTreatment(Cow cow, Treatment treatment) {
        return persistence.treatmentPersistence.initiateTreatment(cow, treatment);
    }
}
