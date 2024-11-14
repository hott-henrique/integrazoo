import 'package:flutter/src/material/date.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrazoo/model/bovine/bovine.dart';
import 'package:integrazoo/model/health/treatment.dart';
import 'package:integrazoo/persistence/bovine_persistence.dart';
import 'package:integrazoo/persistence/database_connector.dart';
import 'package:integrazoo/persistence/treatment_persistence.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  late Database database;
  
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  
  setUp(() async {
    database = await openDatabase(inMemoryDatabasePath);
    await BovinePersistence.onDatabaseCreate(database, 1);
    await TreatmentPersistence.onDatabaseCreate(database, 1);
    DatabaseConnector.db = database;
  });

  tearDown(() async {
    await database.close();
  });

  group('bovine_persistence tests', () {
    test('Create bovines and list all of them', () async {
        await BovinePersistence.createBovine(Bovine(1, 'Bovine 1', Sex.male));
        await BovinePersistence.createBovine(Bovine(2, 'Bovine 2', Sex.female));
        await BovinePersistence.createBovine(Bovine(3, 'Bovine 3', Sex.male));
    
        final result = await BovinePersistence.readHerd();
        print('===== Bovines in Database =====');
        for (var bovine in result) {
          print('ID: ${bovine.id}, Name: ${bovine.name}, Sex: ${bovine.sex == Sex.male ? 'Male' : 'Female'}');
        }

        expect(result.length, 3);
    });

    test('Update a bovine', () async {
      await BovinePersistence.createBovine(Bovine(1, 'Bovine 1', Sex.male));
      await BovinePersistence.createBovine(Bovine(2, 'Bovine 2', Sex.female));

      Bovine updatedBovine = Bovine(1, 'Updated Bovine 1', Sex.female);
      final id = updatedBovine.id;
      await BovinePersistence.updateBovine(id, updatedBovine);

      final result = await BovinePersistence.readHerd();

      final updatedBovineFromDb = result.firstWhere((bovine) => bovine.id == 1);
      expect(updatedBovineFromDb.name, 'Updated Bovine 1');
      expect(updatedBovineFromDb.sex, Sex.female);

      expect(result.length, 2);
    });
  });

  group('treatment_persistence tests', () {
    test('Update a treatment', () async {
      final bovine = Bovine(1, 'Bovine 1', Sex.male);
      
      final treatment = Treatment(
        bovine.id,
        'Treatment test',
        'Medicine test',
        DateTimeRange(start: DateTime(2024), end: DateTime(2025)),
        const Duration(days: 2)
      );
      await TreatmentPersistence.initiateTreatment(bovine, treatment);

      final updatedTreatment = Treatment(
        bovine.id,
        'Updated Treatment test',
        'Updated Medicine test',
        DateTimeRange(start: DateTime(2025), end: DateTime(2026)),
        const Duration(days: 6)
      );
      await TreatmentPersistence.updateTreatment(bovine.id, updatedTreatment);

      final result = await TreatmentPersistence.getTreatments(bovine);
      
      final updatedTreatmentFromDb = result.firstWhere((bovine) => bovine.id == 1);
      expect(updatedTreatmentFromDb.reason, 'Updated Treatment test');
      expect(updatedTreatmentFromDb.medicine, 'Updated Medicine test');
      expect(updatedTreatmentFromDb.period, DateTimeRange(start: DateTime(2025), end: DateTime(2026)));
      expect(updatedTreatmentFromDb.restingTime, const Duration(days: 6));

      expect(result.length, 1);
    });
  });
}
