import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';
import 'package:integrazoo/view/components/button.dart';

import 'package:integrazoo/control/semen_controller.dart';
import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';

import 'package:integrazoo/database/database.dart';


class PregnancyForm extends StatefulWidget {
  // final Reproduction attempt;
  final int reproductionId;

  // const PregnancyForm({ super.key, required this.attempt });
  const PregnancyForm({ super.key, required this.reproductionId });

  @override
  State<PregnancyForm> createState() => _PregnancyFormState();
}

class _PregnancyFormState extends State<PregnancyForm> {
  final _formKey = GlobalKey<FormState>();

  Exception? exception;

  DateTime diagnosticDate = DateTime.now();
  DateTime dryingForecast = DateTime.now().add(const Duration(days:(9 * 30) - 60));
  DateTime birthForecast = DateTime.now().add(const Duration(days:(9 * 30)));
  String observation = "";
  int milkWaitTime = 0;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    return FutureBuilder(
      future: ReproductionController.getReproductionById(widget.reproductionId),
      builder: (context, AsyncSnapshot<Reproduction> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final reproduction = snapshot.data!;

        return buildComplete(reproduction);
      }
    );
  }

  Widget buildComplete(Reproduction r) {
    final diagnosticDateField = InputDatePickerFormField(
      initialDate: diagnosticDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days:2 * 365)),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data do Diagnóstico",
      onDateSaved: (value) => dryingForecast = value,
    );

    final dryingForecastField = InputDatePickerFormField(
      initialDate: dryingForecast,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days:2 * 365)),
      keyboardType: TextInputType.text,
      fieldLabelText: "Previsão de Secagem",
      onDateSaved: (value) => dryingForecast = value,
    );

    final birthForecastField = InputDatePickerFormField(
      initialDate: birthForecast,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days:2 * 365)),
      keyboardType: TextInputType.text,
      fieldLabelText: "Previsão do Parto",
      onDateSaved: (value) => birthForecast = value,
    );

    final milkWaitTimeField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(hintText: 'Exemplo: 5',
                                        border: OutlineInputBorder(),
                                        label: Text("Tempo (em dias) de Carência do Leite"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => milkWaitTime = int.tryParse(value ?? "0") ?? 0
    );

    final observationField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(hintText: 'Exemplo: Vaca tentou dar coice.',
                                        border: OutlineInputBorder(),
                                        label: Text("Observação"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => observation = value ?? observation,
    );

    final confirmBtn = Button(
      text: "Confirmar",
      color: Colors.green,
      onPressed: confirmPregnancy
    );

    final cancelBtn = Button(
      text: "Cancelar",
      color: Colors.red,
      onPressed: () => Navigator.of(context).pop()
    );

    Divider divider = const Divider(height: 8, color: Colors.transparent);

    return IntegrazooBaseApp(body: Padding(padding: const EdgeInsets.all(8.0), child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          getCowView(r.cow),
          getSemenMinimalView(r.semen!),
          divider,
          diagnosticDateField,
          divider,
          dryingForecastField,
          divider,
          birthForecastField,
          divider,
          milkWaitTimeField,
          divider,
          observationField,
          confirmBtn,
          cancelBtn
        ])
      )
    ));
  }

  void confirmPregnancy() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      final pregnancy = Pregnancy.fromJson({
        'id': 0,
        'date': diagnosticDate,
        'dryingForecast': dryingForecast,
        'birthForecast': birthForecast,
        'milkWaitTimeDurationInDays': milkWaitTime,
        'observation': observation,
        'reproduction': widget.reproductionId,
      });

      ReproductionController.confirmPregnancy(widget.reproductionId, pregnancy).then(
        (_) {
          if (context.mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Prenhes confirmada.'),
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

  Widget getCowView(int bovineId) {
    return FutureBuilder(
      future: BovineController.getBovine(bovineId),
      builder: (context, AsyncSnapshot<Bovine> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final cow = snapshot.data!;

        return Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(children: [
              const Row(children: [
                Expanded(child: Text("Vaca", textAlign: TextAlign.center))
              ]),
              Row(children: [
                const Expanded(child: Text("Nome")),
                Expanded(child: Text(cow.name, textAlign: TextAlign.right)),
              ]),
              Row(children: [
                const Expanded(child: Text("Brinco")),
                Expanded(child: Text(cow.id.toString(), textAlign: TextAlign.right)),
              ]),
            ])
          )
        );
      }
    );
  }

  Widget getSemenMinimalView(String semen) {
    return FutureBuilder(
      future: SemenController.getSemen(semen),
      builder: (context, AsyncSnapshot<Semen> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final semen = snapshot.data!;

        return Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(children: [
              const Row(children: [
                Expanded(child: Text("Semen", textAlign: TextAlign.center))
              ]),
              Row(children: [
                const Expanded(child: Text("Touro")),
                Expanded(child: Text(semen.bullName, textAlign: TextAlign.right))
              ]),
              Row(children: [
                const Expanded(child: Text("Semen")),
                Expanded(child: Text(semen.semenNumber, textAlign: TextAlign.right)),
              ])
            ])
          )
        );
      }
    );
  }
}
