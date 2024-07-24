import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/main.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/treatment.dart';


class TreatmentPersistence {
  TreatmentPersistence();

  static onDatabaseCreate(Database db, int version) {
    db.execute("""
      CREATE TABLE IF NOT EXISTS Treatment(
        id            INTEGER UNIQUE PRIMARY KEY,
        cow_id        INTEGER                                NOT NULL,
        reason        TEXT                                   NOT NULL,
        medicine      TEXT                                   NOT NULL,
        starting_date INTEGER                                NOT NULL,
        ending_date   INTEGER                                NOT NULL,
        resting_time  INTEGER                                NOT NULL,
        release_date  INTEGER                                NOT NULL,

        FOREIGN KEY(cow_id) REFERENCES Bovine(id)
      );
    """);
  }

  Future<void> initiateTreatment(Cow c, Treatment t) async {
    Database db = DatabaseConnector.db!;
    inspect(c);
    inspect(t);
    try {
      t.id = await db.insert(
        'Treatment',
        {
          'cow_id': c.id,
          'reason': t.reason,
          'medicine': t.medicine,
          'starting_date': t.period.start.millisecondsSinceEpoch,
          'ending_date': t.period.end.millisecondsSinceEpoch,
          'resting_time': t.restingTime.inDays,
          'release_date': t.tankReleaseDate().millisecondsSinceEpoch
        }
      );
    } catch (e) {
      return Future.error(e);
    }
  }
}
