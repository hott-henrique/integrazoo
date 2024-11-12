import 'package:integrazoo/model/bovine/bovine.dart';
import 'package:integrazoo/model/bovine/milk_production.dart';
import 'package:integrazoo/model/bovine/newborn_feeding.dart';
import 'package:integrazoo/model/bovine/weaning.dart';

import 'package:integrazoo/model/reproduction/birth.dart';

import 'package:integrazoo/model/health/dry_treatment.dart';


class Cow extends Bovine {
  List<CowMilkProduction>? production;
  List<DryTreatment>? dryTreatments;

  Cow._(super.id, super.name, super.sex, [ super.birth, super.feeding, super.weaning, this.production, this.dryTreatments ]);

  factory Cow.empty() {
    return Cow(0, "");
  }

  factory Cow(int id,
              String name,
              [ Birth? birth,
                List<NewbornFeeding>? feeding,
                Weaning? weaning,
                List<CowMilkProduction>? production,
                List<DryTreatment>? dryTreatments ]) {
      return Cow._(id, name, Sex.female, birth, feeding, weaning, production, dryTreatments);
  }
}
