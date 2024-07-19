import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';


class ArtificialInseminationForm extends StatefulWidget {
    final CentralController controller;

    const ArtificialInseminationForm({ super.key, required this.controller });

    @override
    State<ArtificialInseminationForm> createState() => _ArtificialInseminationFormState();

}

class _ArtificialInseminationFormState extends State<ArtificialInseminationForm> {
    final _formKey = GlobalKey<FormState>();
    Cow selectedCow = Cow(0, "UNKNOWN");

    @override
    Widget build(BuildContext context) {
        return FutureBuilder<dynamic>(
            future: widget.controller.bovineController.readCows(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                    if (snapshot.data == null) {
                        /* TODO: Log event. */
                        return Container(
                            padding: const EdgeInsets.all(8),
                            child: const Text(
                                'Algo falhou, favor contatar a equipe do INTEGRAZOO.',
                                textAlign: TextAlign.center,
                            )
                        );
                    }


                    final cows = snapshot.data!;

                    if (cows.isEmpty) {
                      return const IntegrazooBaseApp(body: Center(child: Text('Nenhuma vaca encontrada no rebanho.')));
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

                    final semenSelector = TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: 'Exemplo: 123-456-789',
                                                          border: OutlineInputBorder(),
                                                          label: Text("Sêmen"),
                                                          floatingLabelBehavior: FloatingLabelBehavior.always),
                    );

                    final bullsName = TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(hintText: 'Exemplo: Anão',
                                                          border: OutlineInputBorder(),
                                                          label: Text("Nome do Touro"),
                                                          floatingLabelBehavior: FloatingLabelBehavior.always),
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
                            child: const Text('CRIAR TENTATIVA'))
                        )
                    ]);

                    Divider divider = const Divider(height: 8, color: Colors.transparent);

                    return Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                            cowSelector,
                            divider,
                            semenSelector,
                            divider,
                            bullsName,
                            divider,
                            dateSelector,
                            saveButton
                        ])
                    );
                } else {
                    return const CircularProgressIndicator();
                }
            });
    }
}
