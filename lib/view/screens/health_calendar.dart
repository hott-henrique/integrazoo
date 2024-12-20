import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/model/health/health_calendar.dart';


extension StringExtension on String {
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class HealthCalendarScreen extends StatelessWidget {
  const HealthCalendarScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.MMMM('pt_BR');
    return IntegrazooBaseApp(
      body: ListView.builder(
        itemCount: HealthCalendar.treatmentsPerMonth.length,
        itemBuilder: (ctx, idx) {
          return ExpansionTile(
            tilePadding: const EdgeInsets.all(8.0),
            collapsedBackgroundColor: (idx + 1) % 2 == 0  ? Colors.white70 : Colors.grey.shade100,
            initiallyExpanded: DateTime.now().month == idx + 1,
            title: Text(format.format(DateTime(1990, idx + 1)).capitalizeFirst()),
            children: HealthCalendar.treatmentsPerMonth[idx].map(
              (e) => ListTile(title: Text(e.vaccineName), subtitle: Text(e.getDescription(idx + 1)))
            ).toList(),
          );
        },
      )
    );
  }
}
