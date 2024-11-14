import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/persistence/database_connector.dart';

import 'package:integrazoo/model/bovine/bovine.dart';
import 'package:integrazoo/model/bovine/cow.dart';
import 'package:integrazoo/model/bovine/bull.dart';


class BovinePersistence {
  BovinePersistence();

  static onDatabaseCreate(Database db, int version) {
    db.execute("""
      CREATE TABLE IF NOT EXISTS Bovine(
        id INTEGER UNIQUE PRIMARY KEY,
        name TEXT,
        sex INTEGER /* 0: Male, 1: Female */
      );
    """);
  }

  static Future<List<Bovine>> readHerd() async {
    Database db = DatabaseConnector.db!;
    try {
      final data = await db.query('Bovine');

      return data.map(
        (e) {
          final id = e['id'] as int;
          final name = e['name'] as String;
          final sex = (e['sex'] as int) == 0 ? Sex.male : Sex.female;

          return Bovine(id, name, sex);
        }
      ).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<List<Cow>> readCows() async {
    Database db = DatabaseConnector.db!;
    try {
      final data = await db.query(
        'Bovine',
        where: 'sex = ?',
        whereArgs: [ Sex.female.index ],
        columns: [ 'id', 'name' ]
      );

      return data.map(
        (e) {
            final id = e['id'] as int;
            final name = e['name'] as String;

            return Cow(id, name);
        }
      ).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<List<Bull>> readBulls() async {
    Database db = DatabaseConnector.db!;
    try {
      final data = await db.query(
        'Bovine',
        where: 'sex = ?',
        whereArgs: [ Sex.male.index ],
        columns: [ 'id', 'name' ]
      );

      return data.map(
        (e) {
          final id = e['id'] as int;
          final name = e['name'] as String;

          return Bull(id, name);
        }
      ).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<void> createBovine(Bovine bovine) async {
    Database db = DatabaseConnector.db!;

    try {
      bovine.id = await db.insert(
          'Bovine',
          { 'name': bovine.name, 'sex': bovine.sex.index },
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<void> updateBovine(Bovine bovine) async {
    Database db = DatabaseConnector.db!;

    try {
      await db.update(
        'Bovine',
        { 'name': bovine.name, 'sex': bovine.sex.index },
        where: 'id = ?',
        whereArgs: [bovine.id],
      );

    } catch (e) {
      return Future.error(e);
    }
  }
}
