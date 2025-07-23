import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:integrazoo/domain/bovine/weighing.dart';
import 'package:integrazoo/domain/reproduction/pregnancy.dart';
import 'package:integrazoo/domain/reproduction/reproduction.dart';
import 'package:integrazoo/view/components/controller/bovine.dart';
import 'package:integrazoo/view/components/obrigatory_label.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';
import 'package:integrazoo/domain/bovine/sex.dart';
import 'package:integrazoo/domain/bovine/finish.dart';
import 'package:integrazoo/domain/bovine/finishing_reason.dart';

import 'package:integrazoo/view/forms/bovine/birth.dart';
import 'package:integrazoo/view/forms/bovine/entry.dart';
import 'package:integrazoo/view/forms/bovine/weaning.dart';
import 'package:integrazoo/view/forms/bovine/yearling_weight.dart';
import 'package:integrazoo/view/forms/bovine/finish.dart';



class BovineFormView extends StatefulWidget {
  final Bovine? bovine;
  final NaturalReproduction? naturalReproduction;
  final ArtificialInseminationReproduction? artificialInsemination;

  final VoidCallback? postSave;

  const BovineFormView({ super.key, this.postSave, this.bovine, this.naturalReproduction, this.artificialInsemination });

  @override
  State<BovineFormView> createState() => _BovineFormViewState();
}

class _BovineFormViewState extends State<BovineFormView> {
  bool _isExecuting = false;

  final _formKey = GlobalKey<FormState>();

  late final BovineController bovineController;

  bool isBreeder = false;
  Sex sex = Sex.female;

  late Isar isar;

  @override
  void initState() {
    super.initState();

    isar = GetIt.instance<Isar>();

    bovineController = BovineController(initialDate: widget.naturalReproduction?.date ?? widget.artificialInsemination?.date);

    if (widget.bovine != null) {
      bovineController.setBovine(widget.bovine!);
      isBreeder = widget.bovine!.isBreeder;
      sex = widget.bovine!.sex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final earringField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 123"
      ),
      controller: bovineController.earringController,
      validator: (value) {
        if (value == null) {
          return "Por favor, digite um brinco para o animal.";
        }

        final earring = int.tryParse(value);

        if (earring == null) {
          return "Por favor, digite um brinco válido para o animal.";
        }

        final exists = isar.bovines.getSync(earring) != null;

        if (exists) {
          return "Este brinco já é utilizado por outro animal.";
        }

        return null;
      }
    );

    final breedField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: Holandesa"
      ),
      controller: bovineController.breedController,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Por favor, digite a raça do animal.";
        }

        return null;
      }
    );

    final nameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: Mimosa"
      ),
      controller: bovineController.nameController,
    );

    final sexField = DropdownMenu<Sex?>(
      controller: bovineController.sexController,
      initialSelection: sex,
      dropdownMenuEntries: Sex.values.map((sex) => DropdownMenuEntry(value: sex, label: sex.toString())).toList(),
      onSelected: (value) {
        if (value == null) {
          return;
        }

        setState(() => sex = value);
      },
      expandedInsets: EdgeInsets.zero,
    );

    final breederField = Checkbox(value: isBreeder, onChanged: (value) {
      if (value == null) {
        return;
      }
      setState(() => isBreeder = value);
    });

    final submitButton = TextButton(
      onPressed: onSubmit,
      child: _isExecuting ?
        CircularProgressIndicator(padding: EdgeInsets.all(6.0), color: Colors.white) :
        Text("SALVAR")
    );

    return Form(
      autovalidateMode: AutovalidateMode.onUnfocus,
      key: _formKey,
      child: Padding(padding: EdgeInsets.all(8.0), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          Card(
            child: Padding(padding: EdgeInsets.all(16.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ObrigatoryLabel(field: "Identificação", size: 24),
                if (widget.bovine == null) ...[
                  ObrigatoryLabel(field: "Brinco"),
                  earringField,
                ],
                Text("Nome", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                nameField,
              ])
            )
          ),
          Card(
            child: Padding(padding: EdgeInsets.all(16.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ObrigatoryLabel(field: "Reprodução", size: 24),
                ObrigatoryLabel(field: "Sexo"),
                sexField,
                ObrigatoryLabel(field: "Raça"),
                breedField,
                Row(children: [
                  Text(sex == Sex.female ? "É matriz?" : "É reprodutor?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  breederField,
                ]),
              ])
            )
          ),
          BirthInfoFormView(
            controller: bovineController,
            required: widget.naturalReproduction != null || widget.artificialInsemination != null
            // dateController: bovineController.birthDateController,
            // weightController: bovineController.birthWeightController,
            // observationController: bovineController.birthObservationController
          ),
          if (widget.naturalReproduction == null && widget.artificialInsemination == null) ...[
            EntryFormView(
              dateController: bovineController.entryDateController,
              weightController: bovineController.entryWeightController,
              observationController: bovineController.entryObservationController
            ),
            WeaningFormView(
              dateController: bovineController.weaningDateController,
              weightController: bovineController.weaningWeightController,
              observationController: bovineController.weaningObservationController
            ),
            YearlingWeightFormView(
              dateController: bovineController.yearlingWeightDateController,
              weightController: bovineController.yearlingWeightWeightController,
              observationController: bovineController.yearlingWeightObservationController
            ),
            FinishFormView(
              dateController: bovineController.finishDateController,
              weightController: bovineController.finishWeightController,
              observationController: bovineController.finishObservationController,
              reasonController: bovineController.finishReasonController,
            ),
          ],
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              child: submitButton,
            ),
          ),
        ]
      ))
    );
  }

  void onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isExecuting = true);

    var bovine = Bovine()..earring = int.parse(bovineController.earringController.text)
                         ..name = bovineController.nameController.text.trim().isEmpty ? null : bovineController.nameController.text
                         ..sex = sex
                         ..breed =  bovineController.breedController.text.trim()
                         ..isBreeder = isBreeder
                         ..finishingReason = widget.bovine?.finishingReason ?? FinishingReason.notYet
                         ..bornFrom = widget.naturalReproduction != null ? ReproductionKind.natural : (
                           widget.artificialInsemination != null ? ReproductionKind.artificialInsemination : (
                            ReproductionKind.unknown
                           )
                         );

    Weighing? birth = widget.bovine?.birth.value;
    Weighing? weaning = widget.bovine?.weaning.value;
    Weighing? entry = widget.bovine?.entry.value;
    Weighing? yearling = widget.bovine?.yearling.value;
    Weighing? finish = widget.bovine?.finish.value;

    if (!isAllEmpty([
      bovineController.birthDateController,
      bovineController.birthWeightController,
      bovineController.birthObservationController
    ])) {
      birth = birth ?? Weighing();

      birth.date = DateFormat.yMd("pt_BR").parse(bovineController.birthDateController.text);
      birth.weight = double.parse(bovineController.birthWeightController.text);
      birth.observation = bovineController.birthObservationController.text.trim().isEmpty ? null : bovineController.birthObservationController.text;
    }

    if (!isAllEmpty([
      bovineController.entryDateController,
      bovineController.entryWeightController,
      bovineController.entryObservationController
    ])) {
      entry = entry ?? Weighing();

      entry.date = DateFormat.yMd("pt_BR").parse(bovineController.entryDateController.text);
      entry.weight = double.parse(bovineController.entryWeightController.text);
      entry.observation = bovineController.entryObservationController.text.trim().isEmpty ? null : bovineController.entryObservationController.text;
    }

    if (!isAllEmpty([
      bovineController.weaningDateController,
      bovineController.weaningWeightController,
      bovineController.weaningObservationController
    ])) {
      weaning = weaning ?? Weighing();

      weaning.date = DateFormat.yMd("pt_BR").parse(bovineController.weaningDateController.text);
      weaning.weight = double.parse(bovineController.weaningWeightController.text);
      weaning.observation = bovineController.weaningObservationController.text.trim().isEmpty ? null : bovineController.weaningObservationController.text;
    }

    if (!isAllEmpty([
      bovineController.yearlingWeightDateController,
      bovineController.yearlingWeightWeightController,
      bovineController.yearlingWeightObservationController
    ])) {
      yearling = yearling ?? Weighing();

      yearling.date = DateFormat.yMd("pt_BR").parse(bovineController.yearlingWeightDateController.text);
      yearling.weight = double.parse(bovineController.yearlingWeightWeightController.text);
      yearling.observation = bovineController.yearlingWeightObservationController.text.trim().isEmpty ?
                        null : bovineController.yearlingWeightObservationController.text;
    }

    if (!isAllEmpty([
      bovineController.finishReasonController,
      bovineController.finishDateController,
      bovineController.finishWeightController,
      bovineController.finishObservationController
    ])) {
      finish = finish ?? Weighing();

      finish.date = DateFormat.yMd("pt_BR").parse(bovineController.finishDateController.text);
      finish.weight = double.parse(bovineController.finishWeightController.text);
      finish.observation = bovineController.finishObservationController.text.trim().isEmpty ? null : bovineController.finishObservationController.text;

      bovine.finishingReason = FinishingReason.parse(bovineController.finishReasonController.text);
    }

    await isar.writeTxn(() async {
      if (birth != null) {
        bovine.birth.value = birth;
        birth.bovine.value = bovine;

        await isar.weighings.put(birth);
      }

      if (weaning != null) {
        bovine.weaning.value = weaning;
        weaning.bovine.value = bovine;

        await isar.weighings.put(weaning);
      }

      if (entry != null) {
        bovine.entry.value = entry;
        entry.bovine.value = bovine;

        await isar.weighings.put(entry);
      }

      if (yearling != null) {
        bovine.yearling.value = yearling;
        yearling.bovine.value = bovine;

        await isar.weighings.put(yearling);
      }

      if (finish != null) {
        bovine.finish.value = finish;
        finish.bovine.value = bovine;

        await isar.weighings.put(finish);
      }

      await isar.bovines.put(bovine);

      if (birth != null) {
        await birth.bovine.save();
        await bovine.birth.save();
      }

      if (weaning != null) {
        await weaning.bovine.save();
        await bovine.weaning.save();
      }

      if (entry != null) {
        await entry.bovine.save();
        await bovine.entry.save();
      }

      if (yearling != null) {
        await yearling.bovine.save();
        await bovine.yearling.save();
      }

      if (finish != null) {
        await finish.bovine.save();
        await bovine.finish.save();
      }

      if (widget.naturalReproduction != null) {
        widget.naturalReproduction!.born.value = bovine;
        widget.naturalReproduction!.pregnancy!.ending = PregnancyEndingReason.birth;
        widget.naturalReproduction!.pregnancy!.endingDate = bovine.birth.value!.date;

        await isar.naturalReproductions.put(widget.naturalReproduction!);

        await widget.naturalReproduction!.born.save();
      } else if (widget.artificialInsemination != null) {
        widget.artificialInsemination!.born.value = bovine;
        widget.artificialInsemination!.pregnancy!.ending = PregnancyEndingReason.birth;
        widget.artificialInsemination!.pregnancy!.endingDate = bovine.birth.value!.date;

        await isar.artificialInseminationReproductions.put(widget.artificialInsemination!);

        await widget.artificialInsemination!.born.save();
      }

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
