enum DayPeriodIZ {
  morning,
  afternon,
  night;

  @override
  toString() {
    switch (this) {
      case morning:
        return 'Manhã';

      case afternon:
        return 'Tarde';

      case night:
        return 'Noite';
    }
  }
}

class CowMilkProduction {
  int id;
  double volume;
  DateTime date;
  DayPeriodIZ period;
  bool discard;
  String? observation;

  CowMilkProduction(this.id, this.volume, this.date, this.period, this.discard, this.observation);
}
