import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';

import 'package:integrazoo/dairy_cattle_subsystem/view/artificial_insemination_form.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/coverage_form.dart';


class ReproductionView extends StatefulWidget {
    final CentralController controller;

    const ReproductionView({ super.key, required this.controller });


    @override
    State<ReproductionView> createState() => _ReproductionView();

}

class _ReproductionView extends State<ReproductionView> {

    @override
    Widget build(BuildContext context) {
        return IntegrazooBaseApp(body: DefaultTabController(length: 2, child: Column(
            children: [
                const TabBar(tabs: [ Tab(text: "Cobertura"), Tab(text: "Inseminação Artificial") ]),
                Expanded(child: TabBarView(children: [
                    CoverageForm(controller: widget.controller),
                    ArtificialInseminationForm(controller: widget.controller)
                ]))
            ],
        )));
    }
    /* Icons:
     * Cow <a href="https://www.flaticon.com/free-icons/cow" title="cow icons">Cow icons created by kerismaker - Flaticon</a>
     * Bull <a href="https://www.flaticon.com/free-icons/thorn" title="thorn icons">Thorn icons created by berkahicon - Flaticon</a>
     */
}

