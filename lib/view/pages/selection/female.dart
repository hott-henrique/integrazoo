import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

import 'package:integrazoo/view/components/pagination/base/paginator.dart';
import 'package:integrazoo/view/components/pagination/data_loaders/female_selection_data_loader.dart';
import 'package:integrazoo/view/forms/reproduction/artificial_insemination.dart';



class FemaleSelectionPaginationView extends StatefulWidget {
  const FemaleSelectionPaginationView({ super.key });

  @override
  State<FemaleSelectionPaginationView> createState() => _FemaleSelectionPaginationView();
}

class _FemaleSelectionPaginationView extends State<FemaleSelectionPaginationView> {
  late FemaleSelectionDataLoader _dataSource;

  late List<int> selectedFemales;

  @override
  void initState() {
    super.initState();

    selectedFemales = List.empty(growable: true);

    _dataSource = FemaleSelectionDataLoader();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Paginator(
        loader: _dataSource,
        // filtersDialog: _buildFiltersDialog(),
        // queryHintText: "Digite aqui para filtrar por nome ou brinco.",
        // onQueryChanged: _dataSource.setQuery,
        // onQueryEditingComplete: () => _dataSource.search.filter = search.search.filter,
        // onSearchButtonPressed: () => _dataSource.search.filter = search.search.filter,
        pageBuilder: buildAnimals,
      ),
      if (selectedFemales.isNotEmpty)
        Positioned(
          bottom: 16, right: 16,
          child: FloatingActionButton(
            onPressed: () async {
              await showDialog(context: context, builder:(ctx) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(8),
                  child: Card(child:
                    Column(children: [
                      Row(children: [
                        Expanded(child: Text("Inseminando Seleção",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center
                        )),
                        IconButton(icon: Icon(Icons.close), onPressed:  Navigator.of(context).pop)
                      ]),
                      ArtificialInseminationFormView(
                        preSelectedBovines: selectedFemales,
                        postSave: Navigator.of(context).pop
                      )
                    ])
                  )
                );
              });
              setState(() => selectedFemales.clear());
            },
            child: Icon(Icons.arrow_right)
          )
        ),
    ]);
  }

  Widget buildAnimals(BuildContext context) {
    return DataTable2(
        columns: [
          DataColumn(label: Text("Animal")),
          DataColumn(label: Text("Peso ao Nascimento (Kg)")),
          DataColumn(label: Text("Peso a Desmama (Kg)")),
          DataColumn(label: Text("Peso ao Sobreano (Kg)")),
          DataColumn(label: Text("IPP (Meses)")),
          DataColumn(label: Text("Repetência")),
        ],
        rows: List.generate(_dataSource.availableRows, buildIthElement)
      );
  }

  DataRow buildIthElement(int i) {
    if (_dataSource.isLoading) {
      return const DataRow2(cells: [
        DataCell(CircularProgressIndicator()),
        DataCell(CircularProgressIndicator()),
        DataCell(CircularProgressIndicator()),
        DataCell(CircularProgressIndicator()),
        DataCell(CircularProgressIndicator()),
        DataCell(CircularProgressIndicator()),
      ]);
    }

    final s = _dataSource.getElement(i);
    final ageFirstBirth = s.ageFirstBirth();
    return DataRow2(
      cells: [
        DataCell(Text(s.toString())),
        DataCell(Text(s.birth.value?.weight.toStringAsFixed(2) ?? "-")),
        DataCell(Text(s.weaning.value?.weight.toStringAsFixed(2) ?? "-")),
        DataCell(Text(s.yearling.value?.weight.toStringAsFixed(2) ?? "-")),
        DataCell(Text(ageFirstBirth != null ? (ageFirstBirth.inDays / 30).toStringAsFixed(2) : "-")),
        DataCell(Text(s.reproductionPerformance().toString())),
      ],
      selected: selectedFemales.contains(s.earring),
      onSelectChanged:(selected) {
        if (selected == null) return;

        setState(() {
          if (selected) {
            selectedFemales.add(s.earring);
          } else {
            selectedFemales.remove(s.earring);
          }
        });
      }
    );
  }
}
