import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';

import 'package:integrazoo/model/bovine/bull.dart';
import 'package:integrazoo/model/bovine/cow.dart';
import 'package:integrazoo/model/reproduction/coverage_attempt.dart';
import 'package:integrazoo/model/reproduction/attempt.dart';


class CoverageForm extends StatefulWidget {
  const CoverageForm({ super.key });

  @override
  State<CoverageForm> createState() => _CoverageFormState();
}

class _CoverageFormState extends State<CoverageForm> {
  final _formKey = GlobalKey<FormState>();

  CoverageAttempt coverageAttempt = CoverageAttempt(0, Cow(0, "UNKNOWN"), Bull(0, "UNKNOWN"), DateTime.now(), ReproductionDiagonostic.waiting);

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final dateField = InputDatePickerFormField(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data",
      onDateSaved: (value) => coverageAttempt.date = value,
    );

  final saveButton = Row(children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            ReproductionController.registerCoverageAttempt(coverageAttempt).then(
              (_) {
                SnackBar snackBar = const SnackBar(content: Text('TENTATIVA DE REPRODUÇÃO REGISTRADA.'), showCloseIcon: true);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).pop();
              },
              onError: (e) => setState(() => exception = e)
            );
          }
        },
        child: const Text('REGISTRAR TENTATIVA')
      )
    )
  ]);

    return IntegrazooBaseApp(body:
      FutureBuilder<dynamic>(
        future: fetchAnimals(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final List<Cow> cows = snapshot.data[0]!;
            final List<Bull> bulls = snapshot.data[1]!;

            if (cows.isEmpty) {
              return const Center(child: Text('Nenhuma vaca encontrada no rebanho.'));
            }

            if (bulls.isEmpty) {
              return const Center(child: Text('Nenhum boi encontrado no rebanho.'));
            }

            coverageAttempt.cow = cows[0];
            coverageAttempt.bull = bulls[0];

            final cowSelector = DropdownMenu<Cow>(
              initialSelection: cows[0],
              dropdownMenuEntries: cows.map((cow) => DropdownMenuEntry(value: cow, label: '[${cow.id}] ${cow.name}')).toList(),
              onSelected: (value) => coverageAttempt.cow = value ?? coverageAttempt.cow,
              label: const Text('Vaca'),
              expandedInsets: EdgeInsets.zero,
              menuHeight: 300,
              inputDecorationTheme: const InputDecorationTheme(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder()
              )
            );

            final bullSelector = DropdownMenu<Bull>(
              initialSelection: bulls[0],
              dropdownMenuEntries: bulls.map((bull) => DropdownMenuEntry(value: bull, label: '[${bull.id}] ${bull.name}')).toList(),
              onSelected: (value) => coverageAttempt.bull = value ?? coverageAttempt.bull,
              label: const Text('Vaca'),
              expandedInsets: EdgeInsets.zero,
              menuHeight: 300,
              inputDecorationTheme: const InputDecorationTheme(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder()
              )
            );

            Divider divider = const Divider(height: 8, color: Colors.transparent);

            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Column(children: [
                  cowSelector,
                  divider,
                  bullSelector,
                  divider,
                  dateField,
                  saveButton
                ])
              )
            );
          } else {
            return const CircularProgressIndicator();
          }
        })
    );
  }

  Future<dynamic> fetchAnimals() async {
    return [ await BovineController.readCows(), await BovineController.readBulls() ];
  }
}
