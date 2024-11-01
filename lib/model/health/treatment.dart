import 'package:flutter/material.dart';


class Treatment {
  int id;
  String reason;
  String medicine;
  DateTimeRange period;
  Duration restingTime;

  Treatment(this.id, this.reason, this.medicine, this.period, this.restingTime);

  DateTime waitTimeOverDate() {
    return period.end.add(restingTime);
  }

  DateTime tankReleaseDate() {
    return waitTimeOverDate().add(const Duration(days: 1));
  }
}
