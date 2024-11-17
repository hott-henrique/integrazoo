import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/bovine/bovine_dropdown.dart';
import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';
import 'package:integrazoo/control/semen_controller.dart';


class ArtificialInseminationForm extends StatefulWidget {
  const ArtificialInseminationForm({ super.key });

  @override
  State<ArtificialInseminationForm> createState() => _ArtificialInseminationFormState();
}

class _ArtificialInseminationFormState extends State<ArtificialInseminationForm> {
  final _formKey = GlobalKey<FormState>();

  int cowId = 0;
  int semenId = 0;
  DateTime artificialInseminationDate = DateTime.now();
  String semenNumber = "";
  String bullName = "";

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      inspect(exception);
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    const divider = Divider(height: 8, color: Colors.transparent);

    final datePicker = InputDatePickerFormField(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data",
      onDateSaved: (value) => artificialInseminationDate = value,
    );

    final semenField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(hintText: 'Exemplo: 123-456-789',
                                        border: OutlineInputBorder(),
                                        label: Text("Sêmen"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => semenNumber = value ?? semenNumber
    );

    final bullNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(hintText: 'Exemplo: Soberano',
                                        border: OutlineInputBorder(),
                                        label: Text("Nome do Touro"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => bullName = value ?? bullName,
    );

    final cowDropdown = BovineDropdown(
      future: BovineController.readCows(),
      label: "Vaca",
      onSelected: (value) => cowId = value != null ? value.id : 0
    );

    final saveButton = Button(text: "Salvar", color: Colors.green[400]!, onPressed: registerArtificialInsemination);

    final column = <Widget>[
      cowDropdown,
      divider,
      semenField,
      divider,
      bullNameField,
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

  void registerArtificialInsemination() {
    if (cowId == 0) {
      SnackBar snackBar = const SnackBar(
        content: Text('Por favor, selecione a vaca.'),
        backgroundColor: Colors.red,
        showCloseIcon: true
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final semen = Semen.fromJson({
        'semenNumber': semenNumber,
        'bullName': bullName,
      });

      SemenController.insertSemen(semen).then(
        (value) => registerArtificialInseminationAttempt()
      );
    }
  }

  void registerArtificialInseminationAttempt() {
    final reproduction = Reproduction.fromJson({
      'id': 0,
      'kind': ReproductionKind.artificialInsemination.index,
      'diagnostic': ReproductionDiagonostic.waiting.index,
      'date': artificialInseminationDate,
      'cow': cowId,
      'bull': 0,
      'semen': semenNumber,
    });

    ReproductionController.registerArtificialInseminationAttempt(reproduction).then(
      (_) {
        SnackBar snackBar = const SnackBar(
          content: Text('Tentativa de reprodução registrada.'),
          backgroundColor: Colors.green,
          showCloseIcon: true
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop();
        }
      },
      onError: (e) => setState(() => exception = e)
    );
  }
}
