import 'package:integrazoo/dairy_cattle_subsystem/persistence/central_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/artificial_insemination_attempt.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/coverage_attempt.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';


class ReproductionController {
  CentralPersistence persistence;

  ReproductionController(this.persistence);

  Future<void> registerCoverageAttempt(CoverageAttempt attempt) {
    return persistence.reproductionPersistence.registerCoverageAttempt(attempt);
  }

  Future<void> registerArtificialInseminationAttempt(ArtificialInseminationAttempt attempt) {
    return persistence.reproductionPersistence.registerArtificialInseminationAttempt(attempt);
  }

  Future<List<ArtificialInseminationAttempt>> getAllArtificialInseminationAttemptFromCow(Cow c) {
    return persistence.reproductionPersistence.getAllArtificialInseminationAttemptFromCow(c);
  }
}
