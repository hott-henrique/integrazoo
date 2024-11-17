import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/treatment/treatment_list_tile.dart';
import 'package:integrazoo/view/components/reproduction/artificial_insemination_attempt_list_tile.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/production_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';
import 'package:integrazoo/control/treatment_controller.dart';

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

    List<Widget> columnBody = List.empty(growable: true);

    columnBody.add(renderTreatments());
    columnBody.add(renderArtificialInseminations());
    columnBody.add(renderProduction());

    return IntegrazooBaseApp(body: ListView(children: columnBody));
  }

  Widget renderProduction() {
    return FutureBuilder(
      future: ProductionController.getMilkProduction(widget.bovine.id, 31, 0),
      builder: (context, AsyncSnapshot<List<Production>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final productions = snapshot.data!;

        productions.sort((x1, x2) => x1.date.millisecondsSinceEpoch.compareTo(x2.date.millisecondsSinceEpoch));

        final maxProduction = productions.reduce((x1, x2) => x1.volume >= x2.volume ? x1 : x2).volume;

        final DateFormat formatter = DateFormat('dd/MM');

        final productionChart = BarChart(BarChartData(
          barGroups: productions.asMap().entries.map(
            (entry) => BarChartGroupData(
              x: entry.key,
              barRods: [ BarChartRodData(
                toY: entry.value.volume,
                color: entry.value.discard ? Colors.red : Colors.green,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(2), topRight: Radius.circular(2))
              ) ]
            )
          ).toList(),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(axisNameWidget: Text("Produção dos Últimos 31 Dias"), axisNameSize: 32),
            bottomTitles: AxisTitles(sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Text(formatter.format(productions[value.toInt()].date))
            )),
            rightTitles: AxisTitles(sideTitles: SideTitles(
              reservedSize: 44,
              showTitles: true,
              getTitlesWidget: (value, meta) => const Text("")
            ))
          ),
          maxY: (maxProduction / 10.0).ceil() * 10.0
        ));

        return Container(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: Card(child: AspectRatio(aspectRatio: 1.3,
            child: Column(children: [
              Expanded(flex: 12, child: Padding(padding: const EdgeInsets.all(8), child: productionChart))
            ])
          ))
        );
      }
    );
  }

  Widget renderTreatments() {
    return FutureBuilder(
      future: TreatmentController.getTreatments(widget.bovine.id, 3, 0),
      builder: (context, AsyncSnapshot<List<Treatment>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final treatments = snapshot.data!;

        final treatmentsTiles = List<Widget>.generate(
          treatments.length,
          (index) => TreatmentListTile(treatment: treatments[index])
        );

        treatmentsTiles.insert(0, const Text("Tratamentos"));

        return Container(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: Card(child: Column(children: treatmentsTiles))
        );
      }
    );
  }

  Widget renderArtificialInseminations() {
    return FutureBuilder(
      future: ReproductionController.getArtificialInseminationAttemptsFromCow(widget.bovine.id, 3, 0),
      builder: (context, AsyncSnapshot<List<Reproduction>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final reproductions = snapshot.data!;

        final reproductionsTiles = List<Widget>.generate(
          reproductions.length,
          (index) => ArtificialInseminationAttemptListTile(attempt: reproductions[index])
        );

        reproductionsTiles.insert(0, const Text("Inseminações Artificiais"));

        return Container(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: Card(child: Column(children: reproductionsTiles))
        );
      }
    );
  }
}
