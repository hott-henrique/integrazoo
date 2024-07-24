import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/main.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/artificial_insemination_attempt.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/coverage_attempt.dart';


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
        diagnostic    INTEGER,

        FOREIGN KEY(cow_id) REFERENCES Bovine(id),
        FOREIGN KEY(bull_id) REFERENCES Bovine(id)
      );
    """);
  }

  Future<void> registerArtificialInseminationAttempt(ArtificialInseminationAttempt attempt) async {
    Database db = DatabaseConnector.db!;

    inspect(attempt);

    try {
      attempt.id = await db.insert(
        'ReproductionAttempt',
        {
          'kind': 1,
          'cow_id': attempt.cow.id,
          'bull_id': null,
          'semen': attempt.semen,
          'date': attempt.date.millisecondsSinceEpoch,
          'diagnostic': null
        }
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> registerCoverageAttempt(CoverageAttempt attempt) async {
    Database db = DatabaseConnector.db!;

    inspect(attempt);

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
}
