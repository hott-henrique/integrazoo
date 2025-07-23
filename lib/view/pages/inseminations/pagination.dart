import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/view/components/pagination/base/paginator.dart';
import 'package:integrazoo/view/components/pagination/data_loaders/artificial_inseminations_data_loader.dart';
import 'package:integrazoo/view/forms/reproduction/artificial_insemination.dart';
import 'package:integrazoo/view/pages/inseminations/artificil_insemination.dart';

import 'package:integrazoo/view/pages/inseminations/tile.dart';

import 'package:integrazoo/domain/reproduction/reproduction.dart';


class ArtificialInseminationsPaginationView extends StatefulWidget {
  const ArtificialInseminationsPaginationView({ super.key });

  @override
  State<ArtificialInseminationsPaginationView> createState() => _ArtificialInseminationsPaginationView();
}

class _ArtificialInseminationsPaginationView extends State<ArtificialInseminationsPaginationView> {
  late ArtificialInseminationsDataLoader _dataSource;

  ArtificialInseminationReproduction? insemination;

  @override
  void initState() {
    super.initState();

    _dataSource = ArtificialInseminationsDataLoader();
  }

  @override
  Widget build(BuildContext context) {
    if (insemination != null) {
      return ArtificialInseminationScreen(insemination: insemination!, onClose: () => setState(() => insemination = null));
    }

    return Paginator(
      loader: _dataSource,
      // filtersDialog: _buildFiltersDialog(),
      // queryHintText: "Digite aqui para filtrar por nome ou brinco.",
      // onQueryChanged: _dataSource.setQuery,
      // onQueryEditingComplete: () => _dataSource.search.filter = search.search.filter,
      // onSearchButtonPressed: () => _dataSource.search.filter = search.search.filter,
      pageBuilder: buildInseminations,
    );
  }

  Widget buildInseminations(BuildContext context) {
    inspect(_dataSource.availableRows);
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextButton.icon(
            icon: Icon(Icons.add),
            label: Text("Nova Inseminação"),
            onPressed: newInsemination,
            style: IconButton.styleFrom(backgroundColor: Colors.green, foregroundColor:Colors.white)
          )
        ),
        ...List.generate(_dataSource.availableRows, buildIthElement),
      ]
    ));
  }

  void newInsemination() {
    showDialog(context: context, builder: (context) {
      return SingleChildScrollView(child:  Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Column(children: [
        Row(children: [
          Expanded(child: Text(
            "Novas Inseminações",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop())
        ]),
        ArtificialInseminationFormView(postSave: () {
          Navigator.of(context).pop();
          _dataSource.reload();
        })
      ])));
    });
  }

  Widget buildIthElement(int i) {
    if (_dataSource.isLoading) {
      return const ListTile(leading: CircularProgressIndicator());
    }

    final s = _dataSource.getElement(i);

    return Padding(padding: EdgeInsets.all(1.0), child: ArtificialInseminationTile(
      insemination: s,
      onClick: (b) => setState(() => insemination = b),
      postDelete: (b) => _dataSource.reload()
    ));
  }
}
