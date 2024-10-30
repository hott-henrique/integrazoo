import 'package:flutter/material.dart';

import 'package:integrazoo/about_page.dart';

import 'package:integrazoo/view/artificial_insemination_form.dart';
import 'package:integrazoo/view/coverage_form.dart';
import 'package:integrazoo/view/cow_production_form.dart';
import 'package:integrazoo/view/dry_treatment_form.dart';
import 'package:integrazoo/view/treatment_form.dart';

import 'package:integrazoo/view/analysis_view.dart';
import 'package:integrazoo/view/health_calendar_view.dart';
import 'package:integrazoo/view/herd_view.dart';


class IntegrazooBaseApp extends StatefulWidget {
  final Widget body;

  const IntegrazooBaseApp({super.key, required this.body});

  @override
  State<IntegrazooBaseApp> createState() => _IntegrazooBaseAppState();
}

class _IntegrazooBaseAppState extends State<IntegrazooBaseApp> {
  @override
  Widget build(BuildContext context) {
    Builder leadingBuilder = Builder(builder: (BuildContext context) {
      return IconButton(
          icon: const Icon(Icons.view_list, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer());
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('INTEGRAZOO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
          backgroundColor: Colors.green,
          centerTitle: true,
          leading: leadingBuilder,
        ),
        body: widget.body,
        drawer: Drawer(child: _createDrawerItems()));
  }

  ListView _createDrawerItems() {
    List<Widget> tiles = [
      Container(
        decoration: const BoxDecoration(color: Colors.green),
        child: const ListTile(
          title: Text('CULTURA', style: TextStyle(color: Colors.white)),
          subtitle: Text('Bovinocultura (Leite)', style: TextStyle(color: Colors.white)),
          dense: true,
          leading: CircleAvatar(backgroundColor: Colors.white, foregroundColor: Colors.green, child: Icon(Icons.source)),
        )
      ),
      ListTile(
        title: const Text("Inicio"),
        onTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      ),
      ListTile(
        title: const Text("Análise"),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AnalysisView()));
        }
      ),
      ListTile(
        title: const Text("Rebanho"),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HerdView()));
        }
      ),
      ExpansionTile(title: const Text("Produção"), children: [
        ListTile(
          title: const Text('Vaca'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CowProductionForm()));
          }
        ),
      ]),
      ExpansionTile(title: const Text("Reprodução"), children: [
        ListTile(
          title: const Text('Cobertura'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CoverageForm()));
          }
        ),
        ListTile(
          title: const Text('Insiminação Artificial'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ArtificialInseminationForm()));
          }
        ),
      ]),
      ExpansionTile(title: const Text("Tratamentos"), children: [
        ListTile(
          title: const Text('Vacas Secas'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DryTreatmentForm()));
          }
        ),
        ListTile(
          title: const Text('Demais Tratamentos'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TreatmentForm()));
          }
        ),
      ]),
      ListTile(
        title: const Text("Calendário Sanitário"),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HealthCalendarView()));
        }
      ),
      ListTile(
        title: const Text("Sobre"),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutPage()));
        }
      ),
    ];

    return ListView(children: tiles);
  }
}
