import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/main.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/dry_treatment.dart';


class DryTreatmentPersistence {
    DryTreatmentPersistence();

    static onDatabaseCreate(Database db, int version) {
        db.execute("""
            CREATE TABLE IF NOT EXISTS DryTreatment(
                id            INTEGER UNIQUE PRIMARY KEY,
                cow_id        INTEGER                                NOT NULL,
                medicine      TEXT                                   NOT NULL,
                drying_date   INTEGER                                NOT NULL,
                resting_time  INTEGER                                NOT NULL,
                ending_date   INTEGER                                NOT NULL,

                FOREIGN KEY(cow_id) REFERENCES Bovine(id)
            );
        """);
    }

    Future<void> initiateTreatment(Cow c, DryTreatment t) async {
        Database db = DatabaseConnector.db!;
        try {
            t.id = await db.insert(
                'DryTreatment',
                {
                    'cow_id': c.id,
                    'medicine': t.medicine,
                    'drying_date': t.dryingDate.millisecondsSinceEpoch,
                    'resting_time': t.restingTime.inDays,
                    'ending_date': t.dryingDate.add(t.restingTime).millisecondsSinceEpoch
                }
            );
        } catch (e) {
          return Future.error(e);
        }
    }
}
