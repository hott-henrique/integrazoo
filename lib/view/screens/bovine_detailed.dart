import 'dart:math';
import 'dart:developer';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';

// import 'package:integrazoo/control/cow_production_controller.dart';
// import 'package:integrazoo/control/reproduction_controller.dart';
// import 'package:integrazoo/control/treatment_controller.dart';

import 'package:integrazoo/view/components/bovine/treatment_list_tile.dart';
import 'package:integrazoo/view/components/reproduction/artificial_insemination_attempt_list_tile.dart';

import 'package:integrazoo/database/database.dart';


class BovineDetailedScreen extends StatefulWidget {
  final Bovine bovine;

  const BovineDetailedScreen({ super.key, required this.bovine });

  @override
  State<BovineDetailedScreen> createState() => _BovineDetailedScreen();
}

class _BovineDetailedScreen extends State<BovineDetailedScreen> {
  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    return FutureBuilder(
      future: fetchData(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (!snapshot.hasData){
          return const CircularProgressIndicator();
        }

        List<Widget> columnBody = List.empty(growable: true);

        // final treatments = List<Widget>.generate(
        //   min(widget.cattle.treatments.length, 3),
        //   (index) => TreatmentListTile(treatment: widget.cattle.treatments[index])
        // );

        // columnBody = columnBody + treatments;

        // if (snapshot.data!.containsKey("artificialInsemination")) {
        //   final artificialInseminationAttempts = snapshot.data!['artificialInsemination'] as List<ArtificialInseminationAttempt>;

        //   inspect(artificialInseminationAttempts);

        //   final inseminations = List<Widget>.generate(
        //     min(artificialInseminationAttempts.length, 3),
        //     (index) => ArtificialInseminationAttemptListTile(attempt: artificialInseminationAttempts[index])
        //   );

        //   columnBody = columnBody + inseminations;
        // }

        // final milkProduction = (snapshot.data!["milkProduction"] ?? List<CowMilkProduction>.empty()) as List<CowMilkProduction>;

        // if (milkProduction.isNotEmpty) {
        //   milkProduction.sort((x1, x2) => x1.date.millisecondsSinceEpoch.compareTo(x2.date.millisecondsSinceEpoch));

        //   final maxProduction = milkProduction.reduce((x1, x2) => x1.volume >= x2.volume ? x1 : x2).volume;

        //   final DateFormat formatter = DateFormat('dd/MM');

        //   final productionChart = BarChart(BarChartData(
        //     barGroups: milkProduction.asMap().entries.map(
        //       (entry) => BarChartGroupData(
        //         x: entry.key,
        //         barRods: [ BarChartRodData(
        //           toY: entry.value.volume,
        //           color: entry.value.discard ? Colors.red : Colors.green,
        //           borderRadius: const BorderRadius.only(topLeft: Radius.circular(2), topRight: Radius.circular(2))
        //         ) ]
        //       )
        //     ).toList(),
        //     titlesData: FlTitlesData(
        //       topTitles: const AxisTitles(axisNameWidget: Text("Produção"), axisNameSize: 32),
        //       bottomTitles: AxisTitles(sideTitles: SideTitles(
        //         showTitles: true,
        //         getTitlesWidget: (value, meta) => Text(formatter.format(milkProduction[value.toInt()].date))
        //       )),
        //       rightTitles: AxisTitles(sideTitles: SideTitles(
        //         reservedSize: 44,
        //         showTitles: true,
        //         getTitlesWidget: (value, meta) => const Text("")
        //       ))
        //     ),
        //     maxY: (maxProduction / 10.0).ceil() * 10.0
        //   ));

        //   columnBody.add(Container(
        //     padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
        //     child: Card(child: AspectRatio(aspectRatio: 1.3,
        //       child: Column(children: [
        //         Expanded(flex: 12, child: Padding(padding: const EdgeInsets.all(8), child: productionChart))
        //       ])
        //     ))
        //   ));
        // }

        return IntegrazooBaseApp(body:Column(children: columnBody));
      }
    );
  }

  Future<Map<String, dynamic>> fetchData() async {
    Map<String, dynamic> mappedData = {};

    // if (widget.cattle.treatments.isEmpty) {
    //   widget.cattle.treatments.addAll(await TreatmentController.getTreatments(widget.cattle));
    // }

    // if (widget.cattle.sex == Sex.female) {
    //   Cow c = Cow(widget.cattle.id, widget.cattle.name);
    //   mappedData["milkProduction"] = await CowProductionController.getMilkProduction(c);
    //   mappedData["artificialInsemination"] = await ReproductionController.getAllArtificialInseminationAttemptFromCow(c);
    // }

    return Future.value(mappedData);
  }
}
