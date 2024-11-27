import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/screens/bovine_detailed.dart';

import 'package:integrazoo/database/database.dart';


class BovineListTile extends StatelessWidget {
  final Bovine bovine;

  const BovineListTile({ super.key, required this.bovine });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    const ImageIcon cowHead = ImageIcon(AssetImage("assets/icons/cow-head.png"));
    const ImageIcon bullHead = ImageIcon(AssetImage("assets/icons/bull-head.png"));
    const ImageIcon bullHeadDead = ImageIcon(AssetImage("assets/icons/bull-dead.png"));
    const ImageIcon cowHeadDead = ImageIcon(AssetImage("assets/icons/cow-dead.png"));
    
    return ListTile(
      title: Text(bovine.name),
      // subtitle: cattle.birth == null ? null : Text('Data de Nascimento: ${formatter.format(cattle.birth!.date)}'),
      leading: bovine.sex == Sex.male ? bullHead : cowHead,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BovineDetailedScreen(bovine: bovine)));
      }
    );
  }
}
