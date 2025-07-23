import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:integrazoo/domain/reproduction/reproduction.dart';
import 'package:integrazoo/domain/reproduction/reproduction_diagnostic.dart';
import 'package:integrazoo/view/pages/analysis/weighting_analysis_view.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';


class ReproductionAnalysisView extends StatefulWidget {
  const ReproductionAnalysisView({ super.key });

  @override
  State<ReproductionAnalysisView> createState() => _ReproductionAnalysisViewState();
}

class WeightAnalysisView extends StatefulWidget {
  const WeightAnalysisView({ super.key });

  @override
  State<WeightAnalysisView> createState() => _WeightAnalysisViewState();
}

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [
      WeightAnalysisView(),
      ReproductionAnalysisView(),
    ]));
  }
}
class _WeightAnalysisViewState extends State<WeightAnalysisView> {
  final startDateController = TextEditingController();
  late DateTime startDate;

  final endDateController = TextEditingController();
  late DateTime endDate;

  @override
  void initState() {
    super.initState();

    endDate = DateTime.now();
    startDate = endDate.subtract(Duration(days:30));

    startDateController.text = DateFormat.yMd("pt_BR").format(startDate);
    endDateController.text = DateFormat.yMd("pt_BR").format(endDate);
  }

  @override
  Widget build(BuildContext context) {
    final startDateField = TextFormField(
      controller: startDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 01/02/2002",
        labelText: "Início",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: startDateController.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => setState(startDateController.clear),
              )
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: startDate,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly
        );
        if (pickedDate != null) {
          setState(() {
            startDateController.text = DateFormat.yMd("pt_BR").format(pickedDate);
            startDate = pickedDate;
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor, selecione uma data.";
        }
        return null;
      }
    );

    final endDateField = TextFormField(
      controller: endDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 01/03/2002",
        labelText: "Fim",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: endDateController.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => setState(endDateController.clear),
              )
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: endDate,
          firstDate: startDate.add(Duration(days: 1)),
          lastDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly
        );
        if (pickedDate != null) {
          setState(() {
            endDateController.text = DateFormat.yMd("pt_BR").format(pickedDate);
            endDate = pickedDate;
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor, selecione uma data.";
        }
        return null;
      }
    );
    return SingleChildScrollView(child: Padding(padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(padding: EdgeInsets.all(8.0),
          child: Column(spacing: 8.0, children: [
            Text("Evolução das Pesagens", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Row(children: [
              Expanded(flex: 32, child: startDateField),
              Spacer(flex: 1),
              Expanded(flex: 32, child: endDateField)
            ]),
            WeightingAnalysisViewPlot(startDate: startDate, endDate: endDate)
          ])
        )
      )
    ));
  }
}

class _ReproductionAnalysisViewState extends State<ReproductionAnalysisView> {
  final startDateController = TextEditingController();
  late DateTime startDate;

  final endDateController = TextEditingController();
  late DateTime endDate;

  @override
  void initState() {
    super.initState();

    endDate = DateTime.now();
    startDate = endDate.subtract(Duration(days:30));

    startDateController.text = DateFormat.yMd("pt_BR").format(startDate);
    endDateController.text = DateFormat.yMd("pt_BR").format(endDate);
  }

  @override
  Widget build(BuildContext context) {
    final startDateField = TextFormField(
      controller: startDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 01/02/2002",
        labelText: "Início",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: startDateController.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => setState(startDateController.clear),
              )
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: startDate,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly
        );
        if (pickedDate != null) {
          setState(() {
            startDateController.text = DateFormat.yMd("pt_BR").format(pickedDate);
            startDate = pickedDate;
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor, selecione uma data.";
        }
        return null;
      }
    );

    final endDateField = TextFormField(
      controller: endDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Exemplo: 01/03/2002",
        labelText: "Fim",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: endDateController.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => setState(endDateController.clear),
              )
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: endDate,
          firstDate: startDate.add(Duration(days: 1)),
          lastDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly
        );
        if (pickedDate != null) {
          setState(() {
            endDateController.text = DateFormat.yMd("pt_BR").format(pickedDate);
            endDate = pickedDate;
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor, selecione uma data.";
        }
        return null;
      }
    );
    return SingleChildScrollView(child: Padding(padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(padding: EdgeInsets.all(8.0),
          child: Column(spacing: 8.0, children: [
            Text("Taxa de Prenhez - Inseminações", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Row(children: [
              Expanded(flex: 32, child: startDateField),
              Spacer(flex: 1),
              Expanded(flex: 32, child: endDateField)
            ]),
            ReproductionAnalysisViewPlot(startDate: startDate, endDate: endDate)
          ])
        )
      )
    ));
  }
}

class YearPregnancyStat {
  int positive;
  int negative;

  YearPregnancyStat({ required this.positive, required this.negative });
}

class ReproductionAnalysisViewPlot extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  const ReproductionAnalysisViewPlot({ super.key, required this.startDate, required this.endDate });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<YearPregnancyStat>(
      future: queryData(startDate, endDate), // Call your async function here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data: ${snapshot.error}')); // Show error message
        } else if (snapshot.hasData) {
          final stats = snapshot.data!;

          final positives = stats.positive;
          final negatives = stats.negative;
          if (positives + negatives == 0) {

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Center(child: Text("Nada para ver aqui."))
              );
          }

          final successRate = (positives / (positives + negatives)) * 100;
          final failureRate = (negatives / (positives + negatives)) * 100;

          final chart = PieChart(
            PieChartData(sections: [
              PieChartSectionData(
                value: successRate,
                title: "${successRate.toStringAsFixed(2)}% ($positives)",
                color: Colors.green
              ),
              PieChartSectionData(
                value: failureRate,
                title: "${failureRate.toStringAsFixed(2)}% ($negatives)",
                color: Colors.red
              ),
            ])
          );

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Center(child: Column(spacing: 4.0, children: [
            Expanded(child: chart),
            Row(spacing: 2.0, children: [
              SizedBox(width: 32, height: 32, child: Container(color: Colors.green)),
              Text("Positivo"),
              SizedBox(width: 16.0),
              SizedBox(width: 32, height: 32, child: Container(color: Colors.red)),
              Text("Negativo"),
            ]),
          ])));
        } else {
          return Center(child: Text('No data available.')); // No data yet
        }
      },
    );
  }

  Future<YearPregnancyStat> queryData(DateTime startDate, DateTime endDate) async {
    final isar = GetIt.I<Isar>();

    final negativesFutN = isar.naturalReproductions.filter()
                                            .diagnosticEqualTo(ReproductionDiagnostic.negative)
                                            .dateBetween(startDate, endDate)
                                            .count();

    final positivesFutN = isar.naturalReproductions.filter()
                                            .diagnosticEqualTo(ReproductionDiagnostic.positive)
                                            .dateBetween(startDate, endDate)
                                            .count();

    final negativesFut = isar.artificialInseminationReproductions.filter()
                                            .diagnosticEqualTo(ReproductionDiagnostic.negative)
                                            .dateBetween(startDate, endDate)
                                            .count();

    final positivesFut = isar.artificialInseminationReproductions.filter()
                                            .diagnosticEqualTo(ReproductionDiagnostic.positive)
                                            .dateBetween(startDate, endDate)
                                            .count();

    final results = await Future.wait([ positivesFutN, negativesFutN, positivesFut, negativesFut ]);

    final positives = results[0] + results[2];
    final negatives = results[1] + results[3];

    return YearPregnancyStat(positive: positives, negative: negatives);
  }
}
