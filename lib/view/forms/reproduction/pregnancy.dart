import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/reproduction/reproduction.dart';
import 'package:integrazoo/domain/reproduction/reproduction_diagnostic.dart';
import 'package:integrazoo/domain/reproduction/pregnancy.dart';


class PregnancyFormView extends StatefulWidget {
  final ArtificialInseminationReproduction? inseminationReproduction;
  final NaturalReproduction? naturalReproduction;

  final VoidCallback? postSave;

  final Function(DateTime, ReproductionDiagnostic, Pregnancy?) save;

  const PregnancyFormView({
    super.key,
    this.postSave,
    required this.save,
    this.inseminationReproduction,
    this.naturalReproduction
  });

  @override
  State<PregnancyFormView> createState() {
    return _PregnancyFormView();
  }
}

class _PregnancyFormView extends State<PregnancyFormView> {
  final _formKey = GlobalKey<FormState>();

  DateTime date = DateTime.now();
  DateTime birthDate = DateTime.now();

  final dateController = TextEditingController();
  final birthDateController = TextEditingController();
  final observationController = TextEditingController();
  final diagnosticController = TextEditingController();

  ReproductionDiagnostic diagnostic = ReproductionDiagnostic.positive;

  bool _isExecuting = false;

  late Isar isar;

  @override
  void initState() {
    if (widget.inseminationReproduction == null && widget.naturalReproduction == null) {
      throw "Insemination or natural reproduction must be given.";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final observationField = TextFormField(
      controller: observationController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: Vaca se encontrava agitada.",
      )
    );

    final diagnosticField = DropdownMenu<ReproductionDiagnostic?>(
      controller: diagnosticController,
      initialSelection: diagnostic,
      dropdownMenuEntries: [
        ReproductionDiagnostic.positive,
        ReproductionDiagnostic.negative
      ].map((v) => DropdownMenuEntry(value: v, label: v.toString())).toList(),
      onSelected: (value) {
        if (value == null) {
          return;
        }

        setState(() => diagnostic = value);
      },
      expandedInsets: EdgeInsets.zero,
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
          initialDate: widget.inseminationReproduction?.date ?? widget.naturalReproduction!.date,
          firstDate: widget.inseminationReproduction?.date ?? widget.naturalReproduction!.date,
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

    final birthDateField = TextFormField(
      controller: birthDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 18/02/2002",
        suffixIcon: birthDateController.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => setState(() => birthDateController.clear()),
              )
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: widget.inseminationReproduction?.date ?? widget.naturalReproduction!.date,
          firstDate: widget.inseminationReproduction?.date ?? widget.naturalReproduction!.date,
          lastDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly
        );
        if (pickedDate != null) {
          setState(() {
            birthDateController.text = DateFormat.yMd("pt_BR").format(pickedDate);
            birthDate = pickedDate;
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
            Text("Diagnostico", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Resultado", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            diagnosticField,
            Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            dateField,
            if (diagnostic == ReproductionDiagnostic.positive) ...[
              Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              observationField
            ]
          ])
        )
      ),
      if (diagnostic == ReproductionDiagnostic.positive) Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Parto", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Data Prevista", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            birthDateField,
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

    Pregnancy? p;

    if (diagnostic == ReproductionDiagnostic.positive) {
      p =  Pregnancy()..birthForecast = birthDate
                      ..observation = observationController.text.trim().isEmpty ? null : observationController.text.trim();
    }

    widget.save(date, diagnostic, p);

    setState(() => _isExecuting = false);

    widget.postSave?.call();
  }
}
