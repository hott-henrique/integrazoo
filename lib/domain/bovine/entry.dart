import 'package:isar/isar.dart';

part 'entry.g.dart';


@embedded
class Entry {
  late DateTime date;
  late float weight;

  String? observation;
}
