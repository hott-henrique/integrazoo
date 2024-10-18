import 'package:flutter/material.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/reproduction_attempt.dart';


class SuccessfulReproduction {
  int id;
  DateTimeRange birthForecast;
  Duration milkWaitTime;
  String? observation;

  ReproductionAttempt attempt;

  SuccessfulReproduction(this.id, this.birthForecast, this.milkWaitTime, this.observation, this.attempt);
}
