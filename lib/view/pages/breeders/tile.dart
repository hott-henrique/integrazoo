import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:integrazoo/domain/bovine/sex.dart';
import 'package:integrazoo/domain/reproduction/breeder.dart';
import 'package:isar/isar.dart';


class BreederTile extends StatelessWidget {
  final Breeder breeder;

  final Function(Breeder)? onClick;
  final Function(Breeder)? postDelete;

  const BreederTile({
    super.key,
    required this.breeder,
    this.onClick,
    this.postDelete
  });

  @override
  Widget build(BuildContext context) {
    final sexColor = breeder.sex == Sex.female ? Colors.pink : Colors.blue;

    return ListTile(
      tileColor: Colors.white70,
      title: Text(breeder.toString()),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      subtitle: Wrap(spacing: 8, children: [
        Badge(label: Text(breeder.sex.toString()), backgroundColor: sexColor),
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: IconButton(icon: Icon(Icons.delete, color: Colors.redAccent), onPressed: () => delete(context)),
      onTap: () => onClick?.call(breeder)
    );
  }

  void delete(BuildContext ctx) {
    showDialog(context: ctx, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Padding(padding: EdgeInsets.all(4.0), child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Deseja mesmo deletar este animal?"),
          TextButton(child: Text("CONFIRMAR"), onPressed: () {
            deleteAnimal();
            Navigator.of(context).pop();
            postDelete?.call(breeder);
          })
        ]))
      );
    });
  }

  void deleteAnimal() {
    final isar = GetIt.instance<Isar>();

    isar.writeTxnSync(() {
      isar.breeders.deleteSync(breeder.id);
    });
  }
}
