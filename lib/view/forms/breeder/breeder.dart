import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:integrazoo/domain/bovine/sex.dart';

import 'package:integrazoo/domain/reproduction/breeder.dart';
import 'package:integrazoo/view/components/obrigatory_label.dart';
import 'package:isar/isar.dart';


class BreederFormView extends StatefulWidget {
  final Breeder? breeder;
  final VoidCallback? postSave;

  const BreederFormView({ super.key, this.breeder, this.postSave });

  @override
  State<BreederFormView> createState() {
    return _BreederFormView();
  }
}

class _BreederFormView extends State<BreederFormView> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final identifierController = TextEditingController();

  final breedController = TextEditingController();

  final sexController = TextEditingController();

  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();

  final paternalGrandfatherNameController = TextEditingController();
  final paternalGrandmotherNameController = TextEditingController();

  final maternalGrandfatherNameController = TextEditingController();
  final maternalGrandmotherNameController = TextEditingController();

  final epdBirthWeightController = TextEditingController();
  final epdWeaningWeightController = TextEditingController();
  final epdYearlingWeightController = TextEditingController();

  bool _isExecuting = false;

  Sex sex = Sex.female;

  late Isar isar;

  @override
  void initState() {
    super.initState();

    isar = GetIt.I<Isar>();

    nameController.text = widget.breeder?.name ?? "";

    identifierController.text = widget.breeder?.identifier ?? "";

    breedController.text = widget.breeder?.breed.toString() ?? "";

    sexController.text = widget.breeder?.sex.toString() ?? "";

    fatherNameController.text = widget.breeder?.parents?.father ?? "";
    motherNameController.text = widget.breeder?.parents?.mother ?? "";

    paternalGrandfatherNameController.text = widget.breeder?.fatherGrandParents?.father ?? "";
    paternalGrandmotherNameController.text = widget.breeder?.fatherGrandParents?.mother ?? "";

    maternalGrandfatherNameController.text = widget.breeder?.motherGrandParents?.father ?? "";
    maternalGrandmotherNameController.text = widget.breeder?.motherGrandParents?.mother ?? "";

    epdBirthWeightController.text = widget.breeder?.epd?.birthWeight?.toString() ?? "";
    epdWeaningWeightController.text = widget.breeder?.epd?.weaningWeight?.toString() ?? "";
    epdYearlingWeightController.text = widget.breeder?.epd?.yearlingWeight?.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      keyboardType: TextInputType.text,
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite o nome do reprodutor."
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Por favor, digite o nome do reprodutor.";
        }

        return null;
      }
    );

    final identifierField = TextFormField(
      keyboardType: TextInputType.text,
      controller: identifierController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite o identificador do reprodutor."
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Por favor, digite o identificador do reprodutor.";
        }

        if (isar.breeders.filter().identifierEqualTo(value).findFirstSync() != null) {
          return "Já existe um reprodutor com esse identificador.";
        }

        return null;
      }
    );

    final breedField = TextFormField(
      keyboardType: TextInputType.text,
      controller: breedController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite a raça do animal."
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Por favor, digite a raça do animal.";
        }

        return null;
      }
    );

    final sexField = DropdownMenu<Sex?>(
      controller: sexController,
      dropdownMenuEntries: Sex.values.map((sex) => DropdownMenuEntry(value: sex, label: sex.toString())).toList(),
      hintText: "Fêmea",
      onSelected: (value) {
        if (value == null) {
          return;
        }

        setState(() => sex = value);
      },
      expandedInsets: EdgeInsets.zero,
    );

    final fatherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite o nome do pai."
      ),
      controller: fatherNameController
    );

    final motherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite o nome da mãe."
      ),
      controller: motherNameController,
    );

    final paternalGrandfatherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite o nome do avô paterno"
      ),
      controller: paternalGrandfatherNameController,
    );

    final paternalGrandmotherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite o nome da avó paterna"
      ),
      controller: paternalGrandmotherNameController,
    );

    final maternalGrandfatherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite o nome do avô materno"
      ),
      controller: maternalGrandfatherNameController,
    );

    final maternalGrandmotherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Digite o nome da avó materna"
      ),
      controller: maternalGrandmotherNameController,
    );

    final epdBirthWeightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        hintText: "Digite o peso ao nascimento do animal."),
      controller: epdBirthWeightController,
      validator: (String? value) {
        if (value == null) {
          return null;
        }

        if (value.isNotEmpty && double.tryParse(value) == null) {
          return "Por favor, digite um número válido.";
        }

        return null;
      },
    );

    final epdWeaningWeightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        hintText: "Digite o peso a desmama do animal."),
      controller: epdWeaningWeightController,
      validator: (String? value) {
        if (value == null) {
          return null;
        }

        if (value.isNotEmpty && double.tryParse(value) == null) {
          return "Por favor, digite um número válido.";
        }

        return null;
      },
    );

    final epdYearlingWeightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        hintText: "Digite o peso do animal ao entrar."),
      controller: epdYearlingWeightController,
      validator: (String? value) {
        if (value == null) {
          return null;
        }

        if (value.isNotEmpty && double.tryParse(value) == null) {
          return "Por favor, digite um número válido.";
        }

        return null;
      },
    );

    final submitButton = TextButton(
      onPressed: onSubmit,
      child: _isExecuting ?
        CircularProgressIndicator(padding: EdgeInsets.all(6.0), color: Colors.white) :
        Text("SALVAR")
    );

    final column = <Widget>[
      if (widget.breeder == null) ...[
        Card(
          child: Padding(padding: EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ObrigatoryLabel(field: "Identificação", size: 24),
              ObrigatoryLabel(field: "Nome"),
              nameField,
              ObrigatoryLabel(field: "Identificador"),
              identifierField,
            ])
          )
        ),
      ],
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ObrigatoryLabel(field: "Reprodução", size: 24),
            ObrigatoryLabel(field: "Sexo"),
            sexField,
            ObrigatoryLabel(field: "Raça"),
            breedField
          ])
        )
      ),
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Diferença Esperada na Progênie (DEP)", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Peso ao Nascimento (PN)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            epdBirthWeightField,
            Text("Peso a Desmama (PD)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            epdWeaningWeightField,
            Text("Peso ao Sobreano (PA)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            epdYearlingWeightField,
          ])
        )
      ),
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Pais", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Pai", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            fatherNameField,
            Text("Mãe", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            motherNameField,
          ])
        )
      ),
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Avó Paternos", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Avô", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            paternalGrandfatherNameField,
            Text("Avó", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            paternalGrandmotherNameField,
          ])
        )
      ),
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Avó Maternos", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Avô", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            maternalGrandfatherNameField,
            Text("Avó", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            maternalGrandmotherNameField,
          ])
        )
      ),
      submitButton
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        key: _formKey,
        child: Column(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: column
        )
      )
    );
  }

  void onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var breeder = Breeder()..name = nameController.text
                           ..identifier = identifierController.text
                           ..breed = breedController.text
                           ..sex = sex;

    if (widget.breeder != null) {
      breeder.id = widget.breeder!.id;
    }

    if (!isAllEmpty([ fatherNameController, motherNameController ])) {
      breeder.parents = BreederParents()..father = fatherNameController.text.trim().isEmpty ? null : fatherNameController.text
                                        ..mother = motherNameController.text.trim().isEmpty ? null : motherNameController.text;
    }

    if (!isAllEmpty([ paternalGrandfatherNameController, paternalGrandmotherNameController ])) {
      breeder.fatherGrandParents = BreederParents()..father = paternalGrandfatherNameController.text.trim().isEmpty ?
                                                              null : paternalGrandfatherNameController.text
                                                   ..mother = paternalGrandmotherNameController.text.trim().isEmpty ?
                                                              null : paternalGrandmotherNameController.text;
    }

    if (!isAllEmpty([ maternalGrandfatherNameController, maternalGrandmotherNameController ])) {
      breeder.motherGrandParents = BreederParents()..father = maternalGrandfatherNameController.text.trim().isEmpty ?
                                                              null : maternalGrandfatherNameController.text
                                                   ..mother = maternalGrandmotherNameController.text.trim().isEmpty ?
                                                              null : maternalGrandmotherNameController.text;
    }

    if (!isAllEmpty([ epdBirthWeightController, epdWeaningWeightController, epdYearlingWeightController ])) {
      breeder.epd = BreederEPD()..birthWeight = double.tryParse(epdBirthWeightController.text)
                                ..weaningWeight = double.tryParse(epdWeaningWeightController.text)
                                ..yearlingWeight = double.tryParse(epdYearlingWeightController.text);
    }


    await isar.writeTxn(() async {
      await isar.breeders.put(breeder);

      setState(() => _isExecuting = false);
    }).then((_) => widget.postSave?.call());
  }

  bool isAllEmpty(List<TextEditingController> controllers) {
      for (var controller in controllers) {
        if (controller.text.trim().isNotEmpty) {
          return false;
        }
      }
      return true;
  }
}
