import 'package:integrazoo/model/reproduction/birth.dart';
import 'package:integrazoo/model/bovine/bovine.dart';
import 'package:integrazoo/model/bovine/newborn_feeding.dart';
import 'package:integrazoo/model/bovine/weaning.dart';


class Bull extends Bovine {
  Bull._(super.id, super.name, super.sex, [ super.birth, super.feeding, super.weaning ]);


  factory Bull.empty() {
    return Bull(0, "");
  }

  factory Bull(int id, String name, [ Birth? birth, List<NewbornFeeding>? feeding, Weaning? weaning ]) {
    return Bull._(id, name, Sex.male, birth, feeding, weaning);
  }
}
