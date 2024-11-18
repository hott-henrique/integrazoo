import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

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

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final cowInfo = Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(children: [
          Row(children: [
            const Expanded(child: Text("Vaca")),
            Expanded(child: Text(widget.attempt.cow.toString(), textAlign: TextAlign.right)),
          ]),
        ])
      )
    );

    final methodInfo = Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(children: [
          Row(children: [
            const Expanded(child: Text("Reprodutor")),
            Expanded(child: Text(widget.attempt.toString(), textAlign: TextAlign.right)),
          ]),
        ])
      )
    );

    final birthForecastField = InputDatePickerFormField(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days:365)),
      keyboardType: TextInputType.text,
      fieldLabelText: "Previsão do Parto",
      onDateSaved: (value) => {},
    );

    final observationField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(hintText: 'Exemplo: Vaca tentou dar coice.',
                                        border: OutlineInputBorder(),
                                        label: Text("Observação"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) { },
    );

    final confirmBtn = Row(children: [ Expanded(child: TextButton(
      style: Theme.of(context).textButtonTheme.style,
      child: const Text("Confirmar"),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState?.save();
        }
      },
    )) ]);

    final cancelBtn = Row(children: [ Expanded(child: TextButton(
      style: Theme.of(context).textButtonTheme.style?.copyWith(backgroundColor: WidgetStateProperty.all(Colors.red[400])),
      child: const Text("Cancelar"),
      onPressed: () => Navigator.of(context).pop()
    )) ]);

    Divider divider = const Divider(height: 8, color: Colors.transparent);

    return IntegrazooBaseApp(body: Padding(padding: const EdgeInsets.all(8.0), child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(children: [
          cowInfo,
          methodInfo,
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
}
