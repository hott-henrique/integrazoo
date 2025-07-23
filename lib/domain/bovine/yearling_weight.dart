import 'package:isar/isar.dart';

part 'yearling_weight.g.dart';


@embedded
class YearlingWeight {
  late DateTime date;
  late double weight;

  String? observation;
}
