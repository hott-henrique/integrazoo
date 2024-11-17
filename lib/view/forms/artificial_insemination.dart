import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';
import 'package:integrazoo/control/semen_controller.dart';


class ArtificialInseminationForm extends StatefulWidget {
  const ArtificialInseminationForm({ super.key });

  @override
  State<ArtificialInseminationForm> createState() => _ArtificialInseminationFormState();
}

class _ArtificialInseminationFormState extends State<ArtificialInseminationForm> {
  final _formKey = GlobalKey<FormState>();

  int cowId = 0;
  int semenId = 0;
  DateTime artificialInseminationDate = DateTime.now();
  String semenNumber = "";
  String bullsName = "";

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      inspect(exception);
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final dateField = InputDatePickerFormField(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data",
      onDateSaved: (value) => artificialInseminationDate = value,
    );

    final semenField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(hintText: 'Exemplo: 123-456-789',
                                        border: OutlineInputBorder(),
                                        label: Text("Sêmen"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => semenNumber = value ?? semenNumber
    );

    final bullsNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(hintText: 'Exemplo: Soberano',
                                        border: OutlineInputBorder(),
                                        label: Text("Nome do Touro"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      onSaved: (value) => bullsName = value ?? bullsName,
    );

    final saveButton = Row(children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              inspect(semenNumber);
              inspect(bullsName);
              final semen = Semen.fromJson({
                'semenNumber': semenNumber,
                'bullName': bullsName,
              });
              inspect(semen);
              SemenController.insertSemen(semen).then(
                (value) => registerArtificialInseminationAttempt(context)
              );
            }
          },
          child: const Text('REGISTRAR TENTATIVA')
        )
      )
    ]);

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

        cowId = cows[0].id;

        final cowSelector = DropdownMenu<Bovine>(
          initialSelection: cows[0],
          dropdownMenuEntries: cows.map((cow) => DropdownMenuEntry(value: cow, label: '[${cow.id}] ${cow.name}')).toList(),
          onSelected: (value) => cowId = value!.id,
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
              bullsNameField,
              divider,
              dateField,
              saveButton
            ])
          )
        );
      }
      )
    );
  }

  void registerArtificialInseminationAttempt(BuildContext context) {
    final reproduction = Reproduction.fromJson({
      'id': 0,
      'kind': ReproductionKind.artificialInsemination.index,
      'diagnostic': ReproductionDiagonostic.waiting.index,
      'date': artificialInseminationDate,
      'cow': cowId,
      'bull': 0,
      'semen': semenNumber,
    });

    ReproductionController.registerArtificialInseminationAttempt(reproduction).then(
      (_) {
        SnackBar snackBar = const SnackBar(content: Text('TENTATIVA DE REPRODUÇÃO REGISTRADA.'), showCloseIcon: true);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();
      },
      onError: (e) => setState(() => exception = e)
    );
  }
}
