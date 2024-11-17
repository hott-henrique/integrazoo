import 'package:integrazoo/globals.dart';

import 'package:integrazoo/database/database.dart';


class TreatmentPersistence {
  TreatmentPersistence();

  static Future<void> initiateTreatment(int bovineId, Treatment t) async {
    database.into(database.treatments).insert(t.toCompanion(false));
  }

  static Future<List<Treatment>> getTreatments(int bovineId, int pageSz, int page) async {
    return (database.select(database.treatments)
            ..where((treatment) => treatment.bovine.equals(bovineId))
            ..limit(pageSz, offset: page * pageSz))
            .get();
  }
}
