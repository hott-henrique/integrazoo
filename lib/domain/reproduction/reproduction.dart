import 'package:excel/excel.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';

import 'package:integrazoo/domain/reproduction/reproduction_diagnostic.dart';
import 'package:integrazoo/domain/reproduction/breeder.dart';
import 'package:integrazoo/domain/reproduction/pregnancy.dart';

part 'reproduction.g.dart';


@collection
class NaturalReproduction {
  Id id = Isar.autoIncrement;

  late DateTime date;

  final cow = IsarLink<Bovine>();
  final bull = IsarLink<Bovine>();

  @Enumerated(EnumType.name)
  late ReproductionDiagnostic diagnostic;
  DateTime? diagnosticDate;

  Pregnancy? pregnancy;

  final born = IsarLink<Bovine>();

  static List<CellValue> asHeader() {
    return [
      TextCellValue("Número"),
      TextCellValue("Vaca"),
      TextCellValue("Reprodutor"),
      TextCellValue("Diagnóstico"),
      TextCellValue("Data do Diagnóstico"),
      TextCellValue("Gravidez.Finalização"),
      TextCellValue("Gravidez.Previsão do Parto"),
      TextCellValue("Gravidez.Observação"),
      TextCellValue("Gravidez.Animal Parido"),
      TextCellValue("Gravidez.Observação Falha"),
      TextCellValue("Gravidez.Data Finalização"),
    ];
  }

  List<CellValue> asRow() {
    cow.loadSync();
    bull.loadSync();
    born.loadSync();

    return [
      IntCellValue(id),
      TextCellValue(cow.value!.toString()),
      TextCellValue(bull.value!.toString()),
      TextCellValue(diagnostic.toString()),
      if (diagnosticDate != null) DateCellValue.fromDateTime(diagnosticDate!) else TextCellValue(""),
      if (pregnancy?.ending != null) TextCellValue(pregnancy!.ending?.toString() ?? "") else TextCellValue(""),
      if (pregnancy?.birthForecast != null) DateCellValue.fromDateTime(pregnancy!.birthForecast) else TextCellValue(""),
      if (pregnancy?.observation != null) TextCellValue(pregnancy?.observation ?? "") else TextCellValue(""),
      if (born.value != null) TextCellValue(born.value!.toString()) else TextCellValue(""),
      if (pregnancy?.failureObservation != null) TextCellValue(pregnancy?.failureObservation ?? "") else TextCellValue(""),
      if (pregnancy?.endingDate != null) DateCellValue.fromDateTime(pregnancy!.endingDate!) else TextCellValue(""),
    ];
  }
}

@collection
class ArtificialInseminationReproduction {
  Id id = Isar.autoIncrement;

  late DateTime date;

  final cow = IsarLink<Bovine>();
  final breeder = IsarLink<Breeder>();

  late String straw;

  @Enumerated(EnumType.name)
  late ReproductionDiagnostic diagnostic;
  DateTime? diagnosticDate;

  Pregnancy? pregnancy;

  final born = IsarLink<Bovine>();

  static List<CellValue> asHeader() {
    return [
      TextCellValue("Número"),
      TextCellValue("Vaca"),
      TextCellValue("Reprodutor"),
      TextCellValue("Pipeta"),
      TextCellValue("Diagnóstico"),
      TextCellValue("Data do Diagnóstico"),
      TextCellValue("Gravidez.Finalização"),
      TextCellValue("Gravidez.Previsão do Parto"),
      TextCellValue("Gravidez.Observação"),
      TextCellValue("Gravidez.Animal Parido"),
    ];
  }

  List<CellValue> asRow() {
    cow.loadSync();
    breeder.loadSync();
    born.loadSync();

    return [
      IntCellValue(id),
      TextCellValue(cow.value!.toString()),
      TextCellValue(breeder.value!.toString()),
      TextCellValue(straw),
      TextCellValue(diagnostic.toString()),
      if (diagnosticDate != null) DateCellValue.fromDateTime(diagnosticDate!) else TextCellValue(""),
      if (pregnancy?.ending != null) TextCellValue(pregnancy!.ending?.toString() ?? "") else TextCellValue(""),
      if (pregnancy?.birthForecast != null) DateCellValue.fromDateTime(pregnancy!.birthForecast) else TextCellValue(""),
      if (pregnancy?.observation != null) TextCellValue(pregnancy?.observation ?? "") else TextCellValue(""),
      if (born.value != null) TextCellValue(born.value!.toString()) else TextCellValue(""),
    ];
  }
}
