import 'package:integrazoo/dairy_cattle_subsystem/model/day_period.dart';


class HerdMilkProduction {
    int id;
    double volume;
    DateTime date;
    DayPeriodIZ period;
    double discarded;
    String? observation;

    HerdMilkProduction(this.id, this.volume, this.date, this.period, this.discarded, this.observation);
}
