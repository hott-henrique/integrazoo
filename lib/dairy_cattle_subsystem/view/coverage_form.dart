import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/bull.dart';


class CoverageForm extends StatefulWidget {
    final CentralController controller;

    const CoverageForm({ super.key, required this.controller });

    @override
    State<CoverageForm> createState() => _CoverageFormState();

}


class _CoverageFormState extends State<CoverageForm> {
    final _formKey = GlobalKey<FormState>();
    Cow selectedCow = Cow(0, "UNKNOWN");
    Bull selectedBull = Bull(0, "UNKNOWN");

    @override
    Widget build(BuildContext context) {
        return IntegrazooBaseApp(body:
        FutureBuilder<dynamic>(
            future: fetchAnimals(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                    if (snapshot.data[0] == null || snapshot.data[1] == null) {
                        /* TODO: Log event. */
                        return Container(
                            padding: const EdgeInsets.all(8),
                            child: const Text(
                                'Algo falhou, favor contatar a equipe do INTEGRAZOO.',
                                textAlign: TextAlign.center,
                            )
                        );
                    }

                    final cows = snapshot.data[0]!;
                    final bulls = snapshot.data[1]!;

                    if (cows.isEmpty) {
                      return const Center(child: Text('Nenhuma vaca encontrada no rebanho.'));
                    }

                    if (bulls.isEmpty) {
                      return const Center(child: Text('Nenhum boi encontrado no rebanho.'));
                    }

                    final cowSelector = DropdownMenu<Cow>(
                        initialSelection: cows[0],
                        dropdownMenuEntries: (cows as List<Cow>).map((cow) {
                            return DropdownMenuEntry(value: cow, label: '[${cow.id}] ${cow.name}');
                        }).toList(),
                        onSelected: (value) {
                            selectedCow = value ?? selectedCow;
                        },
                        label: const Text('Vaca'),
                        expandedInsets: EdgeInsets.zero,
                        menuHeight: 300,
                        inputDecorationTheme: const InputDecorationTheme(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder()
                        )
                    );

                    final bullSelector = DropdownMenu<Bull>(
                        initialSelection: bulls[0],
                        dropdownMenuEntries: (bulls as List<Bull>).map((bull) => DropdownMenuEntry(value: bull, label: '[${bull.id}] ${bull.name}')).toList(),
                        onSelected: (value) {
                            selectedBull = value ?? selectedBull;
                        },
                        label: const Text('Touro'),
                        expandedInsets: EdgeInsets.zero,
                        menuHeight: 300,
                        inputDecorationTheme: const InputDecorationTheme(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder()
                        )
                    );

                    final dateSelector = InputDatePickerFormField(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        keyboardType: TextInputType.text,
                        fieldLabelText: "Data",
                    );

                    final saveButton = Row(children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                    Navigator.of(context).pop();
                                },
                                child: const Text('CRIAR TENTATIVA')
                            )
                        )
                    ]);

                    Divider divider = const Divider(height: 8, color: Colors.transparent);

                    return Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                            cowSelector,
                            divider,
                            bullSelector,
                            divider,
                            dateSelector,
                            saveButton
                        ])
                    );
                } else {
                    return const CircularProgressIndicator();
                }
            })
        );
    }

    Future<dynamic> fetchAnimals() async {
        return [
            await widget.controller.bovineController.readCows(),
            await widget.controller.bovineController.readBulls()
        ];
    }
}
