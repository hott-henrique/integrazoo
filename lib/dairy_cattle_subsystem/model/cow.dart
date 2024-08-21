import 'package:integrazoo/dairy_cattle_subsystem/model/bovine.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow_milk_production.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/dry_treatment.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/weaning.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/birth.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/newborn_feeding.dart';


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

