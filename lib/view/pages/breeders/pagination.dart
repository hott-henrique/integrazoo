import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';
import 'package:integrazoo/domain/reproduction/breeder.dart';

import 'package:integrazoo/view/components/pagination/base/paginator.dart';
import 'package:integrazoo/view/components/pagination/data_loaders/breeders_data_loader.dart';
import 'package:integrazoo/view/forms/breeder/breeder.dart';
import 'package:integrazoo/view/pages/breeders/breeder.dart';
import 'package:integrazoo/view/pages/breeders/tile.dart';


class BreedersPaginationView extends StatefulWidget {
  const BreedersPaginationView({ super.key });

  @override
  State<BreedersPaginationView> createState() => _BreedersPaginationView();
}

class _BreedersPaginationView extends State<BreedersPaginationView> {
  late BreedersDataLoader _dataSource;

  Breeder? breeder;

  @override
  void initState() {
    super.initState();

    _dataSource = BreedersDataLoader();
  }

  @override
  Widget build(BuildContext context) {
    if (breeder != null) {
      return BreederScreen(breeder: breeder!, onClose: () => setState(() => breeder = null));
    }

    return Paginator(
      loader: _dataSource,
      // filtersDialog: _buildFiltersDialog(),
      // queryHintText: "Digite aqui para filtrar por nome ou brinco.",
      // onQueryChanged: _dataSource.setQuery,
      // onQueryEditingComplete: () => _dataSource.search.filter = search.search.filter,
      // onSearchButtonPressed: () => _dataSource.search.filter = search.search.filter,
      pageBuilder: buildAnimals,
    );
  }

  Widget buildAnimals(BuildContext context) {
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextButton.icon(
            icon: Icon(Icons.add),
            label: Text("Novo Reprodutor(a)"),
            onPressed: newAnimal,
            style: IconButton.styleFrom(backgroundColor: Colors.green, foregroundColor:Colors.white)
          )
        ),
        ...List.generate(_dataSource.availableRows, buildIthElement),
      ]
    ));
  }

  void newAnimal() {
    showDialog(context: context, builder: (context) {
      return SingleChildScrollView(child:  Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Column(children: [
        Row(children: [
          Expanded(child: Text(
            "Novo Reprodutor",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop())
        ]),
        BreederFormView(postSave: () {
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

    return Padding(padding: EdgeInsets.all(1.0), child: BreederTile(
      breeder: s,
      onClick: (b) => setState(() => breeder = b),
      postDelete: (b) => _dataSource.reload()
    ));
  }
}
