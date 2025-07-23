import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:integrazoo/domain/bovine/weighing.dart';
import 'package:integrazoo/view/components/obrigatory_label.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';



class WeighingFormView extends StatefulWidget {
  final Weighing? weighing;

  final VoidCallback? postSave;

  const WeighingFormView({ super.key, this.postSave, this.weighing });

  @override
  State<WeighingFormView> createState() => _WeighingFormViewState();
}

class _WeighingFormViewState extends State<WeighingFormView> {
  bool _isExecuting = false;

  final _formKey = GlobalKey<FormState>();

  final earringController = TextEditingController();

  final weightController = TextEditingController();
  final dateController = TextEditingController();
  final observationController = TextEditingController();

  late Isar isar;

  @override
  void initState() {
    super.initState();

    isar = GetIt.instance<Isar>();

    if (widget.weighing != null) {
      widget.weighing!.bovine.loadSync();

      earringController.text = widget.weighing!.bovine.value!.earring.toString();
      weightController.text = widget.weighing!.weight.toString();
      observationController.text = widget.weighing!.observation ?? "";
      dateController.text = DateFormat.yMd("pt_BR").format(widget.weighing!.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final earringField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 123"
      ),
      controller: earringController,
      validator: (value) {
        if (value == null) {
          return "Por favor, digite um brinco para o animal.";
        }

        final earring = int.tryParse(value);

        if (earring == null) {
          return "Por favor, digite um brinco válido para o animal.";
        }

        final exists = isar.bovines.getSync(earring) != null;

        if (!exists) {
          return "Animal não foi registrado no sistema.";
        }

        return null;
      }
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
          initialDate: null,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly
        );
        if (pickedDate != null) {
          setState(() => dateController.text = DateFormat.yMd("pt_BR").format(pickedDate));
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor, selecione uma data.";
        }

        return null;
      }
    );

    final weightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 55.7"
      ),
      controller: weightController,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Por favor digite o peso do animal,";
        }

        final weight = double.tryParse(value);

        if (weight == null ||  weight <= 0) {
          return "Por favor, digite um peso válido.";
        }

        return null;
      }
    );

    final observationField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: Animal muito magrinho."
      ),
      controller: observationController,
    );

    final submitButton = TextButton(
      onPressed: onSubmit,
      child: _isExecuting ?
        CircularProgressIndicator(padding: EdgeInsets.all(6.0), color: Colors.white) :
        Text("SALVAR")
    );

    return Form(
      autovalidateMode: AutovalidateMode.onUnfocus,
      key: _formKey,
      child: Padding(padding: EdgeInsets.all(8.0), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          if (widget.weighing == null) ...[
            Card(
              child: Padding(padding: EdgeInsets.all(16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ObrigatoryLabel(field: "Identificação", size: 24),
                    ObrigatoryLabel(field: "Brinco"),
                    earringField,
                ])
              )
            ),
          ],
          Card(
            child: Padding(padding: EdgeInsets.all(16.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ObrigatoryLabel(field: "Pesagem", size: 24),
                ObrigatoryLabel(field: "Data"),
                dateField,
                ObrigatoryLabel(field: "Peso"),
                weightField,
                Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                observationField,
              ])
            )
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              child: submitButton,
            ),
          ),
        ]
      ))
    );
  }

  void onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isExecuting = true);

    final bov = isar.bovines.getSync(int.parse(earringController.text));

    await isar.writeTxn(() async {
      var weighing = Weighing()..bovine.value = bov
                                 ..weight = double.parse(weightController.text)
                                 ..date = DateFormat.yMd("pt_BR").parse(dateController.text)
                                 ..observation = observationController.text.trim().isEmpty ?
                                  null : observationController.text;

      if (widget.weighing != null) {
        weighing.id = widget.weighing!.id;
      }

      await isar.weighings.put(weighing);

      await weighing.bovine.save();

      setState(() => _isExecuting = false);
    }).then((_) => widget.postSave?.call());
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
