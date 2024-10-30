import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/persistence/bovine_persistence.dart';
import 'package:integrazoo/persistence/cow_production_persistence.dart';
import 'package:integrazoo/persistence/dry_treatment_persistence.dart';
import 'package:integrazoo/persistence/treatment_persistence.dart';
import 'package:integrazoo/persistence/reproduction_persistence.dart';
import 'package:integrazoo/persistence/semen_persistence.dart';


class DatabaseConnector {
  static final DatabaseConnector _singleton = DatabaseConnector._internal();

  static Database? db;
  static bool _isDBOpened = false;

  factory DatabaseConnector() {
    return _singleton;
  }

  DatabaseConnector._internal();

  static connectToDatabase(Database db) {
    _isDBOpened = true;
    DatabaseConnector.db = db;
  }

  static isConnected() => DatabaseConnector._isDBOpened;

  static onCreate(Database db, int version) {
    BovinePersistence.onDatabaseCreate(db, version);
    CowProductionPersistence.onDatabaseCreate(db, version);
    DryTreatmentPersistence.onDatabaseCreate(db, version);
    TreatmentPersistence.onDatabaseCreate(db, version);
    ReproductionPersistence.onDatabaseCreate(db, version);
    SemenPersistence.onDatabaseCreate(db, version);
  }
}
