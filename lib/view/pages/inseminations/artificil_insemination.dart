import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:integrazoo/domain/reproduction/pregnancy.dart';
import 'package:integrazoo/domain/reproduction/reproduction_diagnostic.dart';
import 'package:integrazoo/view/forms/bovine/bovine.dart';
import 'package:integrazoo/view/forms/reproduction/pregnancy.dart';
import 'package:integrazoo/view/forms/reproduction/pregnancy_loss.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/view/forms/reproduction/artificial_insemination.dart';

import 'package:integrazoo/domain/reproduction/reproduction.dart';


class ArtificialInseminationScreen extends StatefulWidget {
  final ArtificialInseminationReproduction insemination;

  final VoidCallback? onClose;

  const ArtificialInseminationScreen({ super.key, required this.insemination, this.onClose });

  @override
  State<ArtificialInseminationScreen> createState() => _ArtificialInseminationScreen();
}

class _ArtificialInseminationScreen extends State<ArtificialInseminationScreen> {
  bool isEditing = false;
  late ArtificialInseminationReproduction insemination;

  @override
  void initState() {
    super.initState();

    insemination = widget.insemination;
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
                // Tab(icon: Icon(Icons.analytics)),
                // Tab(icon: Icon(Icons.inventory)),
              ],
            )),
            IconButton(icon: Icon(Icons.close), onPressed: widget.onClose),
          ]),
          Expanded(
            child: TabBarView(
              children: [
                tabInfo(),
                // tabAnalytics(),
                // Center(child: Text('Content for Tab 3')),
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
    columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildDiagnostic()));
    if (insemination.diagnostic == ReproductionDiagnostic.waiting) {
      columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildToDiagnosticButton()));
    }
    if (
      insemination.diagnostic == ReproductionDiagnostic.positive
      &&
      !(insemination.pregnancy?.ending != null)
    ) {
      columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildToBirthButton()));
      columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildFailedPregnancyButton()));
    }

    if (insemination.pregnancy?.ending != null) {
      columnBody.add(Padding(padding: EdgeInsets.only(right: 8.0, left: 8.0), child: buildBirthInfo()));
    }

    if (insemination.pregnancy?.ending != null && insemination.pregnancy!.ending == PregnancyEndingReason.fail) {

    }

    columnBody.add(Divider(color: Colors.transparent));


    insemination.cow.loadSync(); // TODO: .then(() => ()); Update state.

    if (isEditing) {
      return SingleChildScrollView(padding: EdgeInsets.all(0), child: Column(children: [
        Row(children: [
          Expanded(child: Text(
            "Atualizando Inseminação ${insemination.cow.value!.toString()}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => setState(() => isEditing = false))
        ]),
        ArtificialInseminationFormView(insemination: insemination, postSave: () {
          final isar = GetIt.instance<Isar>();

          isar.artificialInseminationReproductions.get(insemination.id).then((i) {
            setState(() {
              isEditing = false;
              insemination = i!;
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
        if (widget.insemination.diagnostic == ReproductionDiagnostic.waiting)
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
    widget.insemination.born.loadSync();

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Resultado", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Final", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(widget.insemination.pregnancy!.ending!.label),
          if (widget.insemination.pregnancy!.ending! == PregnancyEndingReason.birth) ...[
            Text("Animal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(widget.insemination.born.value!.toString()),
          ] else ...[
            Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(widget.insemination.pregnancy!.endingDate!)),
            Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(widget.insemination.pregnancy!.failureObservation ?? "-"),
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
          Text("#${widget.insemination.id}"),
        ])
      )
    );
  }

  Widget buildReproductionInfo() {
    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Reprodução", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Matriz", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(widget.insemination.cow.value!.toString()),
          Text("Reprodutor", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(widget.insemination.breeder.value!.name),
          Text("Pipeta", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(widget.insemination.straw),
          Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(DateFormat.yMd("pt_BR").format(widget.insemination.date)),
          Text("Diagnóstico", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(widget.insemination.diagnostic.label),
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
          Text(widget.insemination.diagnostic.label),
          if (widget.insemination.diagnostic != ReproductionDiagnostic.waiting) ...[
            Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(widget.insemination.diagnosticDate!)),
          ],
          if (widget.insemination.diagnostic == ReproductionDiagnostic.positive) ...[
            Text("Previsão de Data do Parto", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(widget.insemination.pregnancy!.birthForecast)),
            Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(widget.insemination.pregnancy!.observation ?? "-"),
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
            widget.insemination.diagnostic = diagnostic;
            widget.insemination.diagnosticDate = diagnosticDate;
            widget.insemination.pregnancy = pregnancy;

            final isar = GetIt.I<Isar>();

            isar.writeTxnSync(() {
              isar.artificialInseminationReproductions.putSync(widget.insemination);
            });
          },
          inseminationReproduction: insemination,
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
          pregnancy: widget.insemination.pregnancy!,
          onSave: (date, observation) {
            widget.insemination.pregnancy!.ending = PregnancyEndingReason.fail;
            widget.insemination.pregnancy!.endingDate = date;
            widget.insemination.pregnancy!.failureObservation = observation;

            final isar = GetIt.I<Isar>();

            isar.writeTxnSync(() {
              isar.artificialInseminationReproductions.putSync(widget.insemination);
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
        BovineFormView(artificialInsemination: insemination, postSave: () => setState(Navigator.of(context).pop))
      ])));
    });
  }

  Widget tabAnalytics() {
    return SizedBox();
  }
}
