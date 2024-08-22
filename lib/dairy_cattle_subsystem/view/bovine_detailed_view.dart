import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/bovine.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/cow_milk_production.dart';
import 'package:integrazoo/dairy_cattle_subsystem/model/treatment.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';


class BovineDetailedView extends StatefulWidget {
    final CentralController controller;
    final Bovine cattle;

    const BovineDetailedView({ super.key, required this.cattle, required this.controller });


    @override
    State<BovineDetailedView> createState() => _BovineDetailedView();

}

class _BovineDetailedView extends State<BovineDetailedView> {
  Exception? exception;

    @override
    Widget build(BuildContext context) {
      if (exception != null) {
        return AlertDialog(
          title: const Text('Falha ao procurar animais.'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[ const Text('Algo falhou ao procurar por animais.'),
                                  const Text('Por favor, contate a equipe INTEGRAZOO.'),
                                  Text(exception.toString()) ],
            ),
          ),
          actions: <Widget>[ TextButton(child: const Text('Fechar'), onPressed: () => setState(() => exception = null)) ],
        );
      }

      const textStyle = TextStyle(fontSize: 30, color: Colors.white);

      return FutureBuilder(
        future: fetchData(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData){
            return const CircularProgressIndicator();
          }

          List<Widget> columnBody = List.empty(growable: true);

          columnBody.add(Row(children: [ Expanded(child: Container(color: const Color.fromARGB(255, 114, 180, 117), child: Center(child: Text(widget.cattle.name, style: textStyle)))) ]));

          final DateFormat formatter = DateFormat('dd/MM/yy');
          final DateFormat formatterS = DateFormat('dd/MM');

          final treatments = widget.cattle.treatments.map(
            (t) => Row(children: [ Expanded(child: Center(child:
              Text("${formatter.format(t.period.start)} - ${formatter.format(DateTime(t.period.end.year, t.period.end.month, t.period.end.day + t.restingTime.inDays))}: ${t.medicine} => ${t.reason}")
            )) ])
          ).toList();

          treatments.insert(0, const Row(children: [ Expanded(child: Center(child: Text("Tratamentos Aplicados"))) ]));

          columnBody.add(Row(children: [ Expanded(child: Card.outlined(color: Colors.amber[100], child: Column(children: treatments))) ]));

          if (snapshot.data!.containsKey("milkProduction")) {
            final milkProduction = snapshot.data!['milkProduction'] as List<CowMilkProduction>;

            inspect(milkProduction);

            final productionChart = BarChart(BarChartData(
              barGroups: milkProduction.asMap().entries.map(
                (entry) {
                  inspect(entry.key);
                  inspect(entry.value.volume);
                  return BarChartGroupData(x: entry.key, barRods: [ BarChartRodData(toY: entry.value.volume) ]);
                }
              ).toList(),
            ));

            columnBody.add(Container(
                    padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                    child: Card(child: AspectRatio(aspectRatio: 1.3,
                        child: Column(children: [
                            const Spacer(flex: 1),
                            const Expanded(flex: 2, child: Text("Produção", style: TextStyle(fontSize: 20))),
                            Expanded(flex: 12, child: Padding(padding: const EdgeInsets.all(8), child: productionChart))
                        ])
                    ))
                ));
          }



          return IntegrazooBaseApp(body: ListView(children: columnBody));
        }
      );
    }

    Future<Map<String, dynamic>> fetchData() async {
      Map<String, dynamic> mappedData = {};

      if (widget.cattle.treatments.isEmpty) {
        widget.cattle.treatments.addAll(await widget.controller.treatmentController.getTreatments(widget.cattle));
      }

      if (widget.cattle.sex == Sex.female) {
        mappedData["milkProduction"] = await widget.controller.cowProductionController.getMilkProduction(Cow(widget.cattle.id, widget.cattle.name));
      }

      return Future.value(mappedData);
    }
}

