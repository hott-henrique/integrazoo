import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/view/components/controller/earring.dart';


class SingleBovineSelector extends StatefulWidget {
  final EarringController earringController;

  const SingleBovineSelector({ super.key, required this.earringController });

  @override
  State<SingleBovineSelector> createState() => _SingleBovineSelector();
}

class _SingleBovineSelector extends State<SingleBovineSelector> {

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(
      border: OutlineInputBorder(),
      hintText: "Digite o brinco do animal e tecle ENTER.",
    );

    return ListenableBuilder(
      listenable: widget.earringController,
      builder: (BuildContext context, Widget? child) {
        if (widget.earringController.bovine != null) {
          return buildSelected();
        }

        return Row(children: [
          Expanded(child: TextFormField(
            controller: widget.earringController.queryController,
            decoration: decoration,
            onFieldSubmitted: (value) {
              int? e = int.tryParse(value);
              widget.earringController.setEarring(e);
            },
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (value) {
              if (value == null || value.trim().isEmpty || widget.earringController.earring == null) {
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
          Text(widget.earringController.bovine!.toString()),
          Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: widget.earringController.clear
          ),
        ])
      )
    );
  }
}
