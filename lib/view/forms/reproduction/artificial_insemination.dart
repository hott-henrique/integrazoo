import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';
import 'package:integrazoo/domain/bovine/sex.dart';
import 'package:integrazoo/domain/reproduction/breeder.dart';
import 'package:integrazoo/domain/reproduction/reproduction_diagnostic.dart';
import 'package:integrazoo/view/components/controller/breeder.dart';
import 'package:integrazoo/view/components/controller/multi_earring.dart';
import 'package:integrazoo/view/components/obrigatory_label.dart';
import 'package:integrazoo/view/components/selector/breeder.dart';
import 'package:integrazoo/view/components/selector/multi_bovine.dart';
import 'package:intl/intl.dart';

import 'package:isar/isar.dart';
import 'package:get_it/get_it.dart';

import 'package:integrazoo/domain/reproduction/reproduction.dart';


class ArtificialInseminationFormView extends StatefulWidget {
  final List<int>? preSelectedBovines;

  final ArtificialInseminationReproduction? insemination;
  final VoidCallback? postSave;

  const ArtificialInseminationFormView({ super.key, this.insemination, this.postSave, this.preSelectedBovines });

  @override
  State<ArtificialInseminationFormView> createState() {
    return _ArtificialInseminationFormView();
  }
}

class _ArtificialInseminationFormView extends State<ArtificialInseminationFormView> {
  final _formKey = GlobalKey<FormState>();

  final earringsController = MultiEarringController(sex: Sex.female, isReproducing: false, isPregnant: false);
  final breederController = BreederController(sex: Sex.male);

  DateTime date = DateTime.now();
  final dateController = TextEditingController();

  final TextEditingController strawNumberController = TextEditingController();

  bool _isExecuting = false;

  late Isar isar;

  @override
  void initState() {
    super.initState();

    isar = GetIt.I<Isar>();

    strawNumberController.text = widget.insemination?.straw ?? "";
    breederController.setBreeder(widget.insemination?.breeder.value!.name);
    dateController.text = DateFormat.yMd("pt_BR").format(widget.insemination?.date ?? date);

    if (widget.insemination != null) {
      date = widget.insemination!.date;
      earringsController.bovines.add(widget.insemination!.cow.value!);
    }

    if (widget.preSelectedBovines != null) {
      for (final earring in widget.preSelectedBovines!) {
        earringsController.addEarring(earring);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strawField = TextFormField(
      keyboardType: TextInputType.text,
      controller: strawNumberController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite o número da pipeta."
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Por favor, digite o número da pipeta.";
        }

        return null;
      }
    );

    final femalesField = MultiBovineSelector(earringsController: earringsController);
    final breederField = SingleBreederSelector(breederController: breederController);

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
      if (widget.insemination != null) ...[
        Card(
          child: Padding(padding: EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Matriz", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text("Animal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(widget.insemination!.cow.value.toString())
            ])
          )
        )
      ] else ...[
        Card(
          child: Padding(padding: EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ObrigatoryLabel(field: "Matrizes", size: 24),
              ObrigatoryLabel(field: "Animais"),
              femalesField
            ])
          )
        )
      ],
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ObrigatoryLabel(field: "Doador", size: 24),
            ObrigatoryLabel(field: "Reprodutor"),
            breederField,
            ObrigatoryLabel(field: "Pipeta"),
            strawField
          ])
        )
      ),
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

    if (widget.insemination != null) {
      update();
      return;
    }

    setState(() => _isExecuting = true);

    await isar.writeTxn(() async {
      final breeder = await isar.breeders.get(breederController.id!);

      for (final cow in earringsController.bovines) {
        await isar.bovines.put(cow);

        final insemination = ArtificialInseminationReproduction()..breeder.value = breeder
                                                                 ..date = date
                                                                 ..diagnostic = ReproductionDiagnostic.waiting
                                                                 ..straw = strawNumberController.text
                                                                 ..cow.value = cow;

        await isar.artificialInseminationReproductions.put(insemination);

        await insemination.cow.save();
        await insemination.breeder.save();
      }
    }).then((_) {
      setState(() => _isExecuting = false);
      widget.postSave?.call();
    });
  }

  void update() async {
    setState(() => _isExecuting = true);

    await isar.writeTxn(() async {
      final breeder = await isar.breeders.get(breederController.id!);

      var insemination = widget.insemination!;

      insemination.breeder.value = breeder;
      insemination.date = date;
      insemination.straw = strawNumberController.text;

      await insemination.cow.save();
      await insemination.breeder.save();

      await isar.artificialInseminationReproductions.put(insemination);
    }).then((_) {
      setState(() => _isExecuting = false);
      widget.postSave?.call();
    });
  }

  bool isAllEmpty(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      if (controller.text.trim().isNotEmpty) {
        return false;
      }
    }

    return true;
  }
}
