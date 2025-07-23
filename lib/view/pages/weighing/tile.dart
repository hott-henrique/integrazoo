import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/weighing.dart';


class WeighingTile extends StatelessWidget {
  final Weighing weighing;

  final Function(Weighing)? onClick;
  final Function(Weighing)? postDelete;

  final bool showDeleteBtn;

  const WeighingTile({
    super.key,
    required this.weighing,
    this.onClick,
    this.postDelete,
    this.showDeleteBtn = true
  });

  @override
  Widget build(BuildContext context) {
    weighing.bovine.loadSync();

    final formatter = DateFormat.yMd("pt_BR");

    return ListTile(
      tileColor: Colors.white70,
      title: Text("Pesagem #${weighing.id.toString()}"),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      subtitle: Column(children: [
        Row(children: [
          Text("Animal: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(weighing.bovine.value!.toString())
        ]),
        Row(children: [
          Text("Peso: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(weighing.weight.toStringAsFixed(2))
        ]),
        Row(children: [
          Text("Data: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(formatter.format(weighing.date))
        ]),
        Row(children: [
          Text("Observação: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(weighing.observation ?? "-")
        ])
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: showDeleteBtn ? IconButton(icon: Icon(Icons.delete, color: Colors.redAccent), onPressed: () => delete(context)) : null,
      onTap: () => onClick?.call(weighing)
    );
  }

  void delete(BuildContext ctx) {
    showDialog(context: ctx, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Padding(padding: EdgeInsets.all(4.0), child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Deseja mesmo deletar esta pesagem?"),
          TextButton(child: Text("CONFIRMAR"), onPressed: () {
            deleteWeighing();
            Navigator.of(context).pop();
            postDelete?.call(weighing);
          })
        ]))
      );
    });
  }

  void deleteWeighing() {
    final isar = GetIt.instance<Isar>();

    isar.writeTxnSync(() {
      isar.weighings.deleteSync(weighing.id);
    });
  }
}
