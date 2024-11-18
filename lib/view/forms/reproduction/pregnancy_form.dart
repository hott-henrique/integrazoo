import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';
import 'package:integrazoo/view/components/button.dart';

import 'package:integrazoo/control/semen_controller.dart';
import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';

import 'package:integrazoo/database/database.dart';


class PregnancyForm extends StatefulWidget {
  final Reproduction attempt;

  const PregnancyForm({ super.key, required this.attempt });

  @override
  State<PregnancyForm> createState() => _PregnancyFormState();
}

class _PregnancyFormState extends State<PregnancyForm> {
  final _formKey = GlobalKey<FormState>();

  Exception? exception;

  DateTime birthForecast = DateTime.now();
  String observation = "";

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final birthForecastField = InputDatePickerFormField(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days:365)),
      keyboardType: TextInputType.text,
      fieldLabelText: "Previsão do Parto",
      onDateSaved: (value) => birthForecast = value,
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
          getCowView(),
          getSemenMinimalView(),
          divider,
          birthForecastField,
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

      final reproduction = SuccessfulReproduction.fromJson({
        'id': 0,
        'observation': "",
        'birthForecastStartingDate': birthForecast,
        'birthForecastEndingDate': birthForecast.add(const Duration(days: 10)),
        'milkWaitTimeDurationInDays': 5,
        'reproduction': widget.attempt.id,
      });

      // ReproductionController.confirmPregnancy();
    }
  }

  Widget getCowView() {
    return FutureBuilder(
      future: BovineController.getBovine(widget.attempt.cow),
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

  Widget getSemenMinimalView() {
    return FutureBuilder(
      future: SemenController.getSemen(widget.attempt.semen!),
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
