import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

// import 'package:integrazoo/dairy_cattle_subsystem/model/milk_production.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';


class HerdProductionForm extends StatefulWidget {
    final CentralController controller;

    const HerdProductionForm({ super.key, required this.controller });

    @override
    State<HerdProductionForm> createState() => _HerdProductionFormState();

}

class _HerdProductionFormState extends State<HerdProductionForm> {
    double totalProductionVolume = 0;
    double discardedProductionVolume = 0;
    DateTime date = DateTime.now();
    // MilkingDayPeriod period = MilkingDayPeriod.morning;
    String observation = "";

    @override
    Widget build(BuildContext context) {
        final dateSection = InputDatePickerFormField(
            initialDate: date,
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            keyboardType: TextInputType.text,
            fieldLabelText: "Data",
        );

        // final periodSection = DropdownMenu<MilkingDayPeriod>(
        //     initialSelection: MilkingDayPeriod.morning,
        //     dropdownMenuEntries: MilkingDayPeriod.values.map((period) => DropdownMenuEntry(value: period, label: period.toString())).toList(),
        //     onSelected: (value) { setState(() { period = value!; }); },
        //     label: const Text('Período do Dia'),
        //     expandedInsets: EdgeInsets.zero,
        // );

        final saveSection = Row(children: [
            Expanded(child: ElevatedButton(onPressed: () {
                    Navigator.of(context).pop();
                },
            child: const Text('SALVAR'))
            )
        ]);

        Divider divider = const Divider(color: Colors.transparent);

      return IntegrazooBaseApp(body:
          Container(
              padding: const EdgeInsets.all(8),
              child: Column(children: [
                  dateSection,
                  // divider,
                  // periodSection,
                  divider,
                  TextFormField(keyboardType: TextInputType.number,
                                decoration: const InputDecoration(hintText: 'Exemplo: 12',
                                                                  border: OutlineInputBorder(),
                                                                  label: Text("Quantidade"),
                                                                  floatingLabelBehavior: FloatingLabelBehavior.always),
                                onSaved: (value) {
                                    totalProductionVolume = double.tryParse(value ?? "0") ?? totalProductionVolume;
                                }),
                  divider,
                  TextFormField(keyboardType: TextInputType.number,
                                decoration: const InputDecoration(hintText: 'Exemplo: 12',
                                                                  border: OutlineInputBorder(),
                                                                  label: Text("Quantidade de Leite Descartado"),
                                                                  floatingLabelBehavior: FloatingLabelBehavior.always),
                                onSaved: (value) {
                                    discardedProductionVolume = double.tryParse(value ?? "0") ?? discardedProductionVolume;
                                }),
                  divider,
                  TextFormField(keyboardType: TextInputType.text,
                                decoration: const InputDecoration(hintText: 'Exemplo: Muitas vacas estressadas.',
                                                                  border: OutlineInputBorder(),
                                                                  label: Text("Observação"),
                                                                  floatingLabelBehavior: FloatingLabelBehavior.always),
                                onSaved: (value) {
                                    observation = value ?? observation;
                                }),
                  saveSection,
          ]))
      );
    }
}
