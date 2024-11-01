import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/model/health/treatment.dart';

class TreatmentListTile extends StatelessWidget {
  final Treatment treatment;

  const TreatmentListTile({super.key, required this.treatment});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return ListTile(
      title: Text(treatment.medicine),
      subtitle: Text(treatment.reason),
      trailing: Text('${formatter.format(treatment.period.start)} - ${formatter.format(treatment.period.end)}'),
      onTap: () {}
    );
  }
}
