import 'package:integrazoo/dairy_cattle_subsystem/model/bull.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/reproduction_attempt.dart';


class CoverageAttempt extends ReproductionAttempt {
  Bull bull;

  CoverageAttempt._(super.id, super.cow, this.bull, super.date, super.kind, super.diagnostic);

  factory CoverageAttempt(int id, Cow cow, Bull bull, DateTime date, ReproductionDiagonostic diagnostic) {
    return CoverageAttempt._(id, cow, bull, date, ReproductionKind.coverage, diagnostic);
  }
}
