import 'package:integrazoo/persistence/cow_production_persistence.dart';

import 'package:integrazoo/model/cow.dart';
import 'package:integrazoo/model/cow_milk_production.dart';


class CowProductionController {
  CowProductionController();

  static Future<void> recordCowMilkProduction(Cow c, CowMilkProduction m) async {
    return CowProductionPersistence.recordCowMilkProduction(c, m);
  }

  static Future<List<CowMilkProduction>> getMilkProduction(Cow c) async {
    return CowProductionPersistence.getMilkProduction(c);
  }
}
