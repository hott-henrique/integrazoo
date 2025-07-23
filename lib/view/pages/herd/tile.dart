import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';
import 'package:integrazoo/domain/bovine/sex.dart';
import 'package:integrazoo/domain/bovine/finishing_reason.dart';
import 'package:isar/isar.dart';


class BovineTile extends StatelessWidget {
  final Bovine bovine;

  final Function(Bovine)? onClick;
  final Function(Bovine)? postDelete;
  final bool showDelete;

  const BovineTile({
    super.key,
    required this.bovine,
    this.showDelete = true,
    this.onClick,
    this.postDelete
  });

  @override
  Widget build(BuildContext context) {
    final breederString = bovine.sex == Sex.female ? "Matriz" : "Reprodutor";
    final suffixString = bovine.sex == Sex.female ? "a" : "o";
    final sexColor = bovine.sex == Sex.female ? Colors.pink : Colors.blue;
    return ListTile(
      tileColor: Colors.white70,
      title: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style, // inherit default style
          children: [
            TextSpan(text: bovine.name != null ? "${bovine.name!} " : ""),
            TextSpan(
              text: "#${bovine.earring}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      subtitle: Wrap(spacing: 8, children: [
        Badge(label: Text(bovine.sex.toString()), backgroundColor: sexColor),
        if (bovine.weaning.value != null)
          Badge(label: Text("Desmamad$suffixString"), backgroundColor: Colors.orange),

        if (bovine.isBreeder)
          Badge(label: Text(breederString), backgroundColor: Colors.amber[700]!),

        if (bovine.isReproducing())
          Badge(label: Text("Reproduzindo"), backgroundColor: Colors.teal[600]!),

        if (bovine.isPregnant())
          Badge(label: Text("Prenha"), backgroundColor: Colors.pink[400]!),

        if (bovine.finishingReason != FinishingReason.notYet)
          Badge(label: Text(getFinishBadge()), backgroundColor: Colors.grey[700]!),

        if (bovine.isOnTreatment())
          Badge(label: Text("Em Tratamento"), backgroundColor: Colors.green[300]!),
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: showDelete ?
                IconButton(icon: Icon(Icons.delete, color: Colors.redAccent), onPressed: () => delete(context)) :
                null,
      onTap: () => onClick?.call(bovine)
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
            postDelete?.call(bovine);
          })
        ]))
      );
    });
  }

  void deleteAnimal() {
    final isar = GetIt.instance<Isar>();

    isar.writeTxnSync(() {
      isar.bovines.deleteSync(bovine.earring);
    });
  }

  String getFinishBadge() {
    assert(bovine.finish.value != null);

    late String text;

    final suffixString = bovine.sex == Sex.female ? "a" : "o";

    switch (bovine.finishingReason) {
      case FinishingReason.death:
        text = "Mort$suffixString";
        break;

      case FinishingReason.discard:
        text = "Descartad$suffixString";
        break;

      case FinishingReason.sell:
        text = "Vendid$suffixString";
        break;

      case FinishingReason.slaughter:
        text = "Abatid$suffixString";
        break;

      case FinishingReason.notYet:
        text = "Não Finalizad$suffixString Ainda";
        break;
    }

    return text;
  }

}

//class _PopupMenuActions extends StatefulWidget {
//  final Bovine bovine;
//
//  final VoidCallback? postAction;
//
//  const _PopupMenuActions({ super.key, required this.bovine, this.postAction });
//
//  @override
//  State<_PopupMenuActions> createState() => _PopupMenuActionsState();
//}
//
//class _PopupMenuActionsState extends State<_PopupMenuActions> {
//
//  void _handleAction(String action, BuildContext context) {
//    switch (action) {
//      case "Editar":
//        showDialog(
//          context: context,
//          builder: (context) => Dialog(child: BovineForm(bovine: widget.bovine, shouldPop: true))
//        ).then((_) => widget.postAction?.call());
//        break;
//
//      case "Deletar":
//        showDialog(
//          context: context,
//          builder: (context) => AlertDialog(
//            icon: const Icon(Icons.info),
//            title: const Text("Deseja mesmo deletar este animal?"),
//            actions: [ TextButton(
//              onPressed: () async {
//                await BovineService.deleteBovine(widget.bovine.earring);
//
//                if (mounted && context.mounted) {
//                  Navigator.of(context).pop();
//                }
//
//                widget.postAction!();
//              },
//              child: const Text("CONFIRMAR"),
//            ) ],
//          )
//        );
//        break;
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return PopupMenuButton<String>(
//      onSelected: (action) => _handleAction(action, context),
//      itemBuilder: (BuildContext context) => ["Editar", "Deletar"]
//          .map((action) => PopupMenuItem<String>(value: action, child: Text(action)))
//          .toList(),
//    );
//  }
//}
//
