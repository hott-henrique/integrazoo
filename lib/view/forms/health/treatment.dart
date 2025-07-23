import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';
import 'package:integrazoo/view/components/obrigatory_label.dart';

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:get_it/get_it.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';
import 'package:integrazoo/domain/health/treatment.dart';
import 'package:integrazoo/view/components/controller/multi_earring.dart';
import 'package:integrazoo/view/components/selector/multi_bovine.dart';


class TreatmentFormView extends StatefulWidget {
  final Treatment? treatment;
  final VoidCallback? postSave;

  const TreatmentFormView({ super.key, this.treatment, this.postSave });

  @override
  State<TreatmentFormView> createState() {
    return _TreatmentFormView();
  }
}

class _TreatmentFormView extends State<TreatmentFormView> {
  final _formKey = GlobalKey<FormState>();

  final earringsController = MultiEarringController();

  DateTime date = DateTime.now();
  final dateController = TextEditingController();

  DateTime? endDate;
  final endDateController = TextEditingController();

  final TextEditingController medicineController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  bool _isExecuting = false;

  late Isar isar;

  @override
  void initState() {
    super.initState();

    isar = GetIt.I<Isar>();

    if (widget.treatment != null) {
      reasonController.text = widget.treatment!.reason;
      dateController.text = DateFormat.yMd("pt_BR").format(widget.treatment?.date ?? date);
      endDateController.text = DateFormat.yMd("pt_BR").format(widget.treatment?.endDate ?? date);
      earringsController.addEarring(widget.treatment!.bovine.value!.earring);
    }
  }

  @override
  Widget build(BuildContext context) {
    final medicineField = TextFormField(
      keyboardType: TextInputType.text,
      controller: medicineController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite o nome do medicamento."
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Por favor, digite o nome do medicamento.";
        }

        return null;
      }
    );

    final reasonField = TextFormField(
      keyboardType: TextInputType.text,
      controller: reasonController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite a razão do tratamento."
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Por favor, digite a razão do tratamento.";
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

    final endDateField = TextFormField(
      controller: endDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 18/02/2002",
        suffixIcon: endDateController.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => setState(() => endDateController.clear()),
              )
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime.now().add(Duration(days: 3650)),
          initialEntryMode: DatePickerEntryMode.calendarOnly
        );
        if (pickedDate != null) {
          setState(() {
            endDateController.text = DateFormat.yMd("pt_BR").format(pickedDate);
            endDate = pickedDate;
          });
        }
      },
      validator: (value) {
        if (value == null) {
          return null;
        }

        if (value.trim().isEmpty) {
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
            if (widget.treatment == null) ...[
              ObrigatoryLabel(field: "Animais", size: 16),
              bovinesField,
            ],
            ObrigatoryLabel(field: "Data", size: 16),
            dateField,
            Text("Data Fim", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            endDateField,
          ])
        )
      ),
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ObrigatoryLabel(field: "Medicação", size: 24),
            ObrigatoryLabel(field: "Medicamento"),
            medicineField,
            ObrigatoryLabel(field: "Motivação"),
            reasonField,
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

    if (widget.treatment != null) {
      update();
      return;
    }

    setState(() => _isExecuting = true);

    await isar.writeTxn(() async {
      for (final bov in earringsController.bovines) {
        await isar.bovines.put(bov);

        final treatment = Treatment()..reason = reasonController.text
                                     ..medicine = medicineController.text
                                     ..bovine.value = bov
                                     ..date = date
                                     ..endDate = endDate;

        await isar.treatments.put(treatment);

        await treatment.bovine.save();
      }
    }).then((_) {
      setState(() => _isExecuting = false);
      widget.postSave?.call();
    });
  }

  void update() async {
    setState(() => _isExecuting = true);

    await isar.writeTxn(() async {
      var treatment = widget.treatment!;

      treatment.date = date;
      treatment.endDate = endDate;
      treatment.reason = reasonController.text;
      treatment.medicine = medicineController.text;

      isar.treatments.put(treatment);

      await treatment.bovine.save();
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
