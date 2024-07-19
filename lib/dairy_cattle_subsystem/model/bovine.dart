import 'package:integrazoo/dairy_cattle_subsystem/model/birth.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/newborn_feeding.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/treatment.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/weaning.dart';

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
    List<Treatment>? treatments;

    Bovine(this.id, this.name, this.sex, [ this.birth, this.feeding, this.weaning, this.treatments ]);

    @override
    String toString() {
        return '{ id: $id, name: $name, sex: $sex }';
    }
}
