import 'package:integrazoo/model/day_period.dart';


class CowMilkProduction {
  int id;
  double volume;
  DateTime date;
  DayPeriodIZ period;
  bool discard;
  String? observation;

  CowMilkProduction(this.id, this.volume, this.date, this.period, this.discard, this.observation);
}
