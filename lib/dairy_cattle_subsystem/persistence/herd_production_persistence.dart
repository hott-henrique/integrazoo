import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/main.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/herd_milk_production.dart';


class HerdProductionPersistence {
    HerdProductionPersistence();

    static onDatabaseCreate(Database db, int version) {
        db.execute("""
            CREATE TABLE IF NOT EXISTS HerdProduction( 
                id           INTEGER UNIQUE PRIMARY KEY,
                volume       REAL                                   NOT NULL,
                date         INTEGER                                NOT NULL,
                day_period   INTEGER CHECK(day_period IN (1, 2, 3)) NOT NULL,
                discarded    REAL                                   NOT NULL,
                observation  TEXT
            );
        """);
    }

    Future<void> recordHerdMilkProduction(HerdMilkProduction p) async {
        Database db = DatabaseConnector.db!;
        try {
            p.id = await db.insert(
                'HerdProduction',
                {
                    'volume': p.volume,
                    'date': p.date.millisecondsSinceEpoch,
                    'day_period': p.period.index + 1,
                    'discarded': p.discarded,
                    'observation': p.observation
                }
            );
        } catch (e) {
          return Future.error(e);
        }
    }
}
