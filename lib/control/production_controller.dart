import 'package:integrazoo/persistence/production_persistence.dart';

import 'package:integrazoo/database/database.dart';
import 'package:tuple_dart/tuple_dart.dart';


class ProductionController {
  ProductionController();

  static Future<void> recordMilkProduction(int bovineId, Production p) async {
    return ProductionPersistence.recordMilkProduction(bovineId, p);
  }

  static Future<List<Production>> getMilkProduction(int bovineId, int pageSize, int page) async {
    return ProductionPersistence.getMilkProduction(bovineId, pageSize, page);
  }

  static Future<List<Tuple2<DateTime, double>>> getAverageProductionInLast30d(int bovineId) async {
    return ProductionPersistence.getAverageProductionInLast30d(bovineId);
  }

  static Future<List<Tuple2<DateTime, double>>> getYTDProduction(int bovineId) async {
    return ProductionPersistence.getYTDProduction(bovineId);
  }
}
