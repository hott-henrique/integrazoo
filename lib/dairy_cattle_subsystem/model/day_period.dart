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