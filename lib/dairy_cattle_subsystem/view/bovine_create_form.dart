import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/bovine.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';


class BovineCreateForm extends StatefulWidget {
    final CentralController controller;
    const BovineCreateForm({super.key, required this.controller});

    @override
    CattleFormState createState() {
        return CattleFormState();
    }
}

class CattleFormState extends State<BovineCreateForm> {
    final _formKey = GlobalKey<FormState>();

    Bovine c = Bovine(0, "", Sex.female);
    bool hasFailedOnce = false;

    @override
    Widget build(BuildContext context) {
        if (hasFailedOnce) {
            /* TODO: Log this fail. */
            return AlertDialog(
                title: const Text('Falha ao criar animal.'),
                content: const SingleChildScrollView(
                    child: ListBody(
                        children: <Widget>[ Text('Algo falhou ao criar o animal.'),
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

        const TextStyle formHeadingTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

        return  IntegrazooBaseApp(body: SingleChildScrollView(child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        const Text("Nome", style: formHeadingTextStyle),
                        TextFormField(keyboardType: TextInputType.name,
                                      autocorrect: false,
                                      showCursor: true,
                                      onSaved: (name) { c.name = name!; },
                                      validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                              return null;
                                          }

                                          if (value.length <= 3) {
                                                return "O nome do animal deve conter ao menos 3 letras.";
                                          }

                                          c.name = value;

                                          return null;
                                      },
                                      decoration: const InputDecoration(hintText: 'Exemplo: Mimosa',
                                                                        border: OutlineInputBorder())
                        ),

                        const Text("Sexo", style: formHeadingTextStyle),
                        DropdownButton<Sex>(
                                value: c.sex,
                                items: Sex.values.map((sex) => DropdownMenuItem(value: sex, child: Text(sex.toString()))).toList(),
                                onChanged: (value) { setState(() { c.sex = value!; }); },
                                hint: const Text("Sexo"),
                                isExpanded: true,
                        ),

                        Row(children: [
                            Expanded(child: ElevatedButton(onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                        _formKey.currentState?.save();
                                        widget.controller.bovineController.createBovine(c).then(
                                            (wasSuccessful) {
                                                if (wasSuccessful) {
                                                    SnackBar snackBar = const SnackBar(
                                                        content: Text('ANIMAL ADICIONADO'),
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
                                child: const Text('ADICIONAR'))
                            )
                        ]),
                    ]
                ),
            )
        )));
    }
}
