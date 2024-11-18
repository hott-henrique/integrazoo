import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/database/database.dart';


class TreatmentListTile extends StatelessWidget {
  final Treatment treatment;

  const TreatmentListTile({super.key, required this.treatment});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return ListTile(
      title: Text(treatment.medicine),
      subtitle: Text(treatment.reason),
      trailing: Text('${formatter.format(treatment.startingDate)} - ${formatter.format(treatment.endingDate)}'),
      onTap: () {}
    );
  }
}
