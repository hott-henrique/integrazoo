import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';


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
    bool diagnostic;


    ReproductionAttempt(this.id, this.cow, this.date, this.kind, this.diagnostic);
}
