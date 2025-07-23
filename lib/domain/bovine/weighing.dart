import 'package:excel/excel.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';


part 'weighing.g.dart';


@collection
class Weighing {
  Id id = Isar.autoIncrement;

  late DateTime date;
  late double weight;
  String? observation;

  final bovine = IsarLink<Bovine>();

  static List<CellValue> asHeader() {
    return [
      TextCellValue("Número"),
      TextCellValue("Animal"),
      TextCellValue("Peso"),
      TextCellValue("Data"),
      TextCellValue("Observação"),
    ];
  }

  List<CellValue> asRow() {
    bovine.loadSync();

    return [
      IntCellValue(id),
      IntCellValue(bovine.value!.earring),
      DoubleCellValue(weight),
      DateCellValue.fromDateTime(date),
      TextCellValue(observation ?? ""),
    ];
  }
}
