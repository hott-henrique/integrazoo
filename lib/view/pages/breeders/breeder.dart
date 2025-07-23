import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:integrazoo/domain/bovine/bovine.dart';
import 'package:integrazoo/domain/bovine/sex.dart';
import 'package:integrazoo/domain/reproduction/reproduction.dart';
import 'package:integrazoo/view/pages/herd/bovine.dart';
import 'package:integrazoo/view/pages/herd/tile.dart';

import 'package:isar/isar.dart';

import 'package:integrazoo/domain/reproduction/breeder.dart';
import 'package:integrazoo/view/forms/breeder/breeder.dart';


class BreederScreen extends StatefulWidget {
  final Breeder breeder;

  final VoidCallback? onClose;

  const BreederScreen({ super.key, required this.breeder, this.onClose });

  @override
  State<BreederScreen> createState() => _BreederScreen();
}

class _BreederScreen extends State<BreederScreen> {
  bool isEditing = false;
  late Breeder breeder;

  @override
  void initState() {
    super.initState();

    breeder = widget.breeder;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Row(children: [
            Expanded(child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.info)),
                // Tab(icon: Icon(Icons.analytics)),
                Tab(icon: Icon(Icons.inventory)),
              ],
            )),
            IconButton(icon: Icon(Icons.close), onPressed: widget.onClose),
          ]),
          Expanded(
            child: TabBarView(
              children: [
                tabInfo(),
                // tabAnalytics(),
                // Center(child: Text('Content for Tab 3')),
                tabInventory()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tabInventory() {
    final isar = GetIt.I<Isar>();

    final malesR = isar.artificialInseminationReproductions
        .filter()
        .breeder((q) => q.idEqualTo(breeder.id))
        .born((b) => b.sexEqualTo(Sex.male))
        .findAllSync();

    final femalesR = isar.artificialInseminationReproductions
        .filter()
        .breeder((q) => q.idEqualTo(breeder.id))
        .born((b) => b.sexEqualTo(Sex.female))
        .findAllSync();

    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Progênie", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Total", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text((femalesR.length + malesR.length).toString()),
            Text("Machos", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(malesR.length.toString()),
            Text("Fêmeas", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(femalesR.length.toString()),
          ])
        )
      ),
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Machos", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            if (malesR.isNotEmpty) bovinesFromReproductions(malesR)
            else Center(child: Text("Nenhum até o momento!"))
          ])
        )
      ),
      Card(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Fêmeas", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            if (femalesR.isNotEmpty) bovinesFromReproductions(femalesR)
            else Center(child: Text("Nenhuma até o momento!"))
          ])
        )
      ),
    ]));
  }

  Widget bovinesFromReproductions(List<ArtificialInseminationReproduction> reproductions) {
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.0,
      children: reproductions.map((r) {
        r.born.loadSync();
        return BovineTile(
          bovine: r.born.value!,
          showDelete: false,
          onClick: (b) {
            showDialog(context: context, builder: (ctx) {
              return Dialog(
                shape:  RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(4), // Use 0 for perfect square corners
                 ),
                child: BovineScreen(
                bovine: r.born.value!,
                onClose: Navigator.of(ctx).pop,
                showEditButton: false
                ),
              );
            });
          }
        );
      }).toList()
    ));
  }

  Widget tabInfo() {
    List<Widget> columnBody = List.empty(growable: true);

    columnBody.add(buildIdInfo());
    columnBody.add(buildReproductionInfo());
    columnBody.add(buildEPDInfo());
    columnBody.add(buildParentsInfo());
    columnBody.add(buildFatherGrandparentsInfo());
    columnBody.add(buildMotherGrandparentsInfo());

    if (isEditing) {
      return SingleChildScrollView(padding: EdgeInsets.all(0), child: Column(children: [
        Row(children: [
          Expanded(child: Text(
            "Atualizando Reprodutor: ${breeder.name}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => setState(() => isEditing = false))
        ]),
        BreederFormView(breeder: breeder, postSave: () {
          final isar = GetIt.instance<Isar>();

          isar.breeders.get(breeder.id).then((b) {
            setState(() {
              isEditing = false;
              breeder = b!;
            });
          });
        })
      ]));
    } else {
      return Stack(children: [
        SingleChildScrollView(padding: EdgeInsets.all(0), child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: columnBody
        )),
        Positioned(
          bottom: 16, right: 16,
          child: FloatingActionButton(
            onPressed: () => (setState(() => isEditing = true)),
            child: Icon(Icons.edit)
          )
        ),
      ]);
    }
  }

  Widget buildIdInfo() {
    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Identificação", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Nome", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(breeder.name),
          Text("Identificador", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(breeder.identifier),
        ])
      )
    );
  }

  Widget buildReproductionInfo() {
    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Reprodução", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Raça", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(breeder.breed),
          Text("Sexo", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(breeder.sex.toString()),
        ])
      )
    );
  }

  Widget buildParentsInfo() {
    final parents = breeder.parents;

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Pais", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          if (parents != null) ...[
            Text("Pai", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(parents.father ?? "-"),
            Text("Mãe", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(parents.mother ?? "-"),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text("Dados não informados.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)) ]
            ),
          ],
        ])
      )
    );
  }

  Widget buildFatherGrandparentsInfo() {
    final parents = breeder.fatherGrandParents;

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Avós Paternos", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          if (parents != null) ...[
            Text("Avô", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(parents.father ?? "-"),
            Text("Avó", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(parents.mother ?? "-"),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text("Dados não informados.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)) ]
            ),
          ],
        ])
      )
    );
  }

  Widget buildMotherGrandparentsInfo() {
    final parents = breeder.motherGrandParents;

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Avós Maternos", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          if (parents != null) ...[
            Text("Avô", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(parents.father ?? "-"),
            Text("Avó", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(parents.mother ?? "-"),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text("Dados não informados.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)) ]
            ),
          ],
        ])
      )
    );
  }

  Widget buildEPDInfo() {
    final epd = breeder.epd;

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Diferença Esperada na Progênie (DEP)", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          if (epd != null) ...[
            Text("Peso ao Nascimento (PN)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(epd.birthWeight?.toString() ?? "-"),
            Text("Peso a Desmama (PD)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(epd.weaningWeight?.toString() ?? "-"),
            Text("Peso ao Sobreano (PA)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(epd.yearlingWeight?.toString() ?? "-"),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text("Dados não informados.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)) ]
            ),
          ],
        ])
      )
    );
  }

  Widget tabAnalytics() {
    return SizedBox();
  }
}
