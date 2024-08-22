import 'dart:developer';

import 'package:integrazoo/dairy_cattle_subsystem/model/reproduction_attempt.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/semen.dart';
import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/main.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/artificial_insemination_attempt.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/coverage_attempt.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';


class ReproductionPersistence {
  ReproductionPersistence();

  static onDatabaseCreate(Database db, int version) {
    db.execute("""
      CREATE TABLE IF NOT EXISTS ReproductionAttempt(
        id            INTEGER UNIQUE PRIMARY KEY,
        kind          INTEGER                                NOT NULL,
        cow_id        INTEGER                                NOT NULL,
        bull_id       INTEGER,
        semen         INTEGER,
        date          INTEGER                                NOT NULL,
        diagnostic    INTEGER                                NOT NULL,

        FOREIGN KEY(cow_id) REFERENCES Bovine(id),
        FOREIGN KEY(bull_id) REFERENCES Bovine(id)
      );
    """);
  }

  Future<void> registerArtificialInseminationAttempt(ArtificialInseminationAttempt attempt) async {
    Database db = DatabaseConnector.db!;

    try {
      attempt.id = await db.insert(
        'ReproductionAttempt',
        {
          'kind': 1,
          'cow_id': attempt.cow.id,
          'bull_id': null,
          'semen': attempt.semen.id,
          'date': attempt.date.millisecondsSinceEpoch,
          'diagnostic': attempt.diagnostic.index
        }
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> registerCoverageAttempt(CoverageAttempt attempt) async {
    Database db = DatabaseConnector.db!;

    try {
      attempt.id = await db.insert(
        'ReproductionAttempt',
        {
          'kind': 0,
          'cow_id': attempt.cow.id,
          'bull_id': attempt.bull.id,
          'semen': null,
          'date': attempt.date.millisecondsSinceEpoch,
          'diagnostic': null
        }
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<ArtificialInseminationAttempt>> getAllArtificialInseminationAttemptFromCow(Cow c) async {
    Database db = DatabaseConnector.db!;

    try {

      final data = await db.rawQuery("""
        SELECT R.id, R.kind, R.cow_id, R.bull_id, R.semen, R.date, R.diagnostic, S.id AS semen_id, S.number, S.name
        FROM ReproductionAttempt AS R JOIN Semen AS S ON R.semen = S.id
        WHERE R.cow_id = ?;
      """, [ c.id ]);


      return data.map(
        (e) {
          return ArtificialInseminationAttempt(
            e['id'] as int,
            c,
            Semen(e['semen_id'] as int, e['number'] as String, e['name'] as String),
            DateTime.fromMillisecondsSinceEpoch(e['date'] as int),
            ReproductionDiagonostic.values[e['diagnostic'] as int]
          );
        }
      ).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}
