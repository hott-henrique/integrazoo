import 'package:integrazoo/persistence/production_persistence.dart';

import 'package:integrazoo/database/database.dart';


class ProductionController {
  ProductionController();

  static Future<void> recordMilkProduction(int bovineId, Production p) async {
    return ProductionPersistence.recordMilkProduction(bovineId, p);
  }

  static Future<List<Production>> getMilkProduction(int bovineId, int pageSize, int page) async {
    return ProductionPersistence.getMilkProduction(bovineId, pageSize, page);
  }

  static Future<List<Map<DateTime, double>>> getAverageProductionInLast30d(int bovineId) async {
    return ProductionPersistence.getAverageProductionInLast30d(bovineId);
  }
}
