import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/database/database.dart';


class BovineDiscardForm extends StatefulWidget {
  final Bovine bovine;

  const BovineDiscardForm({ super.key, required this.bovine });

  @override
  BovineFormState createState() {
    return BovineFormState();
  }
}

class BovineFormState extends State<BovineDiscardForm> {
  final _formKey = GlobalKey<FormState>();

  String observation = "";
  DiscardReason reason = DiscardReason.discard;
  DateTime date = DateTime.now();

  bool hasFailedOnce = false;

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      inspect(exception);
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final reasonDropdown = DropdownMenu<DiscardReason>(
      initialSelection: reason,
      dropdownMenuEntries: DiscardReason.values.map((r) => DropdownMenuEntry(value: r, label: r.toString())).toList(),
      onSelected: (value) => setState(() => reason = value!),
      label: const Text('Motivação'),
      expandedInsets: EdgeInsets.zero
    );

    final observationField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(hintText: 'Exemplo: Vaca tentou dar coice.',
                                        border: OutlineInputBorder(),
                                        label: Text("Observação"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => observation = value ?? observation
    );

    final addButton = Button(text: "Confirmar Descarte", color: Colors.red, onPressed: discardBovine);

    final datePicker = InputDatePickerFormField(
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data",
      onDateSubmitted: (value) => date = value,
      onDateSaved: (value) => date = value,
    );

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
      reasonDropdown,
      divider,
      observationField,
      divider,
      datePicker,
      divider,
      addButton
    ];

    return IntegrazooBaseApp(body: SingleChildScrollView(child: Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
      )
    )));
  }

  void discardBovine() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      final discard = Discard.fromJson({
        'id': 0,
        'bovine': widget.bovine.id,
        'date': date,
        'reason': reason.index,
        'obsevation': observation
      });

      BovineController.discardBovine(discard).then(
        (_) {
          if (context.mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Descarte realizado.'),
              backgroundColor: Colors.green,
              showCloseIcon: true
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            setState(() => ());
            Navigator.of(context).pop();
          }
        },
        onError: (e) => setState(() => exception = e)
      );
    }
  }
}
