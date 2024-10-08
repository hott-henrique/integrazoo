import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/artificial_insemination_attempt.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/reproduction_attempt.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/semen.dart';


class ArtificialInseminationForm extends StatefulWidget {
    final CentralController controller;

    const ArtificialInseminationForm({ super.key, required this.controller });

    @override
    State<ArtificialInseminationForm> createState() => _ArtificialInseminationFormState();
}

class _ArtificialInseminationFormState extends State<ArtificialInseminationForm> {
  final _formKey = GlobalKey<FormState>();

  ArtificialInseminationAttempt artificialInseminationAttempt = ArtificialInseminationAttempt(0, Cow(0, "UNKNOWN"), Semen(0, "0", "UNKNOWN"), DateTime.now(), ReproductionDiagonostic.waiting);

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return AlertDialog(
        title: const Text('Falha ao registrar produção.'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[ const Text('Algo falhou ao registrar produção do animal.'),
                                const Text('Por favor, contate a equipe INTEGRAZOO.'),
                                Text(exception.toString()) ],
          ),
        ),
        actions: <Widget>[ TextButton(child: const Text('Fechar'), onPressed: () => setState(() => exception = null)) ],
      );
    }

    final dateField = InputDatePickerFormField(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data",
      onDateSaved: (value) => artificialInseminationAttempt.date = value,
    );

    final semenField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(hintText: 'Exemplo: 123-456-789',
                                        border: OutlineInputBorder(),
                                        label: Text("Sêmen"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => artificialInseminationAttempt.semen.number = value ?? artificialInseminationAttempt.semen.number,
    );

    final bullsName = TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(hintText: 'Exemplo: Soberano',
                                          border: OutlineInputBorder(),
                                          label: Text("Nome do Touro"),
                                          floatingLabelBehavior: FloatingLabelBehavior.always),
        onSaved: (value) => artificialInseminationAttempt.semen.bullsName = value ?? artificialInseminationAttempt.semen.bullsName,
    );

    final saveButton = Row(children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              widget.controller.semenController.isSemenPresent(artificialInseminationAttempt.semen).then(
                (semenIsPresent) {
                  if (!semenIsPresent) {
                    /* Have to use .then() after insert to sync the semen id with what was inserted. */
                    widget.controller.semenController.insertSemen(artificialInseminationAttempt.semen).then(
                      (value) {
                        registerArtificialInseminationAttempt(context);
                      }
                    );
                  } else {
                    widget.controller.reproductionController.registerArtificialInseminationAttempt(artificialInseminationAttempt).then(
                      (_) {
                        registerArtificialInseminationAttempt(context);
                      },
                      onError: (e) => setState(() => exception = e)
                    );
                  }

                },
                onError: (e) => setState(() => exception = e)
              );
            }
          },
          child: const Text('REGISTRAR TENTATIVA')
        )
      )
    ]);
    return IntegrazooBaseApp(body:
      FutureBuilder<List<Cow>>(
        future: widget.controller.bovineController.readCows(),
        builder: (context, AsyncSnapshot<List<Cow>> snapshot) {
          if (snapshot.hasData) {
            final cows = snapshot.data!;

            if (cows.isEmpty) {
              return const Center(child: Text('Nenhuma vaca encontrada no rebanho.'));
            }

            artificialInseminationAttempt.cow = cows[0];

            final cowSelector = DropdownMenu<Cow>(
              initialSelection: cows[0],
              dropdownMenuEntries: cows.map((cow) => DropdownMenuEntry(value: cow, label: '[${cow.id}] ${cow.name}')).toList(),
              onSelected: (value) => artificialInseminationAttempt.cow = value ?? artificialInseminationAttempt.cow,
              label: const Text('Vaca'),
              expandedInsets: EdgeInsets.zero,
              menuHeight: 300,
              inputDecorationTheme: const InputDecorationTheme(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder()
              )
            );

            Divider divider = const Divider(height: 8, color: Colors.transparent);

            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Column(children: [
                  cowSelector,
                  divider,
                  semenField,
                  divider,
                  bullsName,
                  divider,
                  dateField,
                  saveButton
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

  void registerArtificialInseminationAttempt(BuildContext context) {
    widget.controller.reproductionController.registerArtificialInseminationAttempt(artificialInseminationAttempt).then(
      (_) {
        SnackBar snackBar = const SnackBar(content: Text('TENTATIVA DE REPRODUÇÃO REGISTRADA.'), showCloseIcon: true);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();
      },
      onError: (e) => setState(() => exception = e)
    );
  }
}
