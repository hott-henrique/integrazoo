import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/domain/health/treatment.dart';

import 'package:integrazoo/view/components/pagination/base/paginator.dart';
import 'package:integrazoo/view/components/pagination/data_loaders/treatments_data_loader.dart';
import 'package:integrazoo/view/forms/health/treatment.dart';

import 'package:integrazoo/view/pages/treatment/tile.dart';
import 'package:integrazoo/view/pages/treatment/treatment.dart';



class TreatmentsPaginationView extends StatefulWidget {
  const TreatmentsPaginationView({ super.key });

  @override
  State<TreatmentsPaginationView> createState() => _TreatmentsPaginationView();
}

class _TreatmentsPaginationView extends State<TreatmentsPaginationView> {
  late TreatmentsDataLoader _dataSource;

  Treatment? treatment;

  @override
  void initState() {
    super.initState();

    _dataSource = TreatmentsDataLoader();
  }

  @override
  Widget build(BuildContext context) {
    if (treatment != null) {
      return TreatmentScreen(treatment: treatment!, onClose: () => setState(() => treatment = null));
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
            label: Text("Novo Tratamento"),
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
            "Novo Tratamento",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop())
        ]),
        TreatmentFormView(postSave: () {
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

    return Padding(padding: EdgeInsets.all(1.0), child: TreatmentTile(
      treatment: s,
      onClick: (b) => setState(() => treatment = b),
      postDelete: (b) => _dataSource.reload()
    ));
  }
}
