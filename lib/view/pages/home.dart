import 'package:flutter/material.dart';
import 'package:integrazoo/view/pages/analysis/analysis_page.dart';
import 'package:integrazoo/view/pages/export/export_page.dart';

import 'package:integrazoo/view/pages/herd/pagination.dart';
import 'package:integrazoo/view/pages/breeders/pagination.dart';
import 'package:integrazoo/view/pages/inseminations/pagination.dart';
import 'package:integrazoo/view/pages/natural_reproduction/pagination.dart';
import 'package:integrazoo/view/pages/selection/female.dart';
import 'package:integrazoo/view/pages/treatment/pagination.dart';
import 'package:integrazoo/view/pages/vaccination/pagination.dart';
import 'package:integrazoo/view/pages/weighing/pagination.dart';


class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Row(children: [
        Padding(
          padding: EdgeInsets.all(1.0),
          child: Card(
            color: Colors.white,
            child: SizedBox(
              width: 300, height: MediaQuery.of(context).size.height,
              child: buildNavigationOptions()
            )
          )
        ),
        Expanded(child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Card(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: buildSelectedPage()
            )
          )
        )),
      ])
    );
  }

  Widget buildSelectedPage() {
    switch (selectedPage) {
      case "Relatório":
        return Padding(
          padding: EdgeInsets.all(1.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: AnalysisPage()
          )
        );

      case "Rebanho":
        return Padding(
          padding: EdgeInsets.all(1.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BovinesPaginationView()
          )
        );

      case "Pesagem":
        return Padding(
          padding: EdgeInsets.all(1.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: WeighingsPaginationView()
          )
        );

      case "Selecionar Matrizes":
        return Padding(
          padding: EdgeInsets.all(1.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: FemaleSelectionPaginationView()
          )
        );

      case "Reprodutores":
        return Padding(
          padding: EdgeInsets.all(1.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BreedersPaginationView()
          )
        );

      case "Montas":
        return Padding(
          padding: EdgeInsets.all(1.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: NaturalReproductionsPaginationView()
          )
        );

      case "Inseminações":
        return Padding(
          padding: EdgeInsets.all(1.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ArtificialInseminationsPaginationView()
          )
        );

      case "Vacinação":
        return Padding(
          padding: EdgeInsets.all(1.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: VaccinationsPaginationView()
          )
        );

      case "Tratamentos":
        return Padding(
          padding: EdgeInsets.all(1.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TreatmentsPaginationView()
          )
        );

      case "Exportar Dados":
        return Padding(
          padding: EdgeInsets.all(1.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ExportPage()
          )
        );

      default:
        return SizedBox();
    }
  }
  Widget buildNavigationOptions() {
    final selectedColor = Colors.grey;
    final textSelectedColor = Colors.black;

    return Padding(padding: EdgeInsets.all(4.0), child: Column(children: [
      ListTile(
        title: const Text("Relatório"),
        onTap: () => setState(() => selectedPage = "Relatório"),
        selected: selectedPage == "Relatório",
        selectedTileColor: selectedColor,
        selectedColor: textSelectedColor
      ),
      ExpansionTile(
        title: const Text("Rebanho"),
        children: [
        ListTile(
          title: const Text("Animais"),
          onTap: () => setState(() => selectedPage = "Rebanho"),
          selected: selectedPage == "Rebanho",
          selectedTileColor: selectedColor,
          selectedColor: textSelectedColor
        ),
        ListTile(
          title: const Text("Pesagem"),
          onTap: () => setState(() => selectedPage = "Pesagem"),
          selected: selectedPage == "Pesagem",
          selectedTileColor: selectedColor,
          selectedColor: textSelectedColor
        )
      ]),
      ExpansionTile(
        title: const Text("Reprodução"),
        children: [
          ListTile(
            title: const Text("Reprodutores"),
            onTap: () => setState(() => selectedPage = "Reprodutores"),
            selected: selectedPage == "Reprodutores",
            selectedTileColor: selectedColor,
            selectedColor: textSelectedColor
          ),
          ListTile(
            title: const Text("Montas"),
            onTap: () => setState(() => selectedPage = "Montas"),
            selected: selectedPage == "Montas",
            selectedTileColor: selectedColor,
            selectedColor: textSelectedColor
          ),
          ListTile(
            title: const Text("Selecionar Matrizes"),
            onTap: () => setState(() => selectedPage = "Selecionar Matrizes"),
            selected: selectedPage == "Selecionar Matrizes",
            selectedTileColor: selectedColor,
            selectedColor: textSelectedColor
          ),
          ListTile(
            title: const Text("Inseminações"),
            onTap: () => setState(() => selectedPage = "Inseminações"),
            selected: selectedPage == "Inseminações",
            selectedTileColor: selectedColor,
            selectedColor: textSelectedColor
          ),
        ]
      ),
      ExpansionTile(
        title: const Text("Saúde"),
        children: [
          ListTile(
            title: const Text("Tratamentos"),
            onTap: () => setState(() => selectedPage = "Tratamentos"),
            selected: selectedPage == "Tratamentos",
            selectedTileColor: selectedColor,
            selectedColor: textSelectedColor
          ),
          ListTile(
            title: const Text("Vacinação"),
            onTap: () => setState(() => selectedPage = "Vacinação"),
            selected: selectedPage == "Vacinação",
            selectedTileColor: selectedColor,
            selectedColor: textSelectedColor
          ),
        ]
      ),
      ListTile(
        title: const Text("Dados"),
        onTap: () => setState(() => selectedPage = "Exportar Dados"),
        selected: selectedPage == "Exportar Dados",
        selectedTileColor: selectedColor,
        selectedColor: textSelectedColor
      ),
    ]));
  }
}
