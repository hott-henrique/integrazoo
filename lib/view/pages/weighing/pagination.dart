import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';
import 'package:integrazoo/domain/bovine/weighing.dart';


import 'package:integrazoo/view/components/pagination/base/paginator.dart';
import 'package:integrazoo/view/components/pagination/data_loaders/weighings_data_loader.dart';

import 'package:integrazoo/view/pages/weighing/tile.dart';
import 'package:integrazoo/view/forms/bovine/weighting.dart';
import 'package:integrazoo/view/pages/weighing/weighing.dart';


class WeighingsPaginationView extends StatefulWidget {
  const WeighingsPaginationView({ super.key });

  @override
  State<WeighingsPaginationView> createState() => _WeighingsPaginationView();
}

class _WeighingsPaginationView extends State<WeighingsPaginationView> {
  late WeighingsDataLoader _dataSource;

  Weighing? weighing;

  @override
  void initState() {
    super.initState();

    _dataSource = WeighingsDataLoader();
  }

  @override
  Widget build(BuildContext context) {
    if (weighing != null) {
      return WeighingScreen(weighing: weighing!, onClose: () => setState(() => weighing = null));
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
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextButton.icon(
            label: Text("Nova Pesagem"),
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
            "Nova Pesagem",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop())
        ]),
        WeighingFormView(postSave: () {
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

    return Padding(padding: EdgeInsets.all(1.0), child: WeighingTile(
      weighing: s,
      onClick: (b) => setState(() => weighing = b),
      postDelete: (b) => _dataSource.reload()
    ));
  }
}
