// import 'dart:developer';
//
// import 'package:intl/intl.dart';
//
// import 'package:flutter/material.dart';
//
// import 'package:integrazoo/base.dart';
//
// import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';
//
// import 'package:integrazoo/model/reproduction/artificial_insemination_attempt.dart';
// import 'package:integrazoo/view/forms/reproduction/pregnancy.dart';
//
//
// class ArtificialInseminationDetailedScreen extends StatefulWidget {
//   final ArtificialInseminationAttempt attempt;
//
//   const ArtificialInseminationDetailedScreen({ super.key, required this.attempt });
//
//   @override
//   State<ArtificialInseminationDetailedScreen> createState() => _ArtificialInseminationDetailedScreen();
// }
//
// class _ArtificialInseminationDetailedScreen extends State<ArtificialInseminationDetailedScreen> {
//   Exception? exception;
//
//   @override
//   Widget build(BuildContext context) {
//     if (exception != null) {
//       return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
//                                         message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
//                                         onPressed: () => setState(() => exception = null));
//     }
//
//     return FutureBuilder(
//       future: fetchData(),
//       builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
//         if (!snapshot.hasData){
//           return const CircularProgressIndicator();
//         }
//
//         inspect(widget.attempt);
//
//         final dateFormatter = DateFormat("dd/MM/yyyy");
//
//         List<Widget> columnBody = List.empty(growable: true);
//
//         List<Widget> attemptInfoBody = List.empty(growable: true);
//
//         columnBody.add(const Row(children: [ Expanded(child: Text("Inseminação Artificial", textAlign: TextAlign.center)) ]));
//
//         final dateInfo = Card(
//           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Column(children: [
//               Row(children: [
//                 const Expanded(child: Text("Data")),
//                 Expanded(child: Text(dateFormatter.format(widget.attempt.date), textAlign: TextAlign.right)),
//               ])
//             ])
//           )
//         );
//
//         attemptInfoBody.add(dateInfo);
//
//         final cowInfo = Card(
//           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Column(children: [
//               Row(children: [
//                 const Expanded(child: Text("Vaca")),
//                 Expanded(child: Text(widget.attempt.cow.name, textAlign: TextAlign.right)),
//               ]),
//               Row(children: [
//                 const Expanded(child: Text("Brinco")),
//                 Expanded(child: Text(widget.attempt.cow.id.toString(), textAlign: TextAlign.right)),
//               ]),
//             ])
//           )
//         );
//
//         attemptInfoBody.add(cowInfo);
//
//         final semenInfo = Card(
//           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Column(children: [
//               Row(children: [
//                 const Expanded(child: Text("Touro")),
//                 Expanded(child: Text(widget.attempt.semen.bullsName, textAlign: TextAlign.right))
//               ]),
//               Row(children: [
//                 const Expanded(child: Text("Semen")),
//                 Expanded(child: Text(widget.attempt.semen.number, textAlign: TextAlign.right)),
//               ])
//             ])
//           )
//         );
//
//         attemptInfoBody.add(semenInfo);
//
//         final diagnosticInfo = Card(
//           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Column(children: [
//               Row(children: [
//                 const Expanded(child: Text("Diagnóstico")),
//                 Expanded(child: Text(widget.attempt.diagnostic.toString(), textAlign: TextAlign.right)),
//               ]),
//             ])
//           )
//         );
//
//         attemptInfoBody.add(diagnosticInfo);
//
//         columnBody = columnBody + attemptInfoBody;
//
//         columnBody.add(
//           Row(children: [ Expanded(child: TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.green[400],
//               foregroundColor: Colors.white,
//               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))
//             ),
//             child: const Text("Registrar Diagnóstico Positivo"),
//             onPressed: () => {
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) => PregnancyForm(attempt: widget.attempt)))
//             }
//           )) ])
//         );
//
//         columnBody.add(
//           Row(children: [ Expanded(child: TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.red[400],
//               foregroundColor: Colors.white,
//               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))
//             ),
//             child: const Text("Registrar Diagnóstico Negativo"),
//             onPressed: () => {}
//           )) ])
//         );
//
//         return IntegrazooBaseApp(body: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: columnBody)));
//       }
//     );
//   }
//
//   Future<Map<String, dynamic>> fetchData() async {
//     Map<String, dynamic> mappedData = {};
//
//     return Future.value(mappedData);
//   }
// }
//
