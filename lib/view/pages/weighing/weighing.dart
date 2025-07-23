import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:integrazoo/domain/bovine/weighing.dart';
import 'package:integrazoo/view/forms/bovine/weighting.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';


class WeighingScreen extends StatefulWidget {
  final Weighing weighing;

  final VoidCallback? onClose;

  const WeighingScreen({ super.key, required this.weighing, this.onClose });

  @override
  State<WeighingScreen> createState() => _WeighingScreen();
}

class _WeighingScreen extends State<WeighingScreen> {
  bool isEditing = false;
  late Weighing weighing;

  @override
  void initState() {
    super.initState();

    weighing = widget.weighing;
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
            "Editando Pesagem #${weighing.id.toString()}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => setState(() => isEditing = false))
        ]),
        WeighingFormView(weighing: weighing, postSave: () {
          final isar = GetIt.instance<Isar>();

          isar.weighings.get(weighing.id).then((i) {
            setState(() {
              weighing = i!;
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
          Text("#${weighing.id}"),
          Text("Animal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(widget.weighing.bovine.value!.toString()),
        ])
      )
    );
  }

  Widget buildReproductionInfo() {
    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Pesagem", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Peso", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(weighing.weight.toStringAsFixed(2)),
          Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(DateFormat.yMd("pt_BR").format(weighing.date)),
          Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(weighing.observation ?? "-"),
        ])
      )
    );
  }
}
