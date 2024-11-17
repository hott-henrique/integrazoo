// import 'package:integrazoo/model/bovine/cow.dart';
//
//
// enum ReproductionDiagonostic {
//   positive,
//   negative,
//   waiting;
//
//   @override
//   String toString() {
//     switch (this) {
//       case positive:
//         return 'Positivo';
//
//       case negative:
//         return 'Negativo';
//
//       case waiting:
//         return 'Esperando';
//     }
//   }
// }
//
// enum ReproductionKind {
//   artificialInsemination,
//   coverage;
//
//   @override
//   String toString() {
//     switch (this) {
//       case artificialInsemination:
//         return 'Inseminação Artificial';
//
//       case coverage:
//         return 'Monta';
//     }
//   }
// }
//
// class ReproductionAttempt {
//   int id;
//   Cow cow;
//   DateTime date;
//   ReproductionKind kind;
//   ReproductionDiagonostic diagnostic;
//
//   ReproductionAttempt(this.id, this.cow, this.date, this.kind, this.diagnostic);
// }
//
