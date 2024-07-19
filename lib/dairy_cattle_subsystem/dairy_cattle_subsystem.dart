import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:integrazoo/dairy_cattle_subsystem/persistence/central_persistence.dart';
import 'package:integrazoo/dairy_cattle_subsystem/persistence/bovine_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/bovine_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/cow_production_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/herd_production_controller.dart';

import 'package:integrazoo/dairy_cattle_subsystem/persistence/cow_production_persistence.dart';
import 'package:integrazoo/dairy_cattle_subsystem/persistence/herd_production_persistence.dart';

import 'package:integrazoo/dairy_cattle_subsystem/view/cow_production_form.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/herd_production_form.dart';

import 'package:integrazoo/dairy_cattle_subsystem/view/herd_view.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/analysis_view.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/health_calendar_view.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/treatment_view.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/reproduction_view.dart';


class DairyCattleSubsystem {
    late CentralController centralController;
    late CentralPersistence centralPersistence;

    DairyCattleSubsystem() {
        centralPersistence = CentralPersistence(
          BovinePersistence(),
          CowProductionPersistence(),
          HerdProductionPersistence()
        );
        centralController = CentralController(
          BovineController(centralPersistence),
          CowProductionController(centralPersistence),
          HerdProductionController(centralPersistence)
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
            ListTile(title: const Text("Reprodução"), onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReproductionView(controller: centralController))
                );
            }),
            ListTile(title: const Text("Tratamentos"), onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TreatmentView(controller: centralController))
                );
            }),
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

