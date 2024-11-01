import 'package:integrazoo/persistence/dry_treatment_persistence.dart';

import 'package:integrazoo/model/bovine/cow.dart';
import 'package:integrazoo/model/health/dry_treatment.dart';


class DryTreatmentController {
  DryTreatmentController();

  static Future<void> initiateTreatment(Cow cow, DryTreatment treatment) {
    return DryTreatmentPersistence.initiateTreatment(cow, treatment);
  }
}
