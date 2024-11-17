import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/database/database.dart';


class BovineForm extends StatefulWidget {
  const BovineForm({ super.key });

  @override
  BovineFormState createState() {
    return BovineFormState();
  }
}

class BovineFormState extends State<BovineForm> {
  final _formKey = GlobalKey<FormState>();

  String bovineName = "";
  Sex bovineSex = Sex.female;

  bool hasFailedOnce = false;

  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      inspect(exception);
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    const TextStyle formHeadingTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

    const nameHeader =  Text("Nome", style: formHeadingTextStyle);
    final nameField = TextFormField(
      keyboardType: TextInputType.name,
      autocorrect: false,
      showCursor: true,
      onSaved: (name) { bovineName = name!; },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return null;
        }

        if (value.length < 3) {
          return "O nome do animal deve conter ao menos 3 letras.";
        }

        bovineName = value;

        return null;
      },
      decoration: const InputDecoration(hintText: 'Exemplo: Mimosa', border: OutlineInputBorder())
    );

    const sexHeader = Text("Sexo", style: formHeadingTextStyle);
    final sexDropdown = DropdownButton<Sex>(
      value: bovineSex,
      items: Sex.values.map((sex) => DropdownMenuItem(value: sex, child: Text(sex.toString()))).toList(),
      onChanged: (value) {
        inspect(value);
        setState(() => bovineSex = value!);
      },
      hint: const Text("Sexo"),
      isExpanded: true,
    );

    final addButton = Button(text: "Adicionar", color: Colors.green[400]!, onPressed: createBovine);

    final column = <Widget>[
      nameHeader,
      nameField,
      sexHeader,
      sexDropdown,
      addButton
    ];

    return IntegrazooBaseApp(body: SingleChildScrollView(child: Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
      )
    )));
  }

  void createBovine() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      final bovine = Bovine.fromJson({ 'id': 0, 'name': bovineName, 'sex': bovineSex.index });

      BovineController.createBovine(bovine).then(
        (_) {
          if (context.mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Animal adicionado.'),
              backgroundColor: Colors.green,
              showCloseIcon: true
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).pop();
          }
        },
        onError: (e) => setState(() => exception = e)
      );
    }
  }
}
