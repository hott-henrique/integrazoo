import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';
import 'package:integrazoo/view/components/obrigatory_label.dart';

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:get_it/get_it.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';
import 'package:integrazoo/domain/health/vaccine.dart';
import 'package:integrazoo/view/components/controller/multi_earring.dart';
import 'package:integrazoo/view/components/selector/multi_bovine.dart';


class VaccinationFormView extends StatefulWidget {
  final Vaccine? vaccine;
  final VoidCallback? postSave;

  const VaccinationFormView({ super.key, this.vaccine, this.postSave });

  @override
  State<VaccinationFormView> createState() {
    return _VaccinationFormView();
  }
}

class _VaccinationFormView extends State<VaccinationFormView> {
  final _formKey = GlobalKey<FormState>();

  final earringsController = MultiEarringController();

  DateTime date = DateTime.now();
  final dateController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  bool _isExecuting = false;

  late Isar isar;

  @override
  void initState() {
    super.initState();

    isar = GetIt.I<Isar>();

    if (widget.vaccine != null) {
      nameController.text = widget.vaccine!.name;
      dateController.text = DateFormat.yMd("pt_BR").format(widget.vaccine?.date ?? date);
      earringsController.addEarring(widget.vaccine!.bovine.value!.earring);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      keyboardType: TextInputType.text,
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite o nome da vacina."
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Por favor, digite o nome da vacina.";
        }

        return null;
      }
    );

    final bovinesField = MultiBovineSelector(earringsController: earringsController);

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
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ObrigatoryLabel(field: "Procedimento", size: 24),
            if (widget.vaccine == null) ...[
              ObrigatoryLabel(field: "Animais"),
              bovinesField,
            ],
            ObrigatoryLabel(field: "Vacina"),
            nameField,
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

    if (widget.vaccine != null) {
      update();
      return;
    }

    setState(() => _isExecuting = true);

    await isar.writeTxn(() async {
      for (final bov in earringsController.bovines) {
        await isar.bovines.put(bov);

        final vaccination = Vaccine()..name = nameController.text
                                     ..bovine.value = bov
                                     ..date = date;

        await isar.vaccines.put(vaccination);

        await vaccination.bovine.save();
      }
    }).then((_) {
      setState(() => _isExecuting = false);
      widget.postSave?.call();
    });
  }

  void update() async {
    setState(() => _isExecuting = true);

    await isar.writeTxn(() async {
      var vaccine = widget.vaccine!;

      vaccine.date = date;
      vaccine.name = nameController.text;

      isar.vaccines.put(vaccine);

      await vaccine.bovine.save();
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
