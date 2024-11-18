import 'package:integrazoo/persistence/treatment_persistence.dart';

import 'package:integrazoo/database/database.dart';


class TreatmentController {
  TreatmentController();

  static Future<void> initiateTreatment(int bovineId, Treatment treatment) {
    return TreatmentPersistence.initiateTreatment(bovineId, treatment);
  }

  static Future<List<Treatment>> getTreatments(int bovineId, int pageSz, int page) {
    return TreatmentPersistence.getTreatments(bovineId, pageSz, page);
  }
}
