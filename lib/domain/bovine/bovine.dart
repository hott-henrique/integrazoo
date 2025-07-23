import 'package:excel/excel.dart';
import 'package:integrazoo/domain/bovine/finishing_reason.dart';
import 'package:integrazoo/domain/bovine/weighing.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/sex.dart';
import 'package:integrazoo/domain/bovine/birth.dart';
import 'package:integrazoo/domain/bovine/entry.dart';
import 'package:integrazoo/domain/bovine/weaning.dart';
import 'package:integrazoo/domain/bovine/yearling_weight.dart';
import 'package:integrazoo/domain/bovine/finish.dart';

import 'package:integrazoo/domain/reproduction/reproduction.dart';
import 'package:integrazoo/domain/reproduction/reproduction_diagnostic.dart';

import 'package:integrazoo/domain/health/treatment.dart';
import 'package:integrazoo/domain/health/vaccine.dart';

part 'bovine.g.dart';


enum ReproductionKind {
  unknown("unkown", "Desconhecido"),
  artificialInsemination("artificialInsemination", "Inseminação Artificial"),
  natural("natural", "Cobertura");

  const ReproductionKind(this.code, this.label);

  final String code;
  final String label;

  @override
  String toString() => label;
}

@collection
class Bovine {
  late Id earring;

  late String breed;

  String? name;

  @Enumerated(EnumType.name)
  late Sex sex;

  late bool isBreeder;

  final birth = IsarLink<Weighing>();
  final weaning = IsarLink<Weighing>();
  final entry = IsarLink<Weighing>();
  final yearling = IsarLink<Weighing>();

  @enumerated
  late FinishingReason finishingReason;
  final finish = IsarLink<Weighing>();

  @Backlink(to: 'cow')
  final naturalReproductionsFEMALE = IsarLinks<NaturalReproduction>();

  @Backlink(to: 'bull')
  final naturalReproductionsMALE = IsarLinks<NaturalReproduction>();

  @Backlink(to: 'cow')
  final artificialInseminations = IsarLinks<ArtificialInseminationReproduction>();

  @Backlink(to: 'bovine')
  final vaccines = IsarLinks<Vaccine>();

  @Backlink(to: 'bovine')
  final treatments = IsarLinks<Treatment>();

  @Backlink(to: 'bovine')
  final weighings = IsarLinks<Weighing>();

  @enumerated
  late ReproductionKind bornFrom;

  @Backlink(to: 'born')
  final artificialInsemination = IsarLink<ArtificialInseminationReproduction>();
  @Backlink(to: 'born')
  final naturalReproduction = IsarLink<NaturalReproduction>();

  static List<CellValue> asHeader() {
    return [
      TextCellValue("Brinco"),
      TextCellValue("Nome"),
      TextCellValue("Raça"),
      TextCellValue("Sexo"),
      TextCellValue("Matriz / Reprodutor"),
    ];
  }

  static List<CellValue> asBirthHeader() {
    return [
      TextCellValue("Brinco"),
      TextCellValue("Data"),
      TextCellValue("Peso"),
      TextCellValue("Observação"),
    ];
  }

  static List<CellValue> asWeaningHeader() {
    return [
      TextCellValue("Brinco"),
      TextCellValue("Data"),
      TextCellValue("Peso"),
      TextCellValue("Observação"),
    ];
  }

  static List<CellValue> asYearlingHeader() {
    return [
      TextCellValue("Brinco"),
      TextCellValue("Data"),
      TextCellValue("Peso"),
      TextCellValue("Observação"),
    ];
  }

  static List<CellValue> asFinishHeader() {
    return [
      TextCellValue("Brinco"),
      TextCellValue("Data"),
      TextCellValue("Peso"),
      TextCellValue("Motivação"),
      TextCellValue("Observação"),
    ];
  }

  static List<CellValue> asEntryHeader() {
    return [
      TextCellValue("Brinco"),
      TextCellValue("Data"),
      TextCellValue("Peso"),
      TextCellValue("Observação"),
    ];
  }

  List<CellValue> asRow() {
    return [
      IntCellValue(earring),
      TextCellValue(name ?? ""),
      TextCellValue(breed),
      TextCellValue(sex.toString()),
      TextCellValue(isBreeder ? "Verdadeiro" : "Falso"),
    ];
  }

  List<CellValue> asBirthRow() {
    birth.loadSync();

    return [
      IntCellValue(earring),
      if (birth.value?.date != null) DateTimeCellValue.fromDateTime(birth.value!.date) else TextCellValue(""),
      if (birth.value?.weight != null) DoubleCellValue(birth.value!.weight) else TextCellValue(""),
      if (birth.value?.observation != null) TextCellValue(birth.value!.observation ?? "")
    ];
  }

  List<CellValue> asWeaningRow() {
    weaning.loadSync();

    return [
      IntCellValue(earring),
      if (birth.value?.date != null) DateTimeCellValue.fromDateTime(weaning.value!.date) else TextCellValue(""),
      if (birth.value?.weight != null) DoubleCellValue(weaning.value!.weight) else TextCellValue(""),
      if (birth.value?.observation != null) TextCellValue(weaning.value!.observation ?? "")
    ];
  }

  List<CellValue> asYearlingRow() {
    yearling.loadSync();

    return [
      IntCellValue(earring),
      if (yearling.value?.date != null) DateTimeCellValue.fromDateTime(yearling.value!.date) else TextCellValue(""),
      if (yearling.value?.weight != null) DoubleCellValue(yearling.value!.weight) else TextCellValue(""),
      if (yearling.value?.observation != null) TextCellValue(yearling.value!.observation ?? "")
    ];
  }

  List<CellValue> asFinishRow() {
    finish.loadSync();

    return [
      IntCellValue(earring),
      DateTimeCellValue.fromDateTime(finish.value!.date),
      DoubleCellValue(finish.value!.weight),
      TextCellValue(finishingReason.toString()),
      TextCellValue(finish.value!.observation ?? ""),
    ];
  }

  List<CellValue> asEntryRow() {
    entry.loadSync();

    return [
      IntCellValue(earring),
      if (entry.value?.date != null) DateTimeCellValue.fromDateTime(entry.value!.date) else TextCellValue(""),
      if (entry.value?.weight != null) DoubleCellValue(entry.value!.weight) else TextCellValue(""),
      if (entry.value?.observation != null) TextCellValue(entry.value!.observation ?? "")
    ];
  }

  double? totalWG() {
    if ((birth.value == null || finish.value == null) || (finish.value != null && finishingReason!= FinishingReason.slaughter)) {
      return null;
    }

    return (finish.value!.weight - birth.value!.weight) / (finish.value!.date.difference(birth.value!.date)).inDays;
  }

  double? birthWeaningWG() {
    if (birth.value == null || weaning.value == null) return null;

    return (weaning.value!.weight - birth.value!.weight) / (weaning.value!.date.difference(birth.value!.date)).inDays;
  }
  double? weaningYearlingWG() {
    if (weaning.value == null || yearling.value == null) return null;

    return (yearling.value!.weight - weaning.value!.weight) / (yearling.value!.date.difference(weaning.value!.date)).inDays;
  }

  double? yearlingFinishWG() {
    if ((yearling.value== null || finish.value == null) || (finish.value != null && finishingReason != FinishingReason.slaughter)) {
      return null;
    }

    return (finish.value!.weight - yearling.value!.weight) / (finish.value!.date.difference(yearling.value!.date)).inDays;
  }

  @override
  String toString() {
    return name != null ? "$name #$earring" : "#$earring";
  }

  void ensureLoadedSync() {
    naturalReproductionsMALE.loadSync();
    naturalReproductionsFEMALE.loadSync();
    artificialInseminations.loadSync();

    birth.loadSync();
    weaning.loadSync();
    entry.loadSync();
    yearling.loadSync();
    finish.loadSync();

    treatments.loadSync();
    vaccines.loadSync();
    weighings.loadSync();

    artificialInsemination.loadSync();
    naturalReproduction.loadSync();
  }

  bool isOnTreatment() {
    for (var t in treatments.toList()) {
      if (t.endDate != null && t.endDate!.isAfter(DateTime.now())) {
        return true;
      }
    }
    return false;
  }

  bool isReproducing() {
    if (sex == Sex.male) return false;

    ensureLoadedSync();

    for (final r in naturalReproductionsFEMALE) {
      if (r.diagnostic == ReproductionDiagnostic.waiting) return true;
    }

    for (final r in artificialInseminations) {
      if (r.diagnostic == ReproductionDiagnostic.waiting) return true;
    }

    return false;
  }

  bool isPregnant() {
    if (sex == Sex.male) return false;

    ensureLoadedSync();

    for (final r in naturalReproductionsFEMALE) {
      if (r.diagnostic == ReproductionDiagnostic.positive && r.pregnancy!.ending == null) {
        return true;
      }
    }

    for (final r in artificialInseminations) {
      if (r.diagnostic == ReproductionDiagnostic.positive && r.pregnancy!.ending == null) {
        return true;
      }
    }

    return false;
  }

  Duration? ageFirstBirth() {
    ensureLoadedSync();

    var nreproductions = naturalReproductionsFEMALE.where((rep) {
                                rep.born.loadSync();
                                return rep.born.value != null;
                              })
                              .map((rep) {
                                rep.born.value!.birth.loadSync();
                                return rep.born.value!.birth.value!.date;
                              });

    DateTime? firstFromNaturalBirth;

    if (nreproductions.isNotEmpty) {
      firstFromNaturalBirth = nreproductions.reduce((a, b) => a.isBefore(b) ? a : b);
    }

    var aireproductions = naturalReproductionsFEMALE.where((rep) {
                                rep.born.loadSync();
                                return rep.born.value != null;
                              })
                              .map((rep) {
                                rep.born.value!.birth.loadSync();
                                return rep.born.value!.birth.value!.date;
                              });

    DateTime? firstFromAI;

    if (aireproductions.isNotEmpty) {
      firstFromAI = aireproductions.reduce((a, b) => a.isBefore(b) ? a : b);
    }

    if (firstFromNaturalBirth == null && firstFromAI == null) return null;

    firstFromAI = firstFromAI ?? firstFromNaturalBirth;
    firstFromNaturalBirth = firstFromNaturalBirth ?? firstFromAI;

    DateTime firstBirthDate = firstFromNaturalBirth!.isBefore(firstFromAI!) ? firstFromNaturalBirth : firstFromAI;

    return DateTime.now().difference(firstBirthDate);
  }

  int reproductionPerformance() {
    ensureLoadedSync();

    final allAIs = artificialInseminations.toList();

    allAIs.sort((a, b) => b.date.compareTo(a.date));

    int failedCount = 0;

    for (final ai in allAIs) {
      if (ai.diagnostic == ReproductionDiagnostic.waiting) {
        continue; // skip pending
      }

      if (ai.diagnostic == ReproductionDiagnostic.positive) {
        break; // stop at the last success
      }

      if (ai.diagnostic == ReproductionDiagnostic.negative) {
        failedCount++;
      }
    }

    return failedCount;
  }
}
