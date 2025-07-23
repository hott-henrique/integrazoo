import 'package:excel/excel.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';

part 'treatment.g.dart';


@collection
class Treatment {
  Id id = Isar.autoIncrement;

  late String medicine;
  late String reason;

  late DateTime date;
  DateTime? endDate;

  final bovine = IsarLink<Bovine>();

  @override
  String toString() {
    return medicine;
  }

  static List<CellValue> asHeader() {
    return [
      TextCellValue("Número"),
      TextCellValue("Animal"),
      TextCellValue("Medicamento"),
      TextCellValue("Razão"),
      TextCellValue("Data do Tratamento"),
      TextCellValue("Data Termino do Tratamento"),
    ];
  }

  List<CellValue> asRow() {
    bovine.loadSync();

    return [
      IntCellValue(id),
      IntCellValue(bovine.value!.earring),
      TextCellValue(medicine),
      TextCellValue(reason),
      DateCellValue.fromDateTime(date),
      if (endDate != null) DateCellValue.fromDateTime(endDate!) else TextCellValue(""),
    ];
  }
}
