import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:integrazoo/app_styles.dart';

import 'package:intl/intl.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/treatment/treatment_list_tile.dart';
import 'package:integrazoo/view/components/reproduction/artificial_insemination_attempt_list_tile.dart';
import 'package:integrazoo/view/components/reproduction/coverage_attempt_list_tile.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';
import 'package:integrazoo/view/components/general/section_card.dart';

import 'package:integrazoo/control/production_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';
import 'package:integrazoo/control/treatment_controller.dart';

import 'package:integrazoo/view/components/button.dart';

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
    columnBody.add(renderReproductions());
    columnBody.add(renderProduction());
    columnBody.add(Container(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
      child: Button(
        color: Colors.red,
        text: "Descartar",
        onPressed: () {}
      )
    ));

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

        if (productions.isEmpty) {
          return Container(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: const Card(child: AspectRatio(aspectRatio: 1.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [  Text("Nenhuma produção registrada.", textAlign: TextAlign.center) ]
              )
            ))
          );
        }

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
            child: SectionCard(sectionTitle: "Produções",children: [
              AspectRatio(
                  aspectRatio: 1.3,
                  child: Column(children: [
                    Expanded(
                        flex: 12,
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: productionChart))
                  ]))
            ]));
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

        if (treatments.isEmpty) {
          treatmentsTiles.add(const ListTile(title: Text("Nenhum tratamento registrado.", textAlign: TextAlign.center), dense: true));
        }

        return Container(
          padding: const EdgeInsets.all(10),
          child: SectionCard(
                sectionTitle: "Tratamentos",
                children: treatmentsTiles
              )
        );
      }
    );
  }

  Widget renderReproductions() {
    return FutureBuilder(
      future: ReproductionController.getReproductionsFromCow(widget.bovine.id, 3, 0),
      builder: (context, AsyncSnapshot<List<Reproduction>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final reproductions = snapshot.data!;

        final reproductionsTiles = List<Widget>.generate(
          reproductions.length,
          (index) {
            if (reproductions[index].kind == ReproductionKind.artificialInsemination) {
              return ArtificialInseminationAttemptListTile(attempt: reproductions[index]);
            } else {
              return CoverageAttemptListTile(attempt: reproductions[index]);
            }
          }
        );

        if (reproductions.isEmpty) {
          reproductionsTiles.add(const ListTile(title: Text("Nenhuma reprodução registrada.", textAlign: TextAlign.center), dense: true));
        }


        return Container(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: SectionCard( sectionTitle:"Reproduções" ,children: reproductionsTiles)
        );
      }
    );
  }
}
