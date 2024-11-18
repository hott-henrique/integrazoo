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

  static Future<List<Reproduction>> getReproductionsFromCow(int bovineId, int pageSz, int page) {
    return ReproductionPersistence.getReproductionsFromCow(bovineId, pageSz, page);
  }

  static Future<List<Reproduction>> getArtificialInseminationAttemptsFromCow(int bovineId, int pageSz, int page) {
    return ReproductionPersistence.getArtificialInseminationsFromCow(bovineId, pageSz, page);
  }

  static Future<List<Reproduction>> getCoveragesFromCow(int bovineId, int pageSz, int page) {
    return ReproductionPersistence.getCoveragesFromCow(bovineId, pageSz, page);
  }

  static Future<void> confirmPregnancy(int reproductionId, SuccessfulReproduction s, Pregnancy p) {
    return ReproductionPersistence.confirmPregnancy(reproductionId, s, p);
  }
}
