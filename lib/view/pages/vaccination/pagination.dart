import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/domain/health/vaccine.dart';

import 'package:integrazoo/view/components/pagination/base/paginator.dart';
import 'package:integrazoo/view/components/pagination/data_loaders/vaccinations_data_loader.dart';

import 'package:integrazoo/view/forms/health/vaccination.dart';
import 'package:integrazoo/view/pages/vaccination/tile.dart';
import 'package:integrazoo/view/pages/vaccination/vaccine.dart';



class VaccinationsPaginationView extends StatefulWidget {
  const VaccinationsPaginationView({ super.key });

  @override
  State<VaccinationsPaginationView> createState() => _VaccinationsPaginationView();
}

class _VaccinationsPaginationView extends State<VaccinationsPaginationView> {
  late VaccinationsDataLoader _dataSource;

  Vaccine? vaccine;

  @override
  void initState() {
    super.initState();

    _dataSource = VaccinationsDataLoader();
  }

  @override
  Widget build(BuildContext context) {
    if (vaccine != null) {
      return VaccineScreen(vaccine: vaccine!, onClose: () => setState(() => vaccine = null));
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
            label: Text("Nova Vacinação"),
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
            "Nova Vacinação",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop())
        ]),
        VaccinationFormView(postSave: () {
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

    return Padding(padding: EdgeInsets.all(1.0), child: VaccineTile(
      vaccine: s,
      onClick: (b) => setState(() => vaccine = b),
      postDelete: (b) => _dataSource.reload()
    ));
  }
}
