import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';

import 'package:integrazoo/dairy_cattle_subsystem/view/dry_treatment_form.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/treatment_form.dart';


class TreatmentView extends StatelessWidget {

    final CentralController controller;

    const TreatmentView({ super.key, required this.controller });


    @override

    @override
    Widget build(BuildContext context) {
        return IntegrazooBaseApp(body: DefaultTabController(length: 2, child: Column(
            children: [
                const TabBar(tabs: [ Tab(text: "Vacas Secas"), Tab(text: "Demais Tratamentos") ]),
                Expanded(child: TabBarView(children: [
                    DryTreatmentForm(controller: controller),
                    TreatmentForm(controller: controller),
                ]))
            ],
        )));
    }
}

