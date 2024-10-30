import 'package:integrazoo/persistence/dry_treatment_persistence.dart';

import 'package:integrazoo/model/cow.dart';
import 'package:integrazoo/model/dry_treatment.dart';


class DryTreatmentController {
  DryTreatmentController();

  static Future<void> initiateTreatment(Cow cow, DryTreatment treatment) {
    return DryTreatmentPersistence.initiateTreatment(cow, treatment);
  }
}
