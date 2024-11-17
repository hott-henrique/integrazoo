import 'package:flutter/material.dart';

import 'package:integrazoo/view/forms/reproduction/artificial_insemination_form.dart';
import 'package:integrazoo/view/forms/reproduction/coverage_form.dart';
import 'package:integrazoo/view/forms/production/production_form.dart';
import 'package:integrazoo/view/forms/treatment/treatment_form.dart';

import 'package:integrazoo/view/screens/about.dart';
import 'package:integrazoo/view/screens/analysis.dart';
import 'package:integrazoo/view/screens/health_calendar.dart';
import 'package:integrazoo/view/screens/herd.dart';


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
        title: Text('INTEGRAZOO', style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: leadingBuilder,
      ),
      body: widget.body,
      drawer: Drawer(child: _createDrawerItems())
    );
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
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AnalysisScreen()));
        }
      ),
      ListTile(
        title: const Text("Rebanho"),
        onTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HerdScreen()));
        }
      ),
      ListTile(
        title: const Text("Produção"),
        onTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProductionForm()));
        }
      ),
      ExpansionTile(title: const Text("Reprodução"), children: [
        ListTile(
          title: const Text('Cobertura'),
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CoverageForm()));
          }
        ),
        ListTile(
          title: const Text('Insiminação Artificial'),
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ArtificialInseminationForm()));
          }
        )
      ]),
      ListTile(
        title: const Text('Tratamento'),
        onTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TreatmentForm()));
        }
      ),
      ListTile(
        title: const Text("Calendário Sanitário"),
        onTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HealthCalendarScreen()));
        }
      ),
      ListTile(
        title: const Text("Sobre"),
        onTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutScreen()));
        }
      ),
    ];

    return ListView(children: tiles);
  }
}
