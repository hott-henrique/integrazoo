import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';

import 'package:integrazoo/database/database.dart';


class CoverageForm extends StatefulWidget {
  const CoverageForm({ super.key });

  @override
  State<CoverageForm> createState() => _CoverageFormState();
}

class _CoverageFormState extends State<CoverageForm> {
  final _formKey = GlobalKey<FormState>();

  //CoverageAttempt coverageAttempt = CoverageAttempt(0, Cow(0, "UNKNOWN"), Bull(0, "UNKNOWN"), DateTime.now(), ReproductionDiagonostic.waiting);
  int cowId = 0;
  int bullId = 0;
  DateTime coverageDate = DateTime.now();

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
      onDateSaved: (value) => coverageDate = value,
    );

  final saveButton = Row(children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            final reproduction = Reproduction.fromJson({
              'id': 0,
              'kind': ReproductionKind.coverage.index,
              'diagnostic': ReproductionDiagonostic.waiting.index,
              'date': coverageDate,
              'cow': cowId,
              'bull': bullId,
              'semen': 0,
            });
            ReproductionController.registerCoverageAttempt(reproduction).then(
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
            final List<Bovine> cows = snapshot.data[0]!;
            final List<Bovine> bulls = snapshot.data[1]!;

            if (cows.isEmpty) {
              return const Center(child: Text('Nenhuma vaca encontrada no rebanho.'));
            }

            if (bulls.isEmpty) {
              return const Center(child: Text('Nenhum boi encontrado no rebanho.'));
            }

            cowId = cows[0].id;
            bullId = bulls[0].id;

            final cowSelector = DropdownMenu<Bovine>(
              initialSelection: cows[0],
              dropdownMenuEntries: cows.map((cow) => DropdownMenuEntry(value: cow, label: '[${cow.id}] ${cow.name}')).toList(),
              onSelected: (value) => cowId = value!.id,
              label: const Text('Vaca'),
              expandedInsets: EdgeInsets.zero,
              menuHeight: 300,
              inputDecorationTheme: const InputDecorationTheme(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder()
              )
            );

            final bullSelector = DropdownMenu<Bovine>(
              initialSelection: bulls[0],
              dropdownMenuEntries: bulls.map((bull) => DropdownMenuEntry(value: bull, label: '[${bull.id}] ${bull.name}')).toList(),
              onSelected: (value) => bullId = value!.id,
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
//
