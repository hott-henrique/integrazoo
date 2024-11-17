import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/database/database.dart';

// import 'package:integrazoo/model/bovine/bovine.dart';


class BovineCreateForm extends StatefulWidget {
  const BovineCreateForm({ super.key });

  @override
  CattleFormState createState() {
    return CattleFormState();
  }
}

class CattleFormState extends State<BovineCreateForm> {
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

    return IntegrazooBaseApp(body: SingleChildScrollView(child: Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Nome", style: formHeadingTextStyle),
            TextFormField(
              keyboardType: TextInputType.name,
              autocorrect: false,
              showCursor: true,
              onSaved: (name) { bovineName = name!; },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return null;
                }

                if (value.length <= 3) {
                  return "O nome do animal deve conter ao menos 3 letras.";
                }

                bovineName = value;

                return null;
              },
              decoration: const InputDecoration(hintText: 'Exemplo: Mimosa', border: OutlineInputBorder())
            ),

            const Text("Sexo", style: formHeadingTextStyle),
            DropdownButton<Sex>(
              value: bovineSex,
              items: Sex.values.map((sex) => DropdownMenuItem(value: sex, child: Text(sex.toString()))).toList(),
              onChanged: (value) {
                inspect(value);
                setState(() => bovineSex = value!);
              },
              hint: const Text("Sexo"),
              isExpanded: true,
            ),

            Row(children: [
              Expanded(child: ElevatedButton(
                onPressed: () {
                  final bovine = Bovine.fromJson({ 'id': 0, 'name': bovineName, 'sex': bovineSex.index });
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    BovineController.createBovine(bovine).then(
                      (_) {
                        SnackBar snackBar = const SnackBar(content: Text('ANIMAL ADICIONADO'), showCloseIcon: true);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop();
                      },
                      onError: (e) => setState(() => exception = e)
                    );
                  }
                },
                child: const Text('ADICIONAR')
              ))
            ])
          ]
        )
      )
    )));
  }
}
