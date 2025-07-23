import 'package:flutter/material.dart';
import 'package:integrazoo/domain/reproduction/pregnancy.dart';
import 'package:integrazoo/view/forms/reproduction/pregnancy_loss.dart';

import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/reproduction/reproduction_diagnostic.dart';
import 'package:integrazoo/domain/reproduction/reproduction.dart';

import 'package:integrazoo/view/forms/bovine/bovine.dart';
import 'package:integrazoo/view/forms/reproduction/natural.dart';
import 'package:integrazoo/view/forms/reproduction/pregnancy.dart';



class NaturalReproductionScreen extends StatefulWidget {
  final NaturalReproduction reproduction;

  final VoidCallback? onClose;

  const NaturalReproductionScreen({ super.key, required this.reproduction, this.onClose });

  @override
  State<NaturalReproductionScreen> createState() => _NaturalReproductionScreen();
}

class _NaturalReproductionScreen extends State<NaturalReproductionScreen> {
  bool isEditing = false;
  late NaturalReproduction reproduction;

  @override
  void initState() {
    super.initState();

    reproduction = widget.reproduction;
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

    columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildIdInfo()));
    columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildReproductionInfo()));
    columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildDiagnostic()));
    if (reproduction.diagnostic == ReproductionDiagnostic.waiting) {
      columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildToDiagnosticButton()));
    }
    if (
      reproduction.diagnostic == ReproductionDiagnostic.positive
      &&
      !(reproduction.pregnancy?.ending != null)
    ) {
      columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildToBirthButton()));
      columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildFailedPregnancyButton()));
    }

    if (reproduction.pregnancy?.ending != null) {
      columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildBirthInfo()));
    }

    reproduction.cow.loadSync(); // TODO: .then(() => ()); Update state.
    // reproduction.bull.loadSync(); // TODO: .then(() => ()); Update state.

    if (isEditing) {
      return SingleChildScrollView(padding: EdgeInsets.all(0), child: Column(children: [
        Row(children: [
          Expanded(child: Text(
            "Atualizando Monta ${reproduction.cow.value!.toString()}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => setState(() => isEditing = false))
        ]),
        NaturalReproductionFormView(reproduction: reproduction, postSave: () {
          final isar = GetIt.instance<Isar>();

          isar.naturalReproductions.get(reproduction.id).then((i) {
            setState(() {
              isEditing = false;
              reproduction = i!;
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
        if (widget.reproduction.diagnostic == ReproductionDiagnostic.waiting)
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

  Widget buildBirthInfo() {
    widget.reproduction.born.loadSync();

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Parto", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Final", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(widget.reproduction.pregnancy!.ending!.label),
          if (widget.reproduction.pregnancy!.ending! == PregnancyEndingReason.birth) ...[
            Text("Animal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(widget.reproduction.born.value!.toString()),
          ] else ...[
            Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(widget.reproduction.pregnancy!.endingDate!)),
            Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(widget.reproduction.pregnancy!.failureObservation ?? "-"),
          ],
        ])
      )
    );
  }

  Widget buildIdInfo() {
    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Identificação", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Número", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("#${widget.reproduction.id}"),
        ])
      )
    );
  }

  Widget buildReproductionInfo() {
    widget.reproduction.cow.loadSync();
    widget.reproduction.bull.loadSync();

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Reprodução", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Matriz", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(widget.reproduction.cow.value!.toString()),
          Text("Reprodutor", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(widget.reproduction.bull.value!.toString()),
          Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(DateFormat.yMd("pt_BR").format(widget.reproduction.date)),
        ])
      )
    );
  }

  Widget buildDiagnostic() {
    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Diagnóstico", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Resultado", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(widget.reproduction.diagnostic.label),
          if (widget.reproduction.diagnostic != ReproductionDiagnostic.waiting) ...[
            Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(widget.reproduction.diagnosticDate!)),
          ],
          if (widget.reproduction.diagnostic == ReproductionDiagnostic.positive) ...[
            Text("Previsão de Data do Parto", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(widget.reproduction.pregnancy!.birthForecast)),
            Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(widget.reproduction.pregnancy!.observation ?? "-"),
          ]
        ])
      )
    );
  }

  Widget buildToDiagnosticButton() {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: diagnostic,
        child: Text("Diagnosticar")
      )
    );
  }

  void diagnostic() {
    showDialog(context: context, builder: (context) {
      return SingleChildScrollView(child:  Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Column(children: [
        Row(children: [
          Expanded(child: Text(
            "Diagnosticar",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop())
        ]),
        PregnancyFormView(
          save: (diagnosticDate, diagnostic, pregnancy) {
            widget.reproduction.diagnostic = diagnostic;
            widget.reproduction.diagnosticDate = diagnosticDate;
            widget.reproduction.pregnancy = pregnancy;

            final isar = GetIt.I<Isar>();

            isar.writeTxnSync(() {
              isar.naturalReproductions.putSync(widget.reproduction);
            });
          },
          naturalReproduction: reproduction,
          postSave: () {
            setState(Navigator.of(context).pop);
          }
        )
      ])));
    });
  }

  Widget buildToBirthButton() {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: birth,
        child: Text("Parto")
      )
    );
  }

  Widget buildFailedPregnancyButton() {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: failPregnancy,
        style: TextButton.styleFrom(backgroundColor: Colors.red),
        child: Text("Natimorto / Reabsorção"),
      )
    );
  }

  void failPregnancy() {
    showDialog(context: context, builder: (context) {
      return SingleChildScrollView(child:  Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Column(children: [
        Row(children: [
          Expanded(child: Text(
            "Finalizar Prenhe",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop())
        ]),
        PregnancyLossFormView(
          pregnancy: widget.reproduction.pregnancy!,
          onSave: (date, observation) {
            widget.reproduction.pregnancy!.ending = PregnancyEndingReason.fail;
            widget.reproduction.pregnancy!.endingDate = date;
            widget.reproduction.pregnancy!.failureObservation = observation;

            final isar = GetIt.I<Isar>();

            isar.writeTxnSync(() {
              isar.naturalReproductions.putSync(widget.reproduction);
            });
          },
          postSave: () {
            setState(Navigator.of(context).pop);
          }
        )
      ])));
    });
  }

  void birth() {
    showDialog(context: context, builder: (context) {
      return SingleChildScrollView(child:  Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Column(children: [
        Row(children: [
          Expanded(child: Text(
            "Novo Animal",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop())
        ]),
        BovineFormView(naturalReproduction: reproduction, postSave: () => setState(Navigator.of(context).pop))
      ])));
    });
  }
}
