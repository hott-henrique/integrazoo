import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';
import 'package:integrazoo/view/components/obrigatory_label.dart';

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:get_it/get_it.dart';

import 'package:integrazoo/domain/bovine/sex.dart';
import 'package:integrazoo/domain/reproduction/reproduction.dart';
import 'package:integrazoo/domain/reproduction/reproduction_diagnostic.dart';

import 'package:integrazoo/view/components/controller/earring.dart';
import 'package:integrazoo/view/components/selector/bovine.dart';


class NaturalReproductionFormView extends StatefulWidget {
  final NaturalReproduction? reproduction;
  final VoidCallback? postSave;

  const NaturalReproductionFormView({ super.key, this.reproduction, this.postSave });

  @override
  State<NaturalReproductionFormView> createState() {
    return _NaturalReproductionFormView();
  }
}

class _NaturalReproductionFormView extends State<NaturalReproductionFormView> {
  final _formKey = GlobalKey<FormState>();

  final cowController = EarringController(sex: Sex.female, isReproducing: false, isPregnant: false);
  final bullController = EarringController(sex: Sex.male);

  DateTime date = DateTime.now();
  final dateController = TextEditingController();

  bool _isExecuting = false;

  late Isar isar;

  @override
  void initState() {
    super.initState();

    isar = GetIt.I<Isar>();

    if (widget.reproduction != null) {
      dateController.text = DateFormat.yMd("pt_BR").format(widget.reproduction!.date);
      cowController.setEarring(widget.reproduction!.cow.value!.earring);
      bullController.setEarring(widget.reproduction!.bull.value!.earring);
    }
  }

  @override
  Widget build(BuildContext context) {
    final femaleField = SingleBovineSelector(earringController: cowController);
    final maleField = SingleBovineSelector(earringController: bullController);

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
          initialDate: null,
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
      if (widget.reproduction != null) ...[
        Card(
          child: Padding(padding: EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ObrigatoryLabel(field: "Animais", size: 24),
              ObrigatoryLabel(field: "Matriz"),
              Text(widget.reproduction!.cow.value.toString()),
              ObrigatoryLabel(field: "Reprodutor"),
              Text(widget.reproduction!.bull.value.toString())
            ])
          )
        )
      ] else ...[
        Card(
          child: Padding(padding: EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ObrigatoryLabel(field: "Animais", size: 24),
              ObrigatoryLabel(field: "Matriz"),
              femaleField,
              ObrigatoryLabel(field: "Reprodutor"),
              maleField
            ])
          )
        )
      ],
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ObrigatoryLabel(field: "Procedimento", size: 24),
            ObrigatoryLabel(field: "Data"),
            dateField,
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

    if (widget.reproduction != null) {
      update();
      return;
    }

    setState(() => _isExecuting = true);

    await isar.writeTxn(() async {
      final reproduction = NaturalReproduction()..cow.value = cowController.bovine!
                                                ..bull.value = bullController.bovine!
                                                ..date = date
                                                ..diagnostic = ReproductionDiagnostic.waiting;

      await isar.naturalReproductions.put(reproduction);

      await reproduction.cow.save();
      await reproduction.bull.save();
    }).then((_) {
      setState(() => _isExecuting = false);
      widget.postSave?.call();
    });
  }

  void update() async {
    setState(() => _isExecuting = true);

    await isar.writeTxn(() async {
      var reproduction = widget.reproduction!;

      reproduction.cow.value = cowController.bovine;
      reproduction.bull.value = bullController.bovine;
      reproduction.date = date;

      await isar.naturalReproductions.put(reproduction);
    }).then((_) {
      setState(() => _isExecuting = false);
      widget.postSave?.call();
    });
  }
}
