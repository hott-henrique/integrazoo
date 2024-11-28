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
                    .join([innerJoin(database.bovines, database.bovines.id.equalsExp(database.treatments.bovine))])
                    ..where(database.treatments.endingDate.isNull() | database.treatments.endingDate.isBiggerThanValue(DateTime.now()))
                    ..limit(pageSz, offset: page * pageSz))
                    .get();

    List<Bovine> bovinesInTreatment = [];

    for (var treatment in query) {
      final bovine = treatment.readTable(database.bovines);

      bovinesInTreatment.add(Bovine(
        id: bovine.id,
        name: bovine.name,
        sex: bovine.sex
      ));
    }

    return bovinesInTreatment;
  }
}
