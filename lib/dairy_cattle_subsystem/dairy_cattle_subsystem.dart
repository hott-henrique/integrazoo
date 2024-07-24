import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/dairy_cattle_subsystem/persistence/central_persistence.dart';
import 'package:integrazoo/dairy_cattle_subsystem/persistence/bovine_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/bovine_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/cow_production_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/herd_production_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/dry_treatment_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/treatment_controller.dart';

import 'package:integrazoo/dairy_cattle_subsystem/persistence/cow_production_persistence.dart';
import 'package:integrazoo/dairy_cattle_subsystem/persistence/herd_production_persistence.dart';
import 'package:integrazoo/dairy_cattle_subsystem/persistence/dry_treatment_persistence.dart';
import 'package:integrazoo/dairy_cattle_subsystem/persistence/treatment_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/view/cow_production_form.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/herd_production_form.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/artificial_insemination_form.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/coverage_form.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/dry_treatment_form.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/treatment_form.dart';

import 'package:integrazoo/dairy_cattle_subsystem/view/herd_view.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/analysis_view.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/health_calendar_view.dart';


class DairyCattleSubsystem {
    late CentralController centralController;
    late CentralPersistence centralPersistence;

    DairyCattleSubsystem() {
        centralPersistence = CentralPersistence(
          BovinePersistence(),
          CowProductionPersistence(),
          HerdProductionPersistence(),
          DryTreatmentPersistence(),
          TreatmentPersistence(),
        );
        centralController = CentralController(
          BovineController(centralPersistence),
          CowProductionController(centralPersistence),
          HerdProductionController(centralPersistence),
          DryTreatmentController(centralPersistence),
          TreatmentController(centralPersistence)
        );
    }

    List<Widget> createSubsystemTiles(BuildContext context) {
        return [
            ListTile(title: const Text("Análise"), onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AnalysisView())
                );
            }),
            ListTile(title: const Text("Rebanho"), onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HerdView(controller: centralController))
                );
            }),
            ExpansionTile(
              title: const Text("Produção"),
              children: [
                ListTile(title: const Text('Vaca'), onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CowProductionForm(controller: centralController))
                  );
                }),
                ListTile(title: const Text('Rebanho'), onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HerdProductionForm(controller: centralController))
                  );
                }),
              ]
            ),
            ExpansionTile(
              title: const Text("Reprodução"),
              children: [
                ListTile(title: const Text('Cobertura'), onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CoverageForm(controller: centralController))
                  );
                }),
                ListTile(title: const Text('Insiminação Artificial'), onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ArtificialInseminationForm(controller: centralController))
                  );
                }),
              ]
            ),
            ExpansionTile(
              title: const Text("Tratamentos"),
              children: [
                ListTile(title: const Text('Vacas Secas'), onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DryTreatmentForm(controller: centralController))
                  );
                }),
                ListTile(title: const Text('Demais Tratamentos'), onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TreatmentForm(controller: centralController))
                  );
                }),
              ]
            ),
            ListTile(title: const Text("Calendário Sanitário"), onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HealthCalendarView())
                );
            }),
        ];
    }

    static onDatabaseCreate(Database db, int version) {
        CentralPersistence.onDatabaseCreate(db, version);
    }
}

