import 'package:flutter/material.dart';
import 'package:integrazoo/domain/bovine/bovine.dart';
import 'package:integrazoo/domain/bovine/sex.dart';
import 'package:intl/intl.dart';

class BovineController {
  final DateTime? initialDate;

  final nameController = TextEditingController();
  final earringController = TextEditingController();
  final breedController = TextEditingController();

  final birthDateController = TextEditingController();
  final birthWeightController = TextEditingController();
  final birthObservationController = TextEditingController();

  final entryDateController = TextEditingController();
  final entryWeightController = TextEditingController();
  final entryObservationController = TextEditingController();

  final weaningDateController = TextEditingController();
  final weaningWeightController = TextEditingController();
  final weaningObservationController = TextEditingController();

  final yearlingWeightDateController = TextEditingController();
  final yearlingWeightWeightController = TextEditingController();
  final yearlingWeightObservationController = TextEditingController();

  final finishReasonController = TextEditingController();
  final finishDateController = TextEditingController();
  final finishWeightController = TextEditingController();
  final finishObservationController = TextEditingController();

  final sexController = TextEditingController();

  Sex sex = Sex.female;
  bool isBreeder = false;

  BovineController({ required this.initialDate });

  void setBovine(Bovine bovine) {
    bovine.ensureLoadedSync();

    sexController.text = sex.toString();

    earringController.text = bovine.earring.toString();
    sexController.text = bovine.sex.toString();
    nameController.text = bovine.name ?? "";
    breedController.text = bovine.breed;
    isBreeder = bovine.isBreeder;

    final dateFormater = DateFormat.yMd("pt_BR");

    if (bovine.birth.value != null) {
      final birth = bovine.birth.value!;

      birthDateController.text = dateFormater.format(birth.date);
      birthWeightController.text = birth.weight.toString();
      birthObservationController.text = birth.observation ?? "";
    }

    if (bovine.entry.value != null) {
      final entry = bovine.entry.value!;

      entryDateController.text = dateFormater.format(entry.date);
      entryWeightController.text = entry.weight.toString();
      entryObservationController.text = entry.observation ?? "";
    }

    if (bovine.weaning.value != null) {
      final weaning = bovine.weaning.value!;

      weaningDateController.text = dateFormater.format(weaning.date);
      weaningWeightController.text = weaning.weight.toString();
      weaningObservationController.text = weaning.observation ?? "";
    }

    if (bovine.yearling.value != null) {
      final yearlingWeight = bovine.yearling.value!;

      yearlingWeightDateController.text = dateFormater.format(yearlingWeight.date);
      yearlingWeightWeightController.text = yearlingWeight.weight.toString();
      yearlingWeightObservationController.text = yearlingWeight.observation ?? "";
    }

    if (bovine.finish.value != null) {
      final finish = bovine.finish.value!;

      finishReasonController.text = bovine.finishingReason.code;
      finishDateController.text = dateFormater.format(finish.date);
      finishWeightController.text = finish.weight.toString();
      finishObservationController.text = finish.observation ?? "";
    }
  }
}
