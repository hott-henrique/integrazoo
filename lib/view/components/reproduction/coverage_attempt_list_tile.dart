import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

// import 'package:integrazoo/view/screens/artificial_insemination.dart';

import 'package:integrazoo/control/bovine_controller.dart';

import 'package:integrazoo/database/database.dart';

class CoverageAttemptListTile extends StatelessWidget {
  final Reproduction attempt;

  const CoverageAttemptListTile({ super.key, required this.attempt });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return ListTile(
      title: const Text("Monta"),
      subtitle: renderBull(),
      trailing: Text(formatter.format(attempt.date)),
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ArtificialInseminationDetailedScreen(attempt: attempt)));
      }
    );
  }

  Widget renderBull() {
    return FutureBuilder(
      future: BovineController.getBovine(attempt.bull!),
      builder: (context, AsyncSnapshot<Bovine> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final bull = snapshot.data!;

        return Text('Reprodutor: ${bull.name} - ${bull.id}');
      }
    );
  }
}
