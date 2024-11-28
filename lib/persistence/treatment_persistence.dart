import 'package:drift/drift.dart';
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

  static Future<List<Bovine>> animalsInTreatment(int pageSz, int page) async {
    final query = await (database.select(database.treatments)
                    ..where((treatment) => treatment.endingDate.isNull() | treatment.endingDate.isBiggerThanValue(DateTime.now()))
                    ..limit(pageSz, offset: page * pageSz)).get();

    List<Bovine> bovinesInTreatment = [];

    for (var treatment in query) {
      final bovineQuery = database.select(database.bovines)
                          ..where((bovine) => bovine.id.equals(treatment.bovine));

      final bovine = await bovineQuery.getSingle();

      bovinesInTreatment.add(Bovine(
        id: bovine.id,
        name: bovine.name,
        sex: bovine.sex
      ));
    }

    return bovinesInTreatment;
  }
}
