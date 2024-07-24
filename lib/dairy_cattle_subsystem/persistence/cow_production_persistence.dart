import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/main.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow_milk_production.dart';


class CowProductionPersistence {
    CowProductionPersistence();

    static onDatabaseCreate(Database db, int version) {
        db.execute("""
            CREATE TABLE IF NOT EXISTS CowProduction( 
                id           INTEGER UNIQUE PRIMARY KEY,
                cow_id       INTEGER                                NOT NULL,
                volume       REAL                                   NOT NULL,
                date         INTEGER                                NOT NULL,
                day_period   INTEGER CHECK(day_period IN (1, 2, 3)) NOT NULL,
                discard      INTEGER CHECK(discard IN (0, 1))       NOT NULL,
                observation  TEXT,

                FOREIGN KEY(cow_id) REFERENCES Bovine(id)
            );
        """);
    }

    Future<bool> recordCowMilkProduction(Cow c, CowMilkProduction m) async {
        Database db = DatabaseConnector.db!;

        try {
            m.id = await db.insert(
                'CowProduction',
                {
                    'cow_id': c.id,
                    'volume': m.volume,
                    'date': m.date.millisecondsSinceEpoch,
                    'day_period': m.period.index + 1,
                    'discard': m.discard ? 1 : 0,
                    'observation': m.observation
                }
            );

            return true;
        } catch (e) {
            /* TODO: Log Error. */
            print(e);
            return Future(() => false);
        }
    }
}
