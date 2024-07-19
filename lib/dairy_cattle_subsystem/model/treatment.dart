import 'package:flutter/material.dart';


class Treatment {
    int id;
    String reason;
    String medicine;
    DateTimeRange period;
    Duration waitTime;

    Treatment(this.id, this.reason, this.medicine, this.period, this.waitTime);

    DateTime waitTimeOverDate() {
        // TODO: Implement this function = period.end + waitTime;
        return DateTime.now();
    }

    DateTime tankReleaseDate() {
        return waitTimeOverDate(); // TODO: Add one day to this date;
    }
}
