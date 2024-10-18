import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';


enum ReproductionDiagonostic {
  positive,
  negative,
  waiting;

  @override
  String toString() {
    switch (this) {
      case positive:
        return 'Prenhes Confirmada';

      case negative:
        return 'Prenhes Falhou';

      case waiting:
        return 'Esperando Diagnóstico';
    }
  }
}

enum ReproductionKind {
  artificialInsemination,
  coverage;

  @override
  String toString() {
    switch (this) {
      case artificialInsemination:
        return 'Inseminação Artificial';

      case coverage:
        return 'Monta';
    }
  }
}

class ReproductionAttempt {
  int id;
  Cow cow;
  DateTime date;
  ReproductionKind kind;
  ReproductionDiagonostic diagnostic;

  ReproductionAttempt(this.id, this.cow, this.date, this.kind, this.diagnostic);
}
