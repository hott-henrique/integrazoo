import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:integrazoo/view/forms/health/treatment.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/health/treatment.dart';


class TreatmentScreen extends StatefulWidget {
  final Treatment treatment;

  final VoidCallback? onClose;

  const TreatmentScreen({ super.key, required this.treatment, this.onClose });

  @override
  State<TreatmentScreen> createState() => _TreatmentScreen();
}

class _TreatmentScreen extends State<TreatmentScreen> {
  bool isEditing = false;
  late Treatment treatment;

  @override
  void initState() {
    super.initState();

    treatment = widget.treatment;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Column(
        children: [
          Row(children: [
            Expanded(child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.info)),
              ],
            )),
            IconButton(icon: Icon(Icons.close), onPressed: widget.onClose),
          ]),
          Expanded(
            child: TabBarView(
              children: [
                tabInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tabInfo() {
    List<Widget> columnBody = List.empty(growable: true);

    columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child:  buildIdInfo()));
    columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child:  buildReproductionInfo()));

    columnBody.add(Divider(color: Colors.transparent));

    if (isEditing) {
      return SingleChildScrollView(padding: EdgeInsets.all(0), child: Column(children: [
        Row(children: [
          Expanded(child: Text(
            "Atualizando Vacinação #${treatment.id.toString()}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => setState(() => isEditing = false))
        ]),
        TreatmentFormView(treatment: treatment, postSave: () {
          final isar = GetIt.instance<Isar>();

          isar.treatments.get(treatment.id).then((i) {
            setState(() {
              treatment = i!;
              isEditing = false;
            });
          });
        })
      ]));
    } else {
      return Stack(children: [
        SingleChildScrollView(padding: EdgeInsets.all(0), child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: columnBody
        )),
        Positioned(
          bottom: 16, right: 16,
          child: FloatingActionButton(
            onPressed: () => setState(() => isEditing = true),
            child: Icon(Icons.edit)
          )
        ),
      ]);
    }
  }

  Widget buildIdInfo() {
    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Identificação", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Número", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("#${treatment.id}"),
          Text("Animal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(widget.treatment.bovine.value!.toString()),
        ])
      )
    );
  }

  Widget buildReproductionInfo() {
    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Procedimento", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Medicação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(treatment.medicine),
          Text("Razão", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(treatment.reason),
          Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(DateFormat.yMd("pt_BR").format(treatment.date)),
          if (treatment.endDate != null) ...[
            Text("Termina em", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(treatment.endDate!)),
          ]
        ])
      )
    );
  }
}
