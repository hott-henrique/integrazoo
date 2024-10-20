import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/main.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow_milk_production.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/day_period.dart';


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

    Future<void> recordCowMilkProduction(Cow c, CowMilkProduction m) async {
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
        } catch (e) {
          return Future.error(e);
        }
    }

    Future<List<CowMilkProduction>> getMilkProduction(Cow c) async {
      Database db = DatabaseConnector.db!;

        try {
            final data = await db.query(
              "CowProduction",
              columns: [ "id", "date", "volume", "day_period", "discard", "observation" ],
              where: 'cow_id = ?',
              whereArgs: [ c.id ]
            );

            return data.map((e) {
              return CowMilkProduction(
                e['id'] as int,
                e['volume'] as double,
                DateTime.fromMillisecondsSinceEpoch(e['date'] as int),
                DayPeriodIZ.values[e['day_period'] as int],
                (e['discard'] as int) == 1 ? true : false,
                e['observation'] as String
              );
            }).toList();
        } catch (e) {
          return Future.error(e);
        }
    }
}
