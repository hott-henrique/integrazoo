import 'package:isar/isar.dart';

part 'pregnancy.g.dart';


enum PregnancyEndingReason {
  birth("birth", "Parto"),
  fail("fail", "Natimorto / Reabsorção");

  const PregnancyEndingReason(this.code, this.label);

  final String code;
  final String label;

  @override
  String toString() => label;
}

@embedded
class Pregnancy {
  @Enumerated(EnumType.name)
  PregnancyEndingReason? ending;

  String? failureObservation;

  String? observation;

  late DateTime birthForecast;
  DateTime? endingDate;
}
