import 'package:integrazoo/model/reproduction/birth.dart';
import 'package:integrazoo/model/bovine/newborn_feeding.dart';
import 'package:integrazoo/model/health/treatment.dart';
import 'package:integrazoo/model/bovine/weaning.dart';

enum Sex {
  male, female;

  @override
  String toString() {
    switch (this) {
      case Sex.male:
        return "Macho";

      case Sex.female:
        return "Fêmea";
    }
  }
}

class Bovine {
  int id;
  String name;
  Sex sex;

  Birth? birth;
  List<NewbornFeeding>? feeding;
  Weaning? weaning;
  List<Treatment> treatments;

  Bovine(this.id, this.name, this.sex, [ this.birth, this.feeding, this.weaning ]) : treatments = List.empty(growable: true);

  @override
  String toString() {
      return '{ id: $id, name: $name, sex: $sex }';
  }
}
