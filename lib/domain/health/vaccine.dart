import 'package:excel/excel.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';

part 'vaccine.g.dart';


@collection
class Vaccine {
  Id id = Isar.autoIncrement;

  late String name;
  late DateTime date;

  final bovine = IsarLink<Bovine>();

  @override
  String toString() {
    return name;
  }

  static List<CellValue> asHeader() {
    return [
      TextCellValue("Número"),
      TextCellValue("Animal"),
      TextCellValue("Vacina"),
      TextCellValue("Data"),
    ];
  }

  List<CellValue> asRow() {
    bovine.loadSync();

    return [
      IntCellValue(id),
      IntCellValue(bovine.value!.earring),
      TextCellValue(name),
      DateCellValue.fromDateTime(date),
    ];
  }
}
