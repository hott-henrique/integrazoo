import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/reproduction/reproduction.dart';
import 'package:integrazoo/domain/reproduction/reproduction_diagnostic.dart';
import 'package:integrazoo/domain/reproduction/pregnancy.dart';


class PregnancyLossFormView extends StatefulWidget {
  final Pregnancy pregnancy;

  final Function(DateTime, String?) onSave;

  final VoidCallback? postSave;

  const PregnancyLossFormView({
    super.key,
    required this.onSave,
    required this.pregnancy,
    this.postSave
  });

  @override
  State<PregnancyLossFormView> createState() {
    return _PregnancyLossFormView();
  }
}

class _PregnancyLossFormView extends State<PregnancyLossFormView> {
  final _formKey = GlobalKey<FormState>();

  DateTime date = DateTime.now();

  final dateController = TextEditingController();
  final observationController = TextEditingController();

  bool _isExecuting = false;

  late Isar isar;

  @override
  Widget build(BuildContext context) {
    final observationField = TextFormField(
      controller: observationController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: Vaca não se alimentava.",
      )
    );

    final dateField = TextFormField(
      controller: dateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 18/02/2002",
        suffixIcon: dateController.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => setState(() => dateController.clear()),
              )
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly
        );
        if (pickedDate != null) {
          setState(() {
            dateController.text = DateFormat.yMd("pt_BR").format(pickedDate);
            date = pickedDate;
          });
        }
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Por favor, selecione uma data.";
        }

        return null;
      }
    );

    final submitButton = TextButton(
      onPressed: onSubmit,
      child: _isExecuting ?
        CircularProgressIndicator(padding: EdgeInsets.all(6.0), color: Colors.white) :
        Text("SALVAR")
    );

    final column = <Widget>[
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Natimorto / Reabsorção", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            dateField,
            Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            observationField
          ])
        )
      ),
      submitButton
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        key: _formKey,
        child: Column(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: column
        )
      )
    );
  }

  void onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isExecuting = true);

    widget.onSave(date, observationController.text.trim());

    setState(() => _isExecuting = false);

    widget.postSave?.call();
  }
}
