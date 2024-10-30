import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/persistence/database_connector.dart';

import 'package:integrazoo/model/semen.dart';


class SemenPersistence {
  SemenPersistence();

  static onDatabaseCreate(Database db, int version) {
    db.execute("""
      CREATE TABLE IF NOT EXISTS Semen(
        id            INTEGER UNIQUE PRIMARY KEY,
        number        TEXT                                   NOT NULL,
        name          TEXT                                   NOT NULL
      );
    """);
  }

  static Future<void> insertSemen(Semen s) async {
    Database db = DatabaseConnector.db!;
    try {
      s.id = await db.insert(
        'Semen',
        {
          'number': s.number,
          'name': s.bullsName
        }
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<bool> isSemenPresent(Semen s) async {
    Database db = DatabaseConnector.db!;
    try {
      final data = await db.query(
        'Semen',
        where: 'number = ?',
        whereArgs: [ s.number ],
        columns: [ 'id' ],
        limit: 1
      );

      if (data.isNotEmpty) {
        s.id = data[0]['id'] as int;
      }

      return data.isNotEmpty;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<Semen?> getSemenById(int id) async {
    Database db = DatabaseConnector.db!;
    try {
      final data = await db.query(
        'Semen',
        where: 'id = ?',
        whereArgs: [ id ],
        columns: [ 'id', 'number', 'name' ]
      );

      if (data.isEmpty) {
        return null;
      }

      return Semen(data[0]['id'] as int, data[0]['number'] as String, data[0]['name'] as String);
    } catch (e) {
      return Future.error(e);
    }
  }
}
