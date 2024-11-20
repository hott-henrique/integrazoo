import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/screens/artificial_insemination.dart';

import 'package:integrazoo/control/semen_controller.dart';

import 'package:integrazoo/database/database.dart';

class ArtificialInseminationAttemptListTile extends StatelessWidget {
  final Reproduction attempt;

  const ArtificialInseminationAttemptListTile({ super.key, required this.attempt });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return ListTile(
      title: const Text("Inseminação Artificial"),
      subtitle: renderSemen(),
      trailing: Text(formatter.format(attempt.date)),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ArtificialInseminationDetailedScreen(reproductionId: attempt.id)));
      }
    );
  }

  Widget renderSemen() {
    return FutureBuilder(
      future: SemenController.getSemen(attempt.semen!),
      builder: (context, AsyncSnapshot<Semen> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final semen = snapshot.data!;

        return Text('Semen: ${semen.bullName} #${semen.semenNumber}');
      }
    );
  }
}
