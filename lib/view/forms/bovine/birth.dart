import 'package:flutter/material.dart';
import 'package:integrazoo/view/components/controller/bovine.dart';
import 'package:integrazoo/view/components/obrigatory_label.dart';

import 'package:intl/intl.dart';


class BirthInfoFormView extends StatefulWidget {
  final bool required;
  final BovineController controller;
  // final TextEditingController dateController;
  // final TextEditingController weightController;
  // final TextEditingController observationController;

  const BirthInfoFormView({
    super.key,
    required this.controller,
    this.required = false
    // required this.dateController,
    // required this.weightController,
    // required this.observationController,
  });

  @override
  State<BirthInfoFormView> createState() => _BirthInfoFormViewState();
}

class _BirthInfoFormViewState extends State<BirthInfoFormView> {

  @override
  Widget build(BuildContext context) {
    final dateField = TextFormField(
      controller: widget.controller.birthDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 18/02/2002",
        suffixIcon: widget.controller.birthDateController.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => setState(() => widget.controller.birthDateController.clear()),
              )
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: null,
          firstDate: widget.controller.initialDate ?? DateTime(2000),
          lastDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly
        );
        if (pickedDate != null) {
          setState(() => widget.controller.birthDateController.text = DateFormat.yMd("pt_BR").format(pickedDate));
        }
      },
      validator: (value) {
        if (isAllEmpty() && !widget.required) return null;

        if (value == null || value.isEmpty) {
          return "Por favor, selecione uma data.";
        }
        return null;
      }
    );

    final weightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 55.7"
      ),
      controller: widget.controller.birthWeightController,
      validator: (value) {
        if (isAllEmpty() && !widget.required) return null;

        if (value == null || value.isEmpty) {
          return "Por favor digite o peso do animal,";
        }

        final weight = double.tryParse(value);

        if (weight == null ||  weight <= 0) {
          return "Por favor, digite um peso válido.";
        }

        return null;
      }
    );

    final observationField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: Animal muito magrinho."
      ),
      controller: widget.controller.birthObservationController,
    );

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Nascimento", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ObrigatoryLabel(field: "Data"),
          dateField,
          ObrigatoryLabel(field: "Peso"),
          weightField,
          Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          observationField,
        ])
      )
    );
  }

  bool isAllEmpty() {
    return widget.controller.birthDateController.text.trim().isEmpty &&
           widget.controller.birthWeightController.text.trim().isEmpty &&
           widget.controller.birthObservationController.text.trim().isEmpty;
  }
}
