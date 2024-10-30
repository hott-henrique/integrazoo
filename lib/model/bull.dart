import 'package:integrazoo/model/birth.dart';
import 'package:integrazoo/model/bovine.dart';
import 'package:integrazoo/model/newborn_feeding.dart';
import 'package:integrazoo/model/weaning.dart';


class Bull extends Bovine {
  Bull._(super.id, super.name, super.sex, [ super.birth, super.feeding, super.weaning ]);

  factory Bull(int id, String name, [ Birth? birth, List<NewbornFeeding>? feeding, Weaning? weaning ]) {
    return Bull._(id, name, Sex.male, birth, feeding, weaning);
  }
}
