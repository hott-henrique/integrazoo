import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/treatment_controller.dart';

import 'package:integrazoo/database/database.dart';


class TreatmentForm extends StatefulWidget {
  const TreatmentForm({super.key});

  @override
  State<TreatmentForm> createState() => _TreatmentFormState();
}

class _TreatmentFormState extends State<TreatmentForm> {
  final _formKey = GlobalKey<FormState>();
  int bovineId = 0;
  String reason = "";
  String medicine = "";
  DateTime startingDate = DateTime.now();
  DateTime endingDate = DateTime.now();
  int durationInDays = 0;
  bool drying = false;

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(
        title: 'Erro Inesperado',
        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
        onPressed: () => setState(() => exception = null)
      );
    }

    Divider divider = const Divider(height: 8, color: Colors.transparent);

    List<Widget> body = List.empty(growable: true);

    final bovineSelector = FutureBuilder<List<Bovine>>(
      future: BovineController.readHerd(),
      builder: (context, AsyncSnapshot<List<Bovine>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final bovines = snapshot.data!;

        if (bovines.isEmpty) {
          return const Center(child: Text('Nenhum animal encontrado no rebanho.'));
        }

        bovineId = bovines[0].id;

        final bovineSelector = DropdownMenu<Bovine>(
          initialSelection: bovines[0],
          dropdownMenuEntries: bovines.map((b) => DropdownMenuEntry(value: b, label: '[${b.id}] ${b.name}')).toList(),
          onSelected: (value) => bovineId = value!.id,
          label: const Text('Vaca'),
          expandedInsets: EdgeInsets.zero,
          menuHeight: 300,
          inputDecorationTheme: const InputDecorationTheme(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder()
          )
        );
        return bovineSelector;
      }
    );

    body.add(bovineSelector);
    body.add(divider);

    if (!drying) {
      final reasonField = TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Exemplo: Picada de cascavél.',
          border: OutlineInputBorder(),
          label: Text("Razão do Tratmento"),
          floatingLabelBehavior: FloatingLabelBehavior.always
        ),
        onSaved: (value) => reason = value ?? reason,
      );

      body.add(reasonField);
      body.add(divider);
    }

    final medicineNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: 'Exemplo: Flunixin Meglumine',
        border: OutlineInputBorder(),
        label: Text("Nome do Medicamento"),
        floatingLabelBehavior: FloatingLabelBehavior.always
      ),
      onSaved: (value) => medicine = value ?? medicine,
    );

    body.add(medicineNameField);
    body.add(divider);

    if (!drying) {
      final startingDateField = InputDatePickerFormField(
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        keyboardType: TextInputType.text,
        fieldLabelText: "Data de Inicio do Tratamento",
        onDateSaved: (value) => startingDate = value,
      );

      final endingDateField = InputDatePickerFormField(
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(DateTime.now().year + 10),
        keyboardType: TextInputType.text,
        fieldLabelText: "Data Final do Tratamento",
        onDateSaved: (value) => endingDate = value,
      );

      body.add(startingDateField);
      body.add(divider);
      body.add(endingDateField);
      body.add(divider);
    } else {
      final startingDateField = InputDatePickerFormField(
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        keyboardType: TextInputType.text,
        fieldLabelText: "Data do Tratamento",
        onDateSaved: (value) => startingDate = value,
      );

      body.add(startingDateField);
      body.add(divider);
    }

    if (drying) {
      final restingDurationField = TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Exemplo: 5',
          border: OutlineInputBorder(),
          label: Text("Número de Dias de Descanso"),
          floatingLabelBehavior: FloatingLabelBehavior.always
        ),
        onSaved: (value) => durationInDays = int.tryParse(value ?? "") ?? durationInDays,
      );

      body.add(restingDurationField);
      body.add(divider);
    } else {
      final restingDurationField = TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Exemplo: 5',
          border: OutlineInputBorder(),
          label: Text("Tempo de Carência"),
          floatingLabelBehavior: FloatingLabelBehavior.always
        ),
        onSaved: (value) => durationInDays = int.tryParse(value ?? "") ?? durationInDays,
      );

      body.add(restingDurationField);
      body.add(divider);
    }

    body.add(
      Row(children: [
        Checkbox(
          value: drying,
          activeColor: Colors.redAccent,
          side: const BorderSide(color: Colors.redAccent),
          onChanged: (value) => setState(() {
            drying = value ?? false;
            body.clear();
          })
        ),
        const Expanded(child: Text('Secagem', style: TextStyle(color: Colors.redAccent))),
      ])
    );

    final saveButton = Row(children: [ Expanded(
      child: TextButton(
        style: Theme.of(context).textButtonTheme.style,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            late Treatment treatment;
            if (drying) {
              treatment = Treatment.fromJson({
                'id': 0,
                'reason': "Secagem da vaca.",
                'medicine': medicine,
                'startingDate': startingDate,
                'endingDate': startingDate,
                'durationInDays': 1,
                'drying': drying,
                'bovine': bovineId,
              });
            } else {
              treatment = Treatment.fromJson({
                'id': 0,
                'reason': reason,
                'medicine': medicine,
                'startingDate': startingDate,
                'endingDate': endingDate,
                'durationInDays': durationInDays,
                'drying': drying,
                'bovine': bovineId,
              });
            }

            TreatmentController.initiateTreatment(bovineId, treatment).then(
              (_) {
                SnackBar snackBar = const SnackBar(content: Text('TRATAMENTO REGISTRADO.'), showCloseIcon: true);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                }
              },
              onError: (e) => setState(() => exception = e)
            );
          }
        },
        child: const Text('INICIAR TRATAMENTO')
      )
    ) ]);

    body.add(saveButton);
    body.add(divider);

    return IntegrazooBaseApp(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(children: body)
        )
      )
    );
  }
}
