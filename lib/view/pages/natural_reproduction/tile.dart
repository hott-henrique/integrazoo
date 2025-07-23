import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/reproduction/reproduction.dart';
import 'package:integrazoo/domain/reproduction/reproduction_diagnostic.dart';


class NaturalReproductionTile extends StatelessWidget {
  final NaturalReproduction insemination;

  final Function(NaturalReproduction)? onClick;
  final Function(NaturalReproduction)? postDelete;

  final bool showDeleteBtn;

  const NaturalReproductionTile({
    super.key,
    required this.insemination,
    this.onClick,
    this.postDelete,
    this.showDeleteBtn = true
  });

  @override
  Widget build(BuildContext context) {
    insemination.cow.loadSync();
    insemination.bull.loadSync();

    final format = DateFormat.yMd("pt_BR");

    return ListTile(
      tileColor: Colors.white70,
      title: Text("${insemination.cow.value.toString()} e ${insemination.bull.value!.toString()} - ${format.format(insemination.date)}"),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      subtitle: Wrap(spacing: 8, children: [
        if (insemination.diagnostic == ReproductionDiagnostic.waiting)
          Badge(label: Text(insemination.diagnostic.label), backgroundColor: Colors.blue),

        if (insemination.diagnostic == ReproductionDiagnostic.negative)
          Badge(label: Text(insemination.diagnostic.label), backgroundColor: Colors.redAccent),

        if (insemination.diagnostic == ReproductionDiagnostic.positive)
          Badge(label: Text(insemination.diagnostic.label), backgroundColor: Colors.green),

        if (insemination.pregnancy?.ending != null)
          Badge(label: Text(insemination.pregnancy!.ending!.label), backgroundColor: Colors.orange),
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: showDeleteBtn ?
      IconButton(icon: Icon(Icons.delete, color: Colors.redAccent), onPressed: () => delete(context)) : null,
      onTap: () => onClick?.call(insemination)
    );
  }

  void delete(BuildContext ctx) {
    showDialog(context: ctx, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Padding(padding: EdgeInsets.all(4.0), child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Deseja mesmo deletar esta inseminação?"),
          TextButton(child: Text("CONFIRMAR"), onPressed: () {
            deleteReproduction();
            Navigator.of(context).pop();
            postDelete?.call(insemination);
          })
        ]))
      );
    });
  }

  void deleteReproduction() {
    final isar = GetIt.instance<Isar>();

    isar.writeTxnSync(() {
      isar.naturalReproductions.deleteSync(insemination.id);
    });
  }
}
