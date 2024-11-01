import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/model/bovine/bovine.dart';
import 'package:integrazoo/view/screens/bovine_detailed.dart';


class BovineListTile extends StatelessWidget {
  final Bovine cattle;

  const BovineListTile({ super.key, required this.cattle });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    const ImageIcon cowHead = ImageIcon(AssetImage("assets/icons/cow-head.png"));
    const ImageIcon bullHead = ImageIcon(AssetImage("assets/icons/bull-head.png"));

    return ListTile(
      title: Text(cattle.name),
      subtitle: cattle.birth == null ? null : Text('Data de Nascimento: ${formatter.format(cattle.birth!.date)}'),
      leading: cattle.sex == Sex.male ? bullHead : cowHead,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BovineDetailedScreen(cattle: cattle)));
      }
    );
  }
}
