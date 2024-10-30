import 'package:integrazoo/persistence/reproduction_persistence.dart';

import 'package:integrazoo/model/artificial_insemination_attempt.dart';
import 'package:integrazoo/model/coverage_attempt.dart';
import 'package:integrazoo/model/cow.dart';


class ReproductionController {
  ReproductionController();

  static Future<void> registerCoverageAttempt(CoverageAttempt attempt) {
    return ReproductionPersistence.registerCoverageAttempt(attempt);
  }

  static Future<void> registerArtificialInseminationAttempt(ArtificialInseminationAttempt attempt) {
    return ReproductionPersistence.registerArtificialInseminationAttempt(attempt);
  }

  static Future<List<ArtificialInseminationAttempt>> getAllArtificialInseminationAttemptFromCow(Cow c) {
    return ReproductionPersistence.getAllArtificialInseminationAttemptFromCow(c);
  }
}
