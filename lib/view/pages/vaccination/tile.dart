import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/health/vaccine.dart';


class VaccineTile extends StatelessWidget {
  final Vaccine vaccine;

  final Function(Vaccine)? onClick;
  final Function(Vaccine)? postDelete;

  final bool showDeleteBtn;

  const VaccineTile({
    super.key,
    required this.vaccine,
    this.onClick,
    this.postDelete,
    this.showDeleteBtn = true
  });

  @override
  Widget build(BuildContext context) {
    vaccine.bovine.loadSync();

    final format = DateFormat.yMd("pt_BR");

    return ListTile(
      tileColor: Colors.white70,
      title: Text(vaccine.toString()),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      subtitle: Column(children: [
        Row(children: [
          Text("Animal: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(vaccine.bovine.value!.toString())
        ]),
        Row(children: [
          Text("Data: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(format.format(vaccine.date))
        ])
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: showDeleteBtn ?
      IconButton(icon: Icon(Icons.delete, color: Colors.redAccent), onPressed: () => delete(context)) : null,
      onTap: () => onClick?.call(vaccine)
    );
  }

  void delete(BuildContext ctx) {
    showDialog(context: ctx, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Padding(padding: EdgeInsets.all(4.0), child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Deseja mesmo deletar esta vacinação?"),
          TextButton(child: Text("CONFIRMAR"), onPressed: () {
            deleteVaccine();
            Navigator.of(context).pop();
            postDelete?.call(vaccine);
          })
        ]))
      );
    });
  }

  void deleteVaccine() {
    final isar = GetIt.instance<Isar>();

    isar.writeTxnSync(() {
      isar.vaccines.deleteSync(vaccine.id);
    });
  }
}
