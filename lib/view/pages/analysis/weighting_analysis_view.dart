import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:integrazoo/domain/bovine/bovine.dart';
import 'package:integrazoo/domain/bovine/finish.dart';
import 'package:integrazoo/domain/bovine/finishing_reason.dart';
import 'package:integrazoo/domain/bovine/weighing.dart';
import 'package:isar/isar.dart';


class YearWeightStat {
  int year;
  double weight;

  YearWeightStat({ required this.year, required this.weight });
}

class WeightingAnalysisViewPlot extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  const WeightingAnalysisViewPlot({ super.key, required this.startDate, required this.endDate });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<YearWeightStat>>(
      future: queryData(startDate, endDate), // Call your async function here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data: ${snapshot.error}')); // Show error message
        } else if (snapshot.hasData) {
          final weights = snapshot.data!;

          final chart = buildChart(weights);

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Center(child: Column(spacing: 4.0, children: [
            Expanded(child: chart),
          ])));
        } else {
          return Center(child: Text('Nada para ver aqui.')); // No data yet
        }
      },
    );
  }

  Widget buildChart(List<YearWeightStat> data) {
    inspect(data);

    if (data.isEmpty) {
      return const Center(child: Text("Nada para ver aqui."));
    }

    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: data.map((e) {
            return BarChartGroupData(
              x: e.year,
              barRods: [
                BarChartRodData(
                  toY: e.weight,
                  color: Colors.blue,
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                )
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 60,
                getTitlesWidget: (value, _) => Text('${value.toInt()}'),
              ),
            ),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Future<List<YearWeightStat>> queryData(DateTime startDate, DateTime endDate) async {
    final isar = GetIt.I<Isar>();
    List<YearWeightStat> weighings = [];

    DateTime currentStart = startDate;
    DateTime endOfYear = DateTime(currentStart.year, 12, 31);
    DateTime currentEnd = endOfYear.isBefore(endDate) ? endOfYear : endDate;

    do {
      // Step 1: Get all weighings within current year
      final yearWeighings = await isar.weighings
          .filter()
          .dateBetween(currentStart, currentEnd)
          .bovine(
            (bov) => bov.finishingReasonEqualTo(FinishingReason.death)
                        .or()
                        .finishingReasonEqualTo(FinishingReason.slaughter)
                        .or()
                        .finishingReasonEqualTo(FinishingReason.sell)
                        .or()
                        .finishingReasonEqualTo(FinishingReason.notYet)
          )
          .sortByDateDesc()
          .findAll();

      // Step 2: Group by bovine.id and pick the most recent weighing
      final Map<Id, Weighing> latestPerBovine = {};

      for (final weighing in yearWeighings) {
        final bovineId = weighing.bovine.value?.earring;
        if (bovineId != null && !latestPerBovine.containsKey(bovineId)) {
          latestPerBovine[bovineId] = weighing;
        }
      }

      // Step 3: Compute average of latest weights
      final weights = latestPerBovine.values.map((w) => w.weight).toList();
      if (weights.isNotEmpty) {
        final average = weights.reduce((a, b) => a + b) / weights.length;
        weighings.add(YearWeightStat(weight: average, year: currentStart.year));
      }

      // Step 4: Move to next year
      currentStart = DateTime(currentStart.year + 1, 1, 1);
      endOfYear = DateTime(currentStart.year, 12, 31);
      currentEnd = endOfYear.isBefore(endDate) ? endOfYear : endDate;

    } while (!currentStart.isAfter(endDate));

    return weighings;
  }
}
