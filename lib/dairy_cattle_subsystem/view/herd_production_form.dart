import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/day_period.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/herd_milk_production.dart';


class HerdProductionForm extends StatefulWidget {
    final CentralController controller;

    const HerdProductionForm({ super.key, required this.controller });

    @override
    State<HerdProductionForm> createState() => _HerdProductionFormState();

}

class _HerdProductionFormState extends State<HerdProductionForm> {
    final _formKey = GlobalKey<FormState>();

    HerdMilkProduction production = HerdMilkProduction(0, 0.0, DateTime.now(), DayPeriodIZ.morning, 0.0, "");

    bool hasFailedOnce = false;

    @override
    Widget build(BuildContext context) {
        if (hasFailedOnce) {
            /* TODO: Log this fail. */
            return AlertDialog(
                title: const Text('Falha ao criar animal.'),
                content: const SingleChildScrollView(
                    child: ListBody(
                        children: <Widget>[ Text('Algo falhou ao registrar produção do rebanho.'),
                                            Text('Por favor, contate a equipe INTEGRAZOO.') ],
                        ),
                    ),
                actions: <Widget>[
                    TextButton(child: const Text('Fechar'),
                               onPressed: () {
                                   setState(() { hasFailedOnce = false; });
                               }),
                ],
            );
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
            onSelected: (value) { setState(() { production.period = value!; }); },
            label: const Text('Período do Dia'),
            expandedInsets: EdgeInsets.zero,
        );

        final saveSection = Row(children: [
            Expanded(child: ElevatedButton(onPressed: () {
                    if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        widget.controller.herdProductionController.recordHerdMilkProduction(production).then(
                            (wasSuccessful) {
                                if (wasSuccessful) {
                                    SnackBar snackBar = const SnackBar(
                                        content: Text('PRODUÇÃO REGISTRADA.'),
                                        showCloseIcon: true
                                    );
                                    ScaffoldMessenger.of(context)
                                                     .showSnackBar(snackBar);
                                    Navigator.of(context).pop();
                                } else {
                                    setState(() { hasFailedOnce = true; });
                                }
                            }
                        );
                    }
                },
              child: const Text('SALVAR'))
            )
        ]);

        Divider divider = const Divider(color: Colors.transparent);

      return IntegrazooBaseApp(body: 
        Container(
          padding: const EdgeInsets.all(8),
          child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Column(children: [
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
                                    production.volume = double.tryParse(value ?? "0") ?? production.volume;
                                }),
                  divider,
                  TextFormField(keyboardType: TextInputType.number,
                                decoration: const InputDecoration(hintText: 'Exemplo: 12',
                                                                  border: OutlineInputBorder(),
                                                                  label: Text("Quantidade de Leite Descartado"),
                                                                  floatingLabelBehavior: FloatingLabelBehavior.always),
                                onSaved: (value) {
                                    production.discarded = double.tryParse(value ?? "0") ?? production.discarded;
                                }),
                  divider,
                  TextFormField(keyboardType: TextInputType.text,
                                decoration: const InputDecoration(hintText: 'Exemplo: Muitas vacas estavam estressadas.',
                                                                  border: OutlineInputBorder(),
                                                                  label: Text("Observação"),
                                                                  floatingLabelBehavior: FloatingLabelBehavior.always),
                                onSaved: (value) {
                                    production.observation = value ?? production.observation;
                                }),
                  saveSection,
          ])),
        )
      );
    }
}
