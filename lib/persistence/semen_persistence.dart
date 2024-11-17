import 'package:integrazoo/globals.dart';

import 'package:integrazoo/database/database.dart';


class SemenPersistence {
  SemenPersistence();

  static Future<int> insertSemen(Semen s) async {
    return database.into(database.semens).insertOnConflictUpdate(
      SemensCompanion.insert(semenNumber: s.semenNumber, bullName: s.semenNumber)
    );
  }

}
