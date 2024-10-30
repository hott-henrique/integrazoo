import 'package:integrazoo/persistence/treatment_persistence.dart';

import 'package:integrazoo/model/bovine.dart';
import 'package:integrazoo/model/cow.dart';
import 'package:integrazoo/model/treatment.dart';


class TreatmentController {
  TreatmentController();

  static Future<void> initiateTreatment(Cow cow, Treatment treatment) {
    return TreatmentPersistence.initiateTreatment(cow, treatment);
  }

  static Future<List<Treatment>> getTreatments(Bovine bovine) {
    return TreatmentPersistence.getTreatments(bovine);
  }
}
