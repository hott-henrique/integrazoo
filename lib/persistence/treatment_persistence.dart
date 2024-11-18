import 'dart:developer';

import 'package:integrazoo/globals.dart';

import 'package:integrazoo/database/database.dart';


class TreatmentPersistence {
  TreatmentPersistence();

  static Future<void> initiateTreatment(int bovineId, Treatment t) async {
    final companion = TreatmentsCompanion.insert(
      reason: t.reason,
      medicine: t.medicine,
      startingDate: t.startingDate,
      endingDate: t.endingDate,
      durationInDays: t.durationInDays,
      drying: t.drying,
      bovine: t.bovine
    );

    await database.into(database.treatments).insert(companion);
  }

  static Future<List<Treatment>> getTreatments(int bovineId, int pageSz, int page) async {
    return (database.select(database.treatments)
            ..where((treatment) => treatment.bovine.equals(bovineId))
            ..limit(pageSz, offset: page * pageSz))
            .get();
  }
}
