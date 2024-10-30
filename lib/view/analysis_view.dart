import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:integrazoo/base.dart';


class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color
          )
        ),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor))
      ],
    );
  }
}

class AnalysisView extends StatelessWidget {
  const AnalysisView({ super.key });

  @override
  Widget build(BuildContext context) {
    final herdChart = Container(
      padding: const EdgeInsets.all(8.0),
      child: PieChart(
      PieChartData(sections: [ PieChartSectionData(value: 10, color: Colors.red,  title:  '10'),
                               PieChartSectionData(value: 5,  color: Colors.blue, title:  '5'),
                               PieChartSectionData(value: 15, color: Colors.green, title: '15') ])
      )
    );

    final productionChart = BarChart(BarChartData(
      barGroups: [
        BarChartGroupData(x: 1, barRods: [ BarChartRodData(toY: 10) ]),
        BarChartGroupData(x: 2, barRods: [ BarChartRodData(toY: 20) ]),
        BarChartGroupData(x: 3, barRods: [ BarChartRodData(toY: 30) ]),
        BarChartGroupData(x: 4, barRods: [ BarChartRodData(toY: 25) ]),
        BarChartGroupData(x: 5, barRods: [ BarChartRodData(toY: 60) ]),
        BarChartGroupData(x: 6, barRods: [ BarChartRodData(toY: 45) ]),
        BarChartGroupData(x: 7, barRods: [ BarChartRodData(toY: 30) ]),
      ],
      titlesData: FlTitlesData(
        rightTitles:  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles:  const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
        topTitles:  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
            String text;
            switch (value.toInt()) {
              case 1:
                text = 'S';
              break;
              case 2:
                text = 'T';
              break;
              case 3:
                text = 'Q';
              break;
              case 4:
                text = 'Q';
              break;
              case 5:
                text = 'S';
              break;
              case 6:
                text = 'S';
              break;
              case 7:
                text = 'D';
              break;
              default:
                text = '';
              break;
            }
            return SideTitleWidget(
              axisSide: meta.axisSide,
              space: 4,
              child: Text(text),
            );
          })
        )
      )
    ));

    return IntegrazooBaseApp(
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: Card(child: AspectRatio(
            aspectRatio: 1.3,
            child: Column(children: [
              const Spacer(flex: 1),
              const Expanded(flex: 2, child: Text("Rebanho", style: TextStyle(fontSize: 20))),
              Expanded(flex: 12, child: Row(
                children:[
                  Expanded(flex: 1, child: AspectRatio(aspectRatio: 1, child: herdChart)),
                  const Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Indicator(text: 'Secas', color: Colors.red, isSquare: false),
                      Indicator(text: 'Reproduzindo', color: Colors.blue, isSquare: false),
                      Indicator(text: 'Em Lactação', color: Colors.green, isSquare: false),
                    ]
                  ))
                ]
              )),
            ])
          ))
        ),
        Container(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: Card(child: AspectRatio(
            aspectRatio: 1.3,
            child: Column(children: [
              const Spacer(flex: 1),
              const Expanded(flex: 2, child: Text("Produção", style: TextStyle(fontSize: 20))),
              Expanded(flex: 12, child: Padding(padding: const EdgeInsets.all(8), child: productionChart))
            ])
          ))
        ),
        Container(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0, bottom: 8.0),
          child: Card(child: AspectRatio(aspectRatio: 1.3,
            child: Column(children: [
              const Spacer(flex: 1),
              const Expanded(flex: 2, child: Text("Rebanho", style: TextStyle(fontSize: 20))),
              Expanded(flex: 12, child: Row(
                children:[
                  Expanded(flex: 1, child: AspectRatio(aspectRatio: 1, child: herdChart)),
                  const Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Indicator(text: 'Secas', color: Colors.red, isSquare: false),
                      Indicator(text: 'Reproduzindo', color: Colors.blue, isSquare: false),
                      Indicator(text: 'Produzindo', color: Colors.green, isSquare: false),
                    ]
                  ))
                ]
              ))
            ])
          ))
        )
      ])
    );
  }
}
