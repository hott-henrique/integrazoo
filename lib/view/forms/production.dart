import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/production_controller.dart';

import 'package:integrazoo/database/database.dart';


class ProductionForm extends StatefulWidget {
  const ProductionForm({ super.key });

  @override
  State<ProductionForm> createState() => _ProductionFormState();
}

class _ProductionFormState extends State<ProductionForm> {
  final _formKey = GlobalKey<FormState>();

  int idSelectedCow = 0;

  double productionVolume = 0.0;
  DateTime productionDate = DateTime.now();
  bool productionDiscard = false;
  ProductionDayPeriod productionDayPeriod = ProductionDayPeriod.morning;
  String productionObservation = "";

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      inspect(exception);
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final dateSection = InputDatePickerFormField(
      initialDate: productionDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data",
      onDateSubmitted: (value) => productionDate = value,
      onDateSaved: (value) => productionDate = value,
    );

    final periodSection = DropdownMenu<ProductionDayPeriod>(
      initialSelection: productionDayPeriod,
      dropdownMenuEntries: ProductionDayPeriod.values.map((period) => DropdownMenuEntry(value: period, label: period.toString())).toList(),
      onSelected: (value) => setState(() => productionDayPeriod = value!),
      label: const Text('Período do Dia'),
      expandedInsets: EdgeInsets.zero,
    );

    final saveSection = Row(children: [
      Expanded(child: TextButton(
        style: Theme.of(context).textButtonTheme.style,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();
            final production = Production.fromJson({
              'id': 0,
              'cow': 0,
              'date': productionDate,
              'dayPeriod': productionDayPeriod.index,
              'discard': productionDiscard,
              'volume': productionVolume,
            });
            ProductionController.recordMilkProduction(idSelectedCow, production).then(
              (_) {
                SnackBar snackBar = const SnackBar(
                  content: Text('PRODUÇÃO REGISTRADA.'),
                  showCloseIcon: true
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                }
              },
              onError: (e) => setState(() => exception = e)
            );
          }
        },
        child: const Text('SALVAR'))
      )
    ]);

    Divider divider = const Divider(color: Colors.transparent);

    return IntegrazooBaseApp(body:
      FutureBuilder<List<Bovine>>(
        future: BovineController.readCows(),
        builder: (context, AsyncSnapshot<List<Bovine>> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final cows = snapshot.data!;

          if (cows.isEmpty) {
            return const Center(child: Text('Nenhuma vaca encontrada no rebanho.'));
          }

          idSelectedCow = cows[0].id;

          final cow = DropdownMenu<Bovine>(
            dropdownMenuEntries: cows.map((cow) => DropdownMenuEntry(value: cow, label: '[${cow.id}] ${cow.name}')).toList(),
            onSelected: (value) => idSelectedCow = value!.id,
            label: const Text('Vaca'),
            expandedInsets: EdgeInsets.zero,
            menuHeight: 300,
            initialSelection: cows[0],
          );

          return Container(
            padding: const EdgeInsets.all(8),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Column(children: [
                cow,
                divider,
                dateSection,
                divider,
                periodSection,
                divider,
                TextFormField(keyboardType: TextInputType.number,
                              decoration: const InputDecoration(hintText: 'Exemplo: 12',
                                                                border: OutlineInputBorder(),
                                                                label: Text("Quantidade"),
                                                                floatingLabelBehavior: FloatingLabelBehavior.always),
                              onSaved: (value) => productionVolume = double.tryParse(value ?? "0") ?? 0),
                divider,
                TextFormField(keyboardType: TextInputType.text,
                              decoration: const InputDecoration(hintText: 'Exemplo: Vaca tentou dar coice.',
                                                                border: OutlineInputBorder(),
                                                                label: Text("Observação"),
                                                                floatingLabelBehavior: FloatingLabelBehavior.always),
                              onSaved: (value) => productionObservation = value ?? productionObservation),
                Row(children: [
                  Checkbox(
                    value: productionDiscard,
                    activeColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent),
                    onChanged: (value) => setState(() => productionDiscard = value ?? false)
                  ),
                  const Expanded(child: Text('DESCARTAR LEITE', style: TextStyle(color: Colors.redAccent))),
                ]),
                saveSection,
              ])
            )
          );
        }
      )
    );
  }
}
