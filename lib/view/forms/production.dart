import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/cow_production_controller.dart';

import 'package:integrazoo/model/bovine/cow.dart';
import 'package:integrazoo/model/bovine/milk_production.dart';


class CowProductionForm extends StatefulWidget {
  const CowProductionForm({ super.key });

  @override
  State<CowProductionForm> createState() => _CowProductionFormState();
}

class _CowProductionFormState extends State<CowProductionForm> {
  final _formKey = GlobalKey<FormState>();

  CowMilkProduction production = CowMilkProduction(0, 0, DateTime.now(), DayPeriodIZ.morning, false, "");
  Cow selectedCow = Cow(0, "UNKNOWN");

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final dateSection = InputDatePickerFormField(
      initialDate: production.date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data",
      onDateSubmitted: (value) {
        production.date = value;
      },
      onDateSaved: (value) {
        production.date = value;
      },
    );

    final periodSection = DropdownMenu<DayPeriodIZ>(
      initialSelection: production.period,
      dropdownMenuEntries: DayPeriodIZ.values.map((period) => DropdownMenuEntry(value: period, label: period.toString())).toList(),
      onSelected: (value) => setState(() => production.period = value!),
      label: const Text('Período do Dia'),
      expandedInsets: EdgeInsets.zero,
    );

    final saveSection = Row(children: [
      Expanded(child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();
            CowProductionController.recordCowMilkProduction(selectedCow, production).then(
              (_) {
                SnackBar snackBar = const SnackBar(
                  content: Text('PRODUÇÃO REGISTRADA.'),
                  showCloseIcon: true
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).pop();
              },
              onError: (e) {
                setState(() => exception = e);
              }
            );
          }
        },
        child: const Text('SALVAR'))
      )
    ]);

    Divider divider = const Divider(color: Colors.transparent);

    return IntegrazooBaseApp(body:
      FutureBuilder<List<Cow>>(
        future: BovineController.readCows(),
        builder: (context, AsyncSnapshot<List<Cow>> snapshot) {
          if (snapshot.hasData) {
            final cows = snapshot.data!;

            if (cows.isEmpty) {
              return const Center(child: Text('Nenhuma vaca encontrada no rebanho.'));
            }

            selectedCow = cows[0];

            final cow = DropdownMenu<Cow>(
              dropdownMenuEntries: cows.map((cow) => DropdownMenuEntry(value: cow, label: '[${cow.id}] ${cow.name}')).toList(),
              onSelected: (value) {
                selectedCow = value ?? selectedCow;
              },
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
                              onSaved: (value) {
                                production.volume = double.tryParse(value ?? "0") ?? 0;
                              }),
                divider,
                TextFormField(keyboardType: TextInputType.text,
                              decoration: const InputDecoration(hintText: 'Exemplo: Vaca tentou dar coice.',
                                                                border: OutlineInputBorder(),
                                                                label: Text("Observação"),
                                                                floatingLabelBehavior: FloatingLabelBehavior.always),
                              onSaved: (value) {
                                production.observation = value ?? production.observation;
                              },
                ),
                Row(children: [
                  Checkbox(
                    value: production.discard,
                    activeColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent),
                    onChanged: (value) => setState(() {
                      production.discard = value ?? false;
                    }
                  )),
                  const Expanded(child: Text('DESCARTAR LEITE', style: TextStyle(color: Colors.redAccent))),
                ]),
                saveSection,
              ])
            )
          );
          } else {
            return const CircularProgressIndicator();
          }
        }
      )
    );
  }
}
