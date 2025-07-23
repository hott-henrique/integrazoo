import 'package:integrazoo/domain/bovine/weighing.dart';
import 'package:isar/isar.dart';

part 'birth.g.dart';


@embedded
class Birth {
  // final data = IsarLink<Weighing>();

  late DateTime date;
  late double weight;

  String? observation;
}
