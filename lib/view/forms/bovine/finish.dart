import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/domain/bovine/finishing_reason.dart';
import 'package:integrazoo/view/components/obrigatory_label.dart';

import 'package:intl/intl.dart';


class FinishFormView extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController weightController;
  final TextEditingController observationController;
  final TextEditingController reasonController;

  const FinishFormView({
    super.key,
    required this.dateController,
    required this.weightController,
    required this.observationController,
    required this.reasonController,
  });

  @override
  State<FinishFormView> createState() => _FinishFormViewState();
}

class _FinishFormViewState extends State<FinishFormView> {
  FinishingReason? reason;

  @override
  void initState() {
    super.initState();

    if (widget.reasonController.text.isNotEmpty) {
      reason = FinishingReason.parse(widget.reasonController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateField = TextFormField(
      controller: widget.dateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 18/02/2002",
        suffixIcon: widget.dateController.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => setState(() => widget.dateController.clear()),
              )
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: null,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly
        );
        if (pickedDate != null) {
          setState(() => widget.dateController.text = DateFormat.yMd("pt_BR").format(pickedDate));
        }
      },
      validator: (value) {
        if (isAllEmpty()) return null;

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
      controller: widget.weightController,
      validator: (value) {
        if (isAllEmpty()) return null;

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

    final reasonField = FormField<FinishingReason?>(
      validator: (value) {
        inspect(value);
        inspect(reason);
        if (isAllEmpty()) return null;

        if (reason == null) {
          return 'Por favor, selecione um motivo.';
        }

        return null;
      },
      builder: (formState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownMenu<FinishingReason?>(
              dropdownMenuEntries: FinishingReason.values.map((reason) =>
                DropdownMenuEntry(value: reason, label: reason.toString())
              ).toList(),
              hintText: "Selecione o tipo.",
              initialSelection: reason,
              onSelected: (value) {
                if (value == null) return;

                setState(() {
                  reason = value;

                  widget.reasonController.text = value.toString();

                  formState.didChange(value);
                });
              },
              expandedInsets: EdgeInsets.zero,
            ),
            if (formState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                child: Text(
                  formState.errorText ?? '',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );

    final observationField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: Animal muito magrinho."
      ),
      controller: widget.observationController,
    );

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Finalização", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ObrigatoryLabel(field: "Tipo"),
          reasonField,
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
    return widget.dateController.text.trim().isEmpty &&
           widget.weightController.text.trim().isEmpty &&
           widget.observationController.text.trim().isEmpty &&
           widget.reasonController.text.trim().isEmpty;
  }
}
