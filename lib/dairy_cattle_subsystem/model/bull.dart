import 'package:integrazoo/dairy_cattle_subsystem/model/birth.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/bovine.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/newborn_feeding.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/weaning.dart';


class Bull extends Bovine {
  Bull._(super.id, super.name, super.sex, [ super.birth, super.feeding, super.weaning ]);

  factory Bull(int id, String name, [ Birth? birth, List<NewbornFeeding>? feeding, Weaning? weaning ]) {
    return Bull._(id, name, Sex.male, birth, feeding, weaning);
  }
}

