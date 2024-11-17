import 'package:integrazoo/persistence/reproduction_persistence.dart';

import 'package:integrazoo/database/database.dart';


class ReproductionController {
  ReproductionController();

  static Future<void> registerArtificialInseminationAttempt(Reproduction attempt) {
    return ReproductionPersistence.registerArtificialInseminationAttempt(attempt);
  }

  static Future<void> registerCoverageAttempt(Reproduction attempt) {
    return ReproductionPersistence.registerCoverageAttempt(attempt);
  }

  static Future<List<Reproduction>> getArtificialInseminationAttemptsFromCow(Bovine c, int pageSz, int page) {
    return ReproductionPersistence.getArtificialInseminationsFromCow(c, pageSz, page);
  }

  static Future<List<Reproduction>> getCoveragesFromCow(Bovine c, int pageSz, int page) {
    return ReproductionPersistence.getCoveragesFromCow(c, pageSz, page);
  }
}
