import 'package:flutter/material.dart';

import 'package:integrazoo/model/successful_reproduction.dart';


class Pregnancy {
  int id;
  DateTime date;
  DateTimeRange dryingForecast;
  String? observation;

  SuccessfulReproduction reproduction;

  Pregnancy(this.id, this.date, this.dryingForecast, this.observation, this.reproduction);
}
