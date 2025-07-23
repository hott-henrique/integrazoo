import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/finishing_reason.dart';

part 'finish.g.dart';


@embedded
class Finish {

  late DateTime date;
  float? weight;

  @Enumerated(EnumType.name)
  late FinishingReason reason;

  String? observation;
}
