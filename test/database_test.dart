import 'package:flutter_test/flutter_test.dart';
import 'package:integrazoo/database/database.dart';
import 'package:integrazoo/persistence/bovine_persistence.dart';
import 'package:integrazoo/persistence/production_persistence.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  late AppDatabase database;
  
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  
  setUp(() async {
    database = AppDatabase();
  });

  tearDown(() async {
    await database.close();
  });

  group('testing connection with database using drift', () {
    test('production functions', () async {
      const bovine = Bovine(id: 1, name: 'Test Bovine', sex: Sex.female);
      final production = Production(id: 1, volume: 10.2, dayPeriod: ProductionDayPeriod.afternon, date: DateTime.now(), discard: false, cow: 1);

      await BovinePersistence.createBovine(bovine);
      await ProductionPersistence.recordMilkProduction(bovine.id, production);
      
      final productions = await ProductionPersistence.getMilkProduction(bovine.id, 10, 0);

      expect(productions.isNotEmpty, true);
      expect(productions[0].volume, 10.2);
      // await ProductionPersistence.getAverageProductionInLast30d(bovine.id);
    });
  });
}
