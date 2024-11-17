// import 'package:flutter/material.dart';
//
// import 'package:integrazoo/base.dart';
//
// import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';
//
// import 'package:integrazoo/control/bovine_controller.dart';
// import 'package:integrazoo/control/dry_treatment_controller.dart';
//
// import 'package:integrazoo/model/bovine/cow.dart';
// import 'package:integrazoo/model/health/dry_treatment.dart';
//
//
// class DryTreatmentForm extends StatefulWidget {
//   const DryTreatmentForm({ super.key });
//
//   @override
//   State<DryTreatmentForm> createState() => _DryTreatmentFormState();
// }
//
// class _DryTreatmentFormState extends State<DryTreatmentForm> {
//   final _formKey = GlobalKey<FormState>();
//   Cow selectedCow = Cow(0, "UNKNOWN");
//   DryTreatment dryTreatment = DryTreatment(0, "UNKNOWN", DateTime.now(), Duration.zero);
//
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
//     final medicineField = TextFormField(
//       keyboardType: TextInputType.text,
//       decoration: const InputDecoration(hintText: 'Exemplo: Rilexine 500',
//                                         border: OutlineInputBorder(),
//                                         label: Text("Nome do Medicamento"),
//                                         floatingLabelBehavior: FloatingLabelBehavior.always),
//       onSaved: (value) {
//         dryTreatment.medicine = value ?? dryTreatment.medicine;
//       },
//     );
//
//     final restingField = TextFormField(
//       keyboardType: TextInputType.number,
//       decoration: const InputDecoration(hintText: 'Exemplo: 10',
//                                         border: OutlineInputBorder(),
//                                         label: Text("Número de Dias de Descanso"),
//                                         floatingLabelBehavior: FloatingLabelBehavior.always),
//       onSaved: (value) {
//         dryTreatment.restingTime = Duration(days: int.tryParse(value ?? "0") ?? dryTreatment.restingTime.inDays);
//       },
//     );
//
//     final dateSelector = InputDatePickerFormField(
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//       keyboardType: TextInputType.text,
//       fieldLabelText: "Data da Secagem",
//       onDateSaved: (value) {
//         dryTreatment.dryingDate = value;
//       },
//     );
//
//     final saveButton = Row(children: [
//       Expanded(
//         child: ElevatedButton(
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               _formKey.currentState?.save();
//
//               DryTreatmentController.initiateTreatment(selectedCow, dryTreatment).then(
//                 (_) {
//                   SnackBar snackBar = const SnackBar(
//                     content: Text('TRATAMENTO REGISTRADO.'),
//                     showCloseIcon: true
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                   Navigator.of(context).pop();
//                 },
//                 onError: (e) => setState(() => exception = e)
//               );
//             }
//           },
//           child: const Text('INICIAR TRATAMENTO')
//         )
//       )
//     ]);
//
//     return IntegrazooBaseApp(body: FutureBuilder<List<Cow>?>(
//       future: BovineController.readCows(),
//       builder: (context, AsyncSnapshot<List<Cow>?> snapshot) {
//         if (snapshot.hasData) {
//           final cows = snapshot.data!;
//
//           if (cows.isEmpty) {
//             return const Center(child: Text('Nenhum animal encontrado no rebanho.'));
//           }
//
//           selectedCow = cows[0];
//
//           final cowSelector = DropdownMenu<Cow>(
//             dropdownMenuEntries: cows.map((cow) => DropdownMenuEntry(value: cow, label: '[${cow.id}] ${cow.name}')).toList(),
//             onSelected: (value) {
//               selectedCow = value ?? selectedCow;
//             },
//             label: const Text('Vaca'),
//             expandedInsets: EdgeInsets.zero,
//             menuHeight: 300,
//             inputDecorationTheme: const InputDecorationTheme(
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               border: OutlineInputBorder()
//             ),
//             initialSelection: cows[0],
//           );
//
//           Divider divider = const Divider(height: 8, color: Colors.transparent);
//
//           return Container(
//             padding: const EdgeInsets.all(8.0),
//             child: Form(
//               autovalidateMode: AutovalidateMode.always,
//               key: _formKey,
//               child: Column(children: [
//                 cowSelector,
//                 divider,
//                 medicineField,
//                 divider,
//                 restingField,
//                 divider,
//                 dateSelector,
//                 saveButton
//               ])
//             )
//           );
//         } else {
//           return const CircularProgressIndicator();
//         }
//       })
//     );
//   }
// }
//
