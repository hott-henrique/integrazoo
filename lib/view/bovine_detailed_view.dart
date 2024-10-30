import 'dart:developer';

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/common/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/cow_production_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';
import 'package:integrazoo/control/treatment_controller.dart';

import 'package:integrazoo/view/treatment_list_tile.dart';
import 'package:integrazoo/view/artificial_insemination_attempt_list_tile.dart';

import 'package:integrazoo/model/artificial_insemination_attempt.dart';
import 'package:integrazoo/model/bovine.dart';
import 'package:integrazoo/model/cow.dart';
import 'package:integrazoo/model/cow_milk_production.dart';


class BovineDetailedView extends StatefulWidget {
  final Bovine cattle;

  const BovineDetailedView({ super.key, required this.cattle });

  @override
  State<BovineDetailedView> createState() => _BovineDetailedView();
}

class _BovineDetailedView extends State<BovineDetailedView> {
  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    const textStyle = TextStyle(fontSize: 30, color: Colors.white);

    return FutureBuilder(
      future: fetchData(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (!snapshot.hasData){
          return const CircularProgressIndicator();
        }

        List<Widget> columnBody = List.empty(growable: true);

        // columnBody.add(Row(children: [ Expanded(child: Container(color: const Color.fromARGB(255, 114, 180, 117), child: Center(child: Text(widget.cattle.name, style: textStyle)))) ]));

        // final treatments = ListView.builder(
        //   itemCount: min(widget.cattle.treatments.length, 3),
        //   itemBuilder: (BuildContext context, int index) {
        //     return TreatmentListTile(treatment: widget.cattle.treatments[index]);
        //   }
        // );

        final treatments = List<Widget>.generate(
          min(widget.cattle.treatments.length, 3),
          (index) => TreatmentListTile(treatment: widget.cattle.treatments[index])
        );

        columnBody = columnBody + treatments;

        if (snapshot.data!.containsKey("artificialInsemination")) {
          final artificialInseminationAttempts = snapshot.data!['artificialInsemination'] as List<ArtificialInseminationAttempt>;

          inspect(artificialInseminationAttempts);

          final inseminations = List<Widget>.generate(
            min(widget.cattle.treatments.length, 3),
            (index) => ArtificialInseminationAttemptListTile(attempt: artificialInseminationAttempts[index])
          );

          columnBody = columnBody + inseminations;
        }

        // if (snapshot.data!.containsKey("milkProduction")) {
        //   final milkProduction = snapshot.data!['milkProduction'] as List<CowMilkProduction>;

        //   inspect(milkProduction);

        //   final productionChart = BarChart(BarChartData(
        //     barGroups: milkProduction.asMap().entries.map(
        //       (entry) => BarChartGroupData(x: entry.key, barRods: [ BarChartRodData(toY: entry.value.volume) ])
        //     ).toList(),
        //   ));

        //   columnBody.add(Container(
        //     padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
        //     child: Card(child: AspectRatio(aspectRatio: 1.3,
        //       child: Column(children: [
        //         const Spacer(flex: 1),
        //         const Expanded(flex: 2, child: Text("Produção", style: TextStyle(fontSize: 20))),
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

    if (widget.cattle.treatments.isEmpty) {
      widget.cattle.treatments.addAll(await TreatmentController.getTreatments(widget.cattle));
    }

    if (widget.cattle.sex == Sex.female) {
      Cow c = Cow(widget.cattle.id, widget.cattle.name);
      mappedData["milkProduction"] = await CowProductionController.getMilkProduction(c);
      mappedData["artificialInsemination"] = await ReproductionController.getAllArtificialInseminationAttemptFromCow(c);
    }

    return Future.value(mappedData);
  }
}
