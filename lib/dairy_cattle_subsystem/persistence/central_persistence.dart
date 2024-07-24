import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/dairy_cattle_subsystem/persistence/bovine_persistence.dart';
import 'package:integrazoo/dairy_cattle_subsystem/persistence/cow_production_persistence.dart';
import 'package:integrazoo/dairy_cattle_subsystem/persistence/herd_production_persistence.dart';
import 'package:integrazoo/dairy_cattle_subsystem/persistence/dry_treatment_persistence.dart';
import 'package:integrazoo/dairy_cattle_subsystem/persistence/treatment_persistence.dart';
import 'package:integrazoo/dairy_cattle_subsystem/persistence/reproduction_persistence.dart';

class CentralPersistence {
  BovinePersistence bovinePersistence;
  CowProductionPersistence cowProductionPersistence;
  HerdProductionPersistence herdProductionPersistence;
  DryTreatmentPersistence dryTreatmentPersistence;
  TreatmentPersistence treatmentPersistence;
  ReproductionPersistence reproductionPersistence;

  CentralPersistence(this.bovinePersistence,
                     this.cowProductionPersistence,
                     this.herdProductionPersistence,
                     this.dryTreatmentPersistence,
                     this.treatmentPersistence,
                     this.reproductionPersistence);

  static onDatabaseCreate(Database db, int version) {
    BovinePersistence.onDatabaseCreate(db, version);
    CowProductionPersistence.onDatabaseCreate(db, version);
    HerdProductionPersistence.onDatabaseCreate(db, version);
    DryTreatmentPersistence.onDatabaseCreate(db, version);
    TreatmentPersistence.onDatabaseCreate(db, version);
    ReproductionPersistence.onDatabaseCreate(db, version);
  }
}
