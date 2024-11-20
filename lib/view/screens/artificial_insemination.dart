import 'dart:developer';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/view/forms/reproduction/pregnancy_form.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';
import 'package:integrazoo/control/semen_controller.dart';

import 'package:integrazoo/database/database.dart';


class ArtificialInseminationDetailedScreen extends StatefulWidget {
  // final Reproduction attempt;
  final int reproductionId;

  const ArtificialInseminationDetailedScreen({ super.key, required this.reproductionId });

  @override
  State<ArtificialInseminationDetailedScreen> createState() => _ArtificialInseminationDetailedScreen();
}

class _ArtificialInseminationDetailedScreen extends State<ArtificialInseminationDetailedScreen> {
  Exception? exception;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      inspect(exception);
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    return FutureBuilder(
      future: ReproductionController.getReproductionById(widget.reproductionId),
      builder: (context, AsyncSnapshot<Reproduction> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final reproduction = snapshot.data!;

        return buildComplete(reproduction);
      }
    );
  }

  Widget buildComplete(Reproduction reproduction) {
    final dateFormatter = DateFormat("dd/MM/yyyy");

    List<Widget> columnBody = List.empty(growable: true);

    List<Widget> attemptInfoBody = List.empty(growable: true);

    columnBody.add(const Row(children: [ Expanded(child: Text("Inseminação Artificial", textAlign: TextAlign.center)) ]));

    final dateInfo = Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(children: [
          Row(children: [
            const Expanded(child: Text("Data")),
            Expanded(child: Text(dateFormatter.format(reproduction.date), textAlign: TextAlign.right)),
          ])
        ])
      )
    );

    attemptInfoBody.add(dateInfo);

    attemptInfoBody.add(getCowView(reproduction.cow));

    attemptInfoBody.add(getSemenMinimalView(reproduction.semen!));

    final diagnosticInfo = Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(children: [
          Row(children: [
            const Expanded(child: Text("Diagnóstico")),
            Expanded(child: Text(reproduction.diagnostic.toString(), textAlign: TextAlign.right)),
          ]),
        ])
      )
    );

    attemptInfoBody.add(diagnosticInfo);

    columnBody = columnBody + attemptInfoBody;

    if (reproduction.diagnostic == ReproductionDiagonostic.waiting) {
      columnBody.add(TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.green[400],
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))
        ),
        child: const Text("Registrar Diagnóstico Positivo"),
        onPressed: () => {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PregnancyForm(reproductionId: reproduction.id)))
        }
      ));

      columnBody.add(TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.red[400],
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))
        ),
        child: const Text("Registrar Diagnóstico Negativo"),
        onPressed: () {
          ReproductionController.registryFailedReproduction(widget.reproductionId).then(
            (_) {
              if (context.mounted) {
                SnackBar snackBar = const SnackBar(
                  content: Text('Diagnóstico realizado com sucesso.'),
                  backgroundColor: Colors.green,
                  showCloseIcon: true
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() => ());
              }
            },
            onError: (e) => setState(() => exception = e)
          );
        }
      ));
    } else {
      columnBody.add(TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.red[400],
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)))
        ),
        child: const Text("Cancelar Diagnóstico"),
        onPressed: () => {
          ReproductionController.cancelDiagnostic(reproduction.id).then(
            (_) {
              if (context.mounted) {
                SnackBar snackBar = const SnackBar(
                  content: Text('Diagnóstico cancelado com sucesso.'),
                  backgroundColor: Colors.green,
                  showCloseIcon: true
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() => ());
              }
            },
            onError: (e) => setState(() => exception = e)
          )
        }
      ));
    }

    return IntegrazooBaseApp(body: Padding(padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: columnBody)
    ));
  }

  Widget getCowView(int cowId) {
    return FutureBuilder(
      future: BovineController.getBovine(cowId),
      builder: (context, AsyncSnapshot<Bovine> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final cow = snapshot.data!;

        return Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(children: [
              Row(children: [
                const Expanded(child: Text("Vaca")),
                Expanded(child: Text(cow.name, textAlign: TextAlign.right)),
              ]),
              Row(children: [
                const Expanded(child: Text("Brinco")),
                Expanded(child: Text(cow.id.toString(), textAlign: TextAlign.right)),
              ]),
            ])
          )
        );
      }
    );
  }

  Widget getSemenMinimalView(String semen) {
    return FutureBuilder(
      future: SemenController.getSemen(semen),
      builder: (context, AsyncSnapshot<Semen> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final semen = snapshot.data!;

        return Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(children: [
              Row(children: [
                const Expanded(child: Text("Touro")),
                Expanded(child: Text(semen.bullName, textAlign: TextAlign.right))
              ]),
              Row(children: [
                const Expanded(child: Text("Semen")),
                Expanded(child: Text(semen.semenNumber, textAlign: TextAlign.right)),
              ])
            ])
          )
        );
      }
    );
  }
}
