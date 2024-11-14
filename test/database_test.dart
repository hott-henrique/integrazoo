import 'package:flutter_test/flutter_test.dart';
import 'package:integrazoo/model/bovine/bovine.dart';
import 'package:integrazoo/persistence/bovine_persistence.dart';
import 'package:integrazoo/persistence/database_connector.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  late Database database;
  
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  
  setUp(() async {
    database = await openDatabase(inMemoryDatabasePath);
    await BovinePersistence.onDatabaseCreate(database, 1);
    DatabaseConnector.db = database;
  });

  tearDown(() async {
    await database.close();
  });

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
}
