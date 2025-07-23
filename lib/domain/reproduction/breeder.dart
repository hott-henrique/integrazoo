import 'package:excel/excel.dart';
import 'package:integrazoo/domain/reproduction/reproduction.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/sex.dart';

part 'breeder.g.dart';


@embedded
class BreederParents {
  late String? mother;
  late String? father;
}

@embedded
class BreederEPD {
  late double? birthWeight;
  late double? weaningWeight;
  late double? yearlingWeight;
}

@collection
class Breeder {
  late Id id = Isar.autoIncrement;

  late String name;
  late String identifier;
  late String breed;


  @Enumerated(EnumType.name)
  late Sex sex;

  BreederParents? parents;
  BreederParents? motherGrandParents;
  BreederParents? fatherGrandParents;

  BreederEPD? epd;

  @Backlink(to: 'cow')
  final artificialInseminations = IsarLinks<ArtificialInseminationReproduction>();

  @override
  String toString() {
    return "$name #$identifier";
  }

  static List<CellValue> asHeader() {
    return [
      TextCellValue("Número"),

      TextCellValue("Nome"),
      TextCellValue("Identificador"),
      TextCellValue("Raça"),
      TextCellValue("Sexo"),

      TextCellValue("Pai"),
      TextCellValue("Mãe"),

      TextCellValue("Avô Paterno"),
      TextCellValue("Avó Paterno"),

      TextCellValue("Avô Materno"),
      TextCellValue("Avó Materno"),

      TextCellValue("DEP Nascimento"),
      TextCellValue("DEP Desmame"),
      TextCellValue("DEP Sobreano"),
    ];
  }

  List<CellValue> asRow() {
    return [
      IntCellValue(id),

      TextCellValue(name),
      TextCellValue(identifier),
      TextCellValue(breed),
      TextCellValue(sex.toString()),

      TextCellValue(parents?.father ?? ""),
      TextCellValue(parents?.mother ?? ""),

      TextCellValue(fatherGrandParents?.father ?? ""),
      TextCellValue(fatherGrandParents?.mother ?? ""),

      TextCellValue(motherGrandParents?.father ?? ""),
      TextCellValue(motherGrandParents?.mother ?? ""),

      TextCellValue(epd?.birthWeight?.toString() ?? ""),
      TextCellValue(epd?.weaningWeight?.toString() ?? ""),
      TextCellValue(epd?.yearlingWeight?.toString() ?? "")
    ];
  }
}
