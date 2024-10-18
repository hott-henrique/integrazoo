import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/reproduction_attempt.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/semen.dart';


class ArtificialInseminationAttempt extends ReproductionAttempt {
  Semen semen;

  ArtificialInseminationAttempt._(super.id, super.cow, this.semen, super.date, super.kind, super.diagnostic);

  factory ArtificialInseminationAttempt(int id, Cow cow, Semen semen, DateTime date, ReproductionDiagonostic diagnostic) {
    return ArtificialInseminationAttempt._(id, cow, semen, date, ReproductionKind.artificialInsemination, diagnostic);
  }
}
