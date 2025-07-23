import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/view/components/controller/breeder.dart';


class SingleBreederSelector extends StatefulWidget {
  final BreederController breederController;

  const SingleBreederSelector({ super.key, required this.breederController });

  @override
  State<SingleBreederSelector> createState() => _SingleBreederSelector();
}

class _SingleBreederSelector extends State<SingleBreederSelector> {

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(
      border: OutlineInputBorder(),
      hintText: "Digite o nome ou identificador do animal e tecle ENTER.",
    );

    return ListenableBuilder(
      listenable: widget.breederController,
      builder: (BuildContext context, Widget? child) {
        if (widget.breederController.id != null) {
          return buildSelected();
        }
        return Row(children: [
          Expanded(child: TextFormField(
            controller: widget.breederController.queryController,
            decoration: decoration,
            onFieldSubmitted: widget.breederController.setBreeder,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (value) {
              if (value == null || value.trim().isEmpty || widget.breederController.id == null) {
                return "Por favor, selecione um animal.";
              }

              return null;
            }
          )),
        ]);
      }
    );
  }

  Widget buildSelected() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Text(widget.breederController.breeder?.toString() ?? ""),
          Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: widget.breederController.clear
          ),
        ])
      )
    );
  }
}
