import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:integrazoo/app_styles.dart';

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
      contentPadding: const EdgeInsets.symmetric(horizontal: 2),
      shape: const Border(bottom: BorderSide(width: 2, color: AppStyles.secondaryBlueColor)),
      leading: SvgPicture.asset("assets/icons/sperm.svg", width: 30, colorFilter: const ColorFilter.mode( AppStyles.secondaryBlueColor, BlendMode.srcIn)),
      title: const Text("Monta"),
      subtitle: renderBull(),
      titleTextStyle: AppStyles.tileTitleTextStyle,
      subtitleTextStyle: AppStyles.tileSubtitleTextStyle,
      trailing: Text(formatter.format(attempt.date), style: AppStyles.tileTrailingTextStyle,),
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

        return Text('Reprodutor: ${bull.name} #${bull.id}');
      }
    );
  }
}
