import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/domain/reproduction/reproduction.dart';

import 'package:integrazoo/view/components/pagination/base/paginator.dart';
import 'package:integrazoo/view/components/pagination/data_loaders/natural_reproductions_data_loader.dart';
import 'package:integrazoo/view/forms/reproduction/natural.dart';
import 'package:integrazoo/view/pages/natural_reproduction/natural_reproduction.dart';
import 'package:integrazoo/view/pages/natural_reproduction/tile.dart';


class NaturalReproductionsPaginationView extends StatefulWidget {
  const NaturalReproductionsPaginationView({ super.key });

  @override
  State<NaturalReproductionsPaginationView> createState() => _NaturalReproductionsPaginationView();
}

class _NaturalReproductionsPaginationView extends State<NaturalReproductionsPaginationView> {
  late NaturalReproductionsDataLoader _dataSource;

  NaturalReproduction? reproduction;

  @override
  void initState() {
    super.initState();

    _dataSource = NaturalReproductionsDataLoader();
  }

  @override
  Widget build(BuildContext context) {
    if (reproduction != null) {
      return NaturalReproductionScreen(reproduction: reproduction!, onClose: () => setState(() => reproduction = null));
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
            label: Text("Registrar Monta"),
            icon: Icon(Icons.add),
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
            "Nova Monta",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop())
        ]),
        NaturalReproductionFormView(postSave: () {
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

    return Padding(padding: EdgeInsets.all(1.0), child: NaturalReproductionTile(
      insemination: s,
      onClick: (b) => setState(() => reproduction = b),
      postDelete: (b) => _dataSource.reload()
    ));
  }
}
