import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:integrazoo/dairy_cattle_subsystem/control/central_controller.dart';

import 'package:integrazoo/dairy_cattle_subsystem/model/bovine.dart';
import 'package:integrazoo/dairy_cattle_subsystem/view/bovine_detailed_view.dart';


class BovineListTile extends StatelessWidget {
    final CentralController controller;
    final Bovine cattle;

    const BovineListTile({ super.key, required this.cattle, required this.controller });

    @override
    Widget build(BuildContext context) {
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        const ImageIcon cowHead = ImageIcon(AssetImage("assets/icons/cow-head.png"));
        const ImageIcon bullHead = ImageIcon(AssetImage("assets/icons/bull-head.png"));

        return ListTile(title: Text(cattle.name),
                        subtitle: cattle.birth == null ? null : Text('Data de Nascimento: ${formatter .format(cattle.birth!.date)}'),
                        leading: cattle.sex == Sex.male ? bullHead : cowHead,
                        onTap: () {
                          Navigator.of(context)
                                   .push(MaterialPageRoute(builder: (context) => BovineDetailedView(cattle: cattle, controller: controller)));
                        });
      }

}
