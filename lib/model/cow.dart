import 'package:integrazoo/model/birth.dart';
import 'package:integrazoo/model/bovine.dart';
import 'package:integrazoo/model/cow_milk_production.dart';
import 'package:integrazoo/model/dry_treatment.dart';
import 'package:integrazoo/model/newborn_feeding.dart';
import 'package:integrazoo/model/weaning.dart';


class Cow extends Bovine {
  List<CowMilkProduction>? production;
  List<DryTreatment>? dryTreatments;

  Cow._(super.id, super.name, super.sex, [ super.birth, super.feeding, super.weaning, this.production, this.dryTreatments ]);

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
