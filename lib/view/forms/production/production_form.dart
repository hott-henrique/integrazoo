import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/bovine/bovine_dropdown.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/production_controller.dart';

import 'package:integrazoo/database/database.dart';


class ProductionForm extends StatefulWidget {
  const ProductionForm({ super.key });

  @override
  State<ProductionForm> createState() => _ProductionFormState();
}

class _ProductionFormState extends State<ProductionForm> {
  final _formKey = GlobalKey<FormState>();

  int cowId = 0;

  double productionVolume = 0.0;
  DateTime productionDate = DateTime.now();
  bool productionDiscard = false;
  ProductionDayPeriod productionDayPeriod = ProductionDayPeriod.morning;
  String productionObservation = "";

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      inspect(exception);
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final datePicker = InputDatePickerFormField(
      initialDate: productionDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data",
      onDateSubmitted: (value) => productionDate = value,
      onDateSaved: (value) => productionDate = value,
    );

    final periodDropdown = DropdownMenu<ProductionDayPeriod>(
      initialSelection: productionDayPeriod,
      dropdownMenuEntries: ProductionDayPeriod.values.map((period) => DropdownMenuEntry(value: period, label: period.toString())).toList(),
      onSelected: (value) => setState(() => productionDayPeriod = value!),
      label: const Text('Período do Dia'),
      expandedInsets: EdgeInsets.zero,
    );

    final saveButton = Button(text: "Salvar", color: Colors.green[400]!, onPressed: saveProduction);

    Divider divider = const Divider(color: Colors.transparent);

    final cowDropdown = BovineDropdown(
      future: BovineController.readCows(),
      label: "Vaca",
      onSelected: (value) => cowId = value != null ? value.id : 0
    );

    final volumeField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(hintText: 'Exemplo: 12',
                                        border: OutlineInputBorder(),
                                        label: Text("Volume"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => productionVolume = double.tryParse(value ?? "0") ?? 0
    );

    final observationField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(hintText: 'Exemplo: Vaca tentou dar coice.',
                                        border: OutlineInputBorder(),
                                        label: Text("Observação"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => productionObservation = value ?? productionObservation
    );

    final discardCheckbox = Row(children: [
      Checkbox(
        value: productionDiscard,
        activeColor: Colors.redAccent,
        side: const BorderSide(color: Colors.redAccent),
        onChanged: (value) => setState(() => productionDiscard = value ?? false)
      ),
      const Expanded(child: Text('Descartar leite.', style: TextStyle(color: Colors.redAccent))),
    ]);

    final column = <Widget>[
      cowDropdown,
      divider,
      datePicker,
      divider,
      periodDropdown,
      divider,
      volumeField,
      divider,
      observationField,
      discardCheckbox,
      saveButton
    ];

    return IntegrazooBaseApp(body: Container(
      padding: const EdgeInsets.all(8),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
      )
    ));
  }

  void saveProduction() {
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
      _formKey.currentState?.save();

      final production = Production.fromJson({
        'id': 0,
        'cow': 0,
        'date': productionDate,
        'dayPeriod': productionDayPeriod.index,
        'discard': productionDiscard,
        'volume': productionVolume,
      });

      ProductionController.recordMilkProduction(cowId, production).then(
        (_) {
          if (context.mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Produção registrada.'),
              backgroundColor: Colors.green,
              showCloseIcon: true
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).pop();
          }
        },
        onError: (e) => setState(() => exception = e)
      );
    }
  }
}
