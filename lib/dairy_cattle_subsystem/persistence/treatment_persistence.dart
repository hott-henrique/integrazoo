import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/main.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/bovine.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/treatment.dart';


class TreatmentPersistence {
  TreatmentPersistence();

  static onDatabaseCreate(Database db, int version) {
    db.execute("""
      CREATE TABLE IF NOT EXISTS Treatment(
        id            INTEGER UNIQUE PRIMARY KEY,
        bovine_id     INTEGER                                NOT NULL,
        reason        TEXT                                   NOT NULL,
        medicine      TEXT                                   NOT NULL,
        starting_date INTEGER                                NOT NULL,
        ending_date   INTEGER                                NOT NULL,
        resting_time  INTEGER                                NOT NULL,
        release_date  INTEGER                                NOT NULL,

        FOREIGN KEY(bovine_id) REFERENCES Bovine(id)
      );
    """);
  }

  Future<void> initiateTreatment(Bovine b, Treatment t) async {
    Database db = DatabaseConnector.db!;

    try {
      t.id = await db.insert(
        'Treatment',
        {
          'bovine_id': b.id,
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

  Future<List<Treatment>> getTreatments(Bovine b) async {
    Database db = DatabaseConnector.db!;

    try {
      final data = await db.query(
        'Treatment',
        where: 'bovine_id = ?',
        whereArgs: [ b.id ]
      );

      if (data.isEmpty) {
        return List.empty();
      }

      return data.map((e) {
        return Treatment(
          e['id'] as int,
          e['reason'] as String,
          e['medicine'] as String,
          DateTimeRange(
            start: DateTime.fromMillisecondsSinceEpoch(e['starting_date'] as int),
            end: DateTime.fromMillisecondsSinceEpoch(e['ending_date'] as int),
          ),
          Duration(days: e['resting_time'] as int)
        );
      }).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}
