import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/bovine/bovine_dropdown.dart';
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

  int cowId = 0;
  int bullId = 0;
  DateTime coverageDate = DateTime.now();

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      inspect(exception);
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    Divider divider = const Divider(height: 8, color: Colors.transparent);

    final cowDropdown = BovineDropdown(
      future: BovineController.readCows(),
      label: "Vaca",
      onSelected: (value) => cowId = value != null ? value.id : 0
    );

    final bullDropdown = BovineDropdown(
      future: BovineController.readBulls(),
      label: "Boi",
      onSelected: (value) => bullId = value != null ? value.id : 0
    );

    final datePicker = InputDatePickerFormField(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data",
      onDateSaved: (value) => coverageDate = value,
    );

    final saveButton = Button(text: "Salvar", color: Colors.green[400]!, onPressed: saveCoverage);

    final column = <Widget>[
      cowDropdown,
      divider,
      bullDropdown,
      divider,
      datePicker,
      saveButton
    ];

    return IntegrazooBaseApp(body: Container(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
      )
    ));
  }

  void saveCoverage() {
    if (bullId == 0 || cowId == 0) {
      SnackBar snackBar = const SnackBar(
        content: Text('Por favor, selecione os animais.'),
        backgroundColor: Colors.red,
        showCloseIcon: true
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final reproduction = Reproduction.fromJson({
        'id': 0,
        'kind': ReproductionKind.coverage.index,
        'diagnostic': ReproductionDiagonostic.waiting.index,
        'date': coverageDate,
        'cow': cowId,
        'bull': bullId,
        'semen': "",
      });
      ReproductionController.registerCoverageAttempt(reproduction).then(
        (_) {
          SnackBar snackBar = const SnackBar(
            content: Text('Tentativa de reprodução registrada.'),
            backgroundColor: Colors.green,
            showCloseIcon: true
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop();
        },
        onError: (e) => setState(() => exception = e)
      );
    }
  }
}
