// import 'package:flutter/material.dart';
//
// import 'package:intl/intl.dart';
//
// import 'package:integrazoo/model/reproduction/artificial_insemination_attempt.dart';
//
// import 'package:integrazoo/view/screens/artificial_insemination.dart';
//
// class ArtificialInseminationAttemptListTile extends StatelessWidget {
//   final ArtificialInseminationAttempt attempt;
//
//   const ArtificialInseminationAttemptListTile({ super.key, required this.attempt });
//
//   @override
//   Widget build(BuildContext context) {
//     final DateFormat formatter = DateFormat('dd/MM/yyyy');
//
//     return ListTile(
//       title: const Text('Inseminação Artificial'),
//       subtitle: Text('Vaca: ${attempt.cow.name} - Semen: ${attempt.semen.bullsName} (${attempt.semen.id})'),
//       trailing: Text(formatter.format(attempt.date)),
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(builder: (context) => ArtificialInseminationDetailedScreen(attempt: attempt)));
//       }
//     );
//   }
// }
//
