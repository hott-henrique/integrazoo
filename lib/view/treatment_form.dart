import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/treatment_controller.dart';

import 'package:integrazoo/model/cow.dart';
import 'package:integrazoo/model/treatment.dart';

class TreatmentForm extends StatefulWidget {
  const TreatmentForm({super.key});

  @override
  State<TreatmentForm> createState() => _TreatmentFormState();
}

class _TreatmentFormState extends State<TreatmentForm> {
  final _formKey = GlobalKey<FormState>();
  Cow selectedCow = Cow(0, "UNKNOWN");
  Treatment treatment = Treatment(
      0,
      "UNKNOWN",
      "UNKNOWN",
      DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(const Duration(days: 1))),
      Duration.zero);

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(
          title: 'Erro Inesperado',
          message:
              'Algo de inespearado aconteceu durante a execução do aplicativo.',
          onPressed: () => setState(() => exception = null));
    }

    final reasonField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: 'Exemplo: Picada de cascavél.',
          border: OutlineInputBorder(),
          label: Text("Razão do Tratmento"),
          floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => treatment.reason = value ?? treatment.reason,
    );

    final medicineNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: 'Exemplo: Flunixin Meglumine',
          border: OutlineInputBorder(),
          label: Text("Nome do Medicamento"),
          floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => treatment.medicine = value ?? treatment.medicine,
    );

    final startingDateField = InputDatePickerFormField(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data Inicial do Tratamento",
      onDateSaved: (value) => treatment.period =
          DateTimeRange(start: value, end: treatment.period.end),
    );

    final endingDateField = InputDatePickerFormField(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year + 10),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data Final do Tratamento",
      onDateSaved: (value) => treatment.period =
          DateTimeRange(start: treatment.period.start, end: value),
    );

    final restingDurationField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          hintText: 'Exemplo: 5',
          border: OutlineInputBorder(),
          label: Text("Número de Dias de Descanso"),
          floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => treatment.restingTime = Duration(
          days: int.tryParse(value ?? "0") ?? treatment.restingTime.inDays),
    );

    final saveButton = Row(children: [
      Expanded(
          child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  TreatmentController.initiateTreatment(selectedCow, treatment)
                      .then((_) {
                    SnackBar snackBar = const SnackBar(
                        content: Text('TRATAMENTO REGISTRADO.'),
                        showCloseIcon: true);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.of(context).pop();
                  }, onError: (e) => setState(() => exception = e));
                }
              },
              child: const Text('INICIAR TRATAMENTO')))
    ]);

    return IntegrazooBaseApp(
        body: FutureBuilder<List<Cow>>(
            future: BovineController.readCows(),
            builder: (context, AsyncSnapshot<List<Cow>> snapshot) {
              if (snapshot.hasData) {
                final cows = snapshot.data!;

                if (cows.isEmpty) {
                  return const Center(
                      child: Text('Nenhum animal encontrado no rebanho.'));
                }

                selectedCow = cows[0];

                final cowSelector = DropdownMenu<Cow>(
                    initialSelection: cows[0],
                    dropdownMenuEntries: cows
                        .map((cow) => DropdownMenuEntry(
                            value: cow, label: '[${cow.id}] ${cow.name}'))
                        .toList(),
                    onSelected: (value) => selectedCow = value ?? selectedCow,
                    label: const Text('Vaca'),
                    expandedInsets: EdgeInsets.zero,
                    menuHeight: 300,
                    inputDecorationTheme: const InputDecorationTheme(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder()));

                Divider divider =
                    const Divider(height: 8, color: Colors.transparent);

                return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: _formKey,
                        child: Column(children: [
                          cowSelector,
                          divider,
                          reasonField,
                          divider,
                          medicineNameField,
                          divider,
                          startingDateField,
                          divider,
                          endingDateField,
                          divider,
                          restingDurationField,
                          saveButton
                        ])));
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
