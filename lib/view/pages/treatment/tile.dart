import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/health/treatment.dart';


class TreatmentTile extends StatelessWidget {
  final Treatment treatment;

  final Function(Treatment)? onClick;
  final Function(Treatment)? postDelete;

  final bool showDeleteBtn;

  const TreatmentTile({
    super.key,
    required this.treatment,
    this.onClick,
    this.postDelete,
    this.showDeleteBtn = true
  });

  @override
  Widget build(BuildContext context) {
    treatment.bovine.loadSync();

    final format = DateFormat.yMd("pt_BR");

    return ListTile(
      tileColor: Colors.white70,
      title: Text(treatment.toString()),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      subtitle: Column(children: [
        Row(children: [
          Text("Animal: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(treatment.bovine.value!.toString())
        ]),
        Row(children: [
          Text("Data: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(format.format(treatment.date))
        ]),
        if (treatment.endDate != null)
          Row(children: [
            Text("Termina em: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(format.format(treatment.endDate!))
          ]),
        Row(children: [
          Text("Motivo: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(treatment.reason)
        ])
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: showDeleteBtn ? IconButton(icon: Icon(Icons.delete, color: Colors.redAccent), onPressed: () => delete(context)) : null,
      onTap: () => onClick?.call(treatment)
    );
  }

  void delete(BuildContext ctx) {
    showDialog(context: ctx, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Padding(padding: EdgeInsets.all(4.0), child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Deseja mesmo deletar este tratamento?"),
          TextButton(child: Text("CONFIRMAR"), onPressed: () {
            deleteTreatment();
            Navigator.of(context).pop();
            postDelete?.call(treatment);
          })
        ]))
      );
    });
  }

  void deleteTreatment() {
    final isar = GetIt.instance<Isar>();

    isar.writeTxnSync(() {
      isar.treatments.deleteSync(treatment.id);
    });
  }
}
