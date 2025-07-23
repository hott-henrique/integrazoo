import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:get_it/get_it.dart';
import 'package:integrazoo/view/pages/inseminations/artificil_insemination.dart';
import 'package:integrazoo/view/pages/natural_reproduction/natural_reproduction.dart';
import 'package:integrazoo/view/pages/treatment/treatment.dart';
import 'package:integrazoo/view/pages/vaccination/vaccine.dart';
import 'package:integrazoo/view/pages/weighing/weighing.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/finishing_reason.dart';
import 'package:integrazoo/domain/bovine/weighing.dart';
import 'package:integrazoo/domain/bovine/bovine.dart';
import 'package:integrazoo/domain/bovine/sex.dart';

import 'package:integrazoo/domain/health/treatment.dart';
import 'package:integrazoo/domain/health/vaccine.dart';

import 'package:integrazoo/domain/reproduction/reproduction.dart';
import 'package:integrazoo/domain/reproduction/reproduction_diagnostic.dart';

import 'package:integrazoo/view/pages/inseminations/tile.dart';
import 'package:integrazoo/view/pages/natural_reproduction/tile.dart';
import 'package:integrazoo/view/pages/treatment/tile.dart';
import 'package:integrazoo/view/pages/vaccination/tile.dart';
import 'package:integrazoo/view/pages/weighing/tile.dart';

import 'package:integrazoo/view/forms/bovine/bovine.dart';


class InventoryDropdownScreen extends StatefulWidget {
  final Bovine bovine;

  const InventoryDropdownScreen({ super.key, required this.bovine });

  @override
  State<InventoryDropdownScreen> createState() => InventoryDropdownScreenState();
}

class InventoryDropdownScreenState extends State<InventoryDropdownScreen> {
  late List<String> _inventoryOptions;
  late Isar isar;

  String? _selectedOption;

  @override
  void initState() {
    super.initState();

    isar = GetIt.I<Isar>();

    if (widget.bovine.sex == Sex.female) {
      _inventoryOptions = const [
        'Pesagens',
        'Montas',
        'Inseminações',
        'Vacinações',
        'Tratamentos',
      ];
    } else {
      _inventoryOptions = const [
        'Pesagens',
        'Montas',
        'Vacinações',
        'Tratamentos',
      ];
    }

    _selectedOption = _inventoryOptions.first;
  }

  Widget _buildVaccinationsContent() {
    final vaccinations = isar.vaccines.filter().bovine((b) {
      return b.earringEqualTo(widget.bovine.earring);
    }).findAllSync();

    if (vaccinations.isNotEmpty) {
      return SingleChildScrollView(child:
        Column(
          spacing: 8.0,
          children: vaccinations.map((v) => VaccineTile(
            vaccine: v,
            // showDeleteBtn: false,
            postDelete: (v) => setState(() {}),
            onClick: (v) => showDialog(context: context, barrierDismissible: false, builder: (ctx) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: VaccineScreen(vaccine: v, onClose: () => setState(Navigator.of(ctx).pop))
              );
            })
          )).toList()
        )
      );
    }

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.medical_services, size: 50, color: Colors.blueAccent),
          SizedBox(height: 10),
          Text(
            'Detalhes das Vacinações',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Aqui você poderá gerenciar e visualizar todas as vacinas aplicadas nos animais.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentsContent() {
    final treatments = isar.treatments.filter().bovine((b) {
      return b.earringEqualTo(widget.bovine.earring);
    }).findAllSync();

    if (treatments.isNotEmpty) {
      return SingleChildScrollView(child:
        Column(
          spacing: 8.0,
          children: treatments.map((t) => TreatmentTile(
            treatment: t,
            // showDeleteBtn: false,
            postDelete: (t) => setState(() {}),
            onClick: (t) => showDialog(context: context, barrierDismissible: false, builder: (ctx) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: TreatmentScreen(treatment: t, onClose: () => setState(Navigator.of(ctx).pop))
              );
            })
          )).toList()
        )
      );
    }

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.healing, size: 50, color: Colors.green),
          SizedBox(height: 10),
          Text(
            'Detalhes dos Tratamentos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Aqui você poderá visualizar todas as tratamento e medicamentos.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Função para lidar com a seleção de 'Montas'
  Widget _buildMatingContent() {
    late List<NaturalReproduction> naturalReproductions;

    if (widget.bovine.sex == Sex.female) {
      naturalReproductions = isar.naturalReproductions.filter().cow((b) {
        return b.earringEqualTo(widget.bovine.earring);
      }).findAllSync();
    } else {
      naturalReproductions = isar.naturalReproductions.filter().bull((b) {
        return b.earringEqualTo(widget.bovine.earring);
      }).findAllSync();
    }

    if (naturalReproductions.isNotEmpty) {
      return SingleChildScrollView(child:
        Column(
          spacing: 8.0,
          children: naturalReproductions.map((r) => NaturalReproductionTile(
            insemination: r,
            // showDeleteBtn: false,
            postDelete: (r) => setState(() {}),
            onClick: (r) => showDialog(context: context, barrierDismissible: false, builder: (ctx) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: NaturalReproductionScreen(reproduction: r, onClose: () => setState(Navigator.of(ctx).pop))
              );
            })
          )).toList()
        )
      );
    }

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pets, size: 50, color: Colors.brown),
          SizedBox(height: 10),
          Text(
            'Detalhes das Montas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Aqui você poderá visualizar todas as montas.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInseminationContent() {
    late List<ArtificialInseminationReproduction> inseminations;

    if (widget.bovine.sex == Sex.female) {
      inseminations = isar.artificialInseminationReproductions.filter().cow((b) {
        return b.earringEqualTo(widget.bovine.earring);
      }).findAllSync();
    } else {
      return SizedBox();
    }

    if (inseminations.isNotEmpty) {
      return SingleChildScrollView(child:
        Column(
          spacing: 8.0,
          children: inseminations.map((r) => ArtificialInseminationTile(
            insemination: r,
            // showDeleteBtn: false,
            postDelete: (i) => setState(() {}),
            onClick: (i) => showDialog(context: context, barrierDismissible: false, builder: (ctx) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: ArtificialInseminationScreen(insemination: i, onClose: () => setState(Navigator.of(ctx).pop))
              );
            })
          )).toList()
        )
      );
    }

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.science, size: 50, color: Colors.purple),
          SizedBox(height: 10),
          Text(
            'Detalhes das Inseminações',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Aqui você poderá visualizar todas as inseminações artificiais.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeighingContent() {
    final weighings = isar.weighings.filter().bovine((b) {
      return b.earringEqualTo(widget.bovine.earring);
    }).findAllSync();

    if (weighings.isNotEmpty) {
      return SingleChildScrollView(child:
        Column(
          spacing: 8.0,
          children: weighings.map((w) => WeighingTile(
            weighing: w,
            // showDeleteBtn: false,
            postDelete: (b) => setState(() {}),
            onClick: (w) => showDialog(context: context, barrierDismissible: false, builder: (ctx) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: WeighingScreen(weighing: w, onClose: () => setState(Navigator.of(ctx).pop))
              );
            })
          )).toList()
        ),
      );
    }

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.scale, size: 50, color: Colors.orange),
          SizedBox(height: 10),
          Text(
            'Detalhes das Pesagens',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Aqui você poderá visualizar todas as pesagens desse animal.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCurrentContent() {
    switch (_selectedOption) {
      case 'Vacinações':
        return _buildVaccinationsContent();
      case 'Tratamentos':
        return _buildTreatmentsContent();
      case 'Montas':
        return _buildMatingContent();
      case 'Inseminações':
        return _buildInseminationContent();
      case 'Pesagens':
        return _buildWeighingContent();
      default:
        return const Center(
          child: Text(
            'Selecione uma opção do inventário',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedOption,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.teal, size: 30),
              elevation: 16,
              style: const TextStyle(color: Colors.black, fontSize: 18),
              onChanged: (String? newValue) => setState(() => _selectedOption = newValue),
              items: _inventoryOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(child: _getCurrentContent()),
      ],
    );
  }
}

class BovineScreen extends StatefulWidget {
  final Bovine bovine;
  final bool showEditButton;

  final VoidCallback? onClose;

  const BovineScreen({ super.key, required this.bovine, this.showEditButton = true, this.onClose });

  @override
  State<BovineScreen> createState() => _BovineScreen();
}

class _BovineScreen extends State<BovineScreen> {
  bool isEditing = false;
  late Bovine bovine;

  @override
  void initState() {
    super.initState();

    bovine = widget.bovine;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Row(children: [
            Expanded(child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.info)),
                Tab(icon: Icon(Icons.analytics)),
                Tab(icon: Icon(Icons.inventory)),
              ],
            )),
            IconButton(icon: Icon(Icons.close), onPressed: widget.onClose),
          ]),
          Expanded(
            child: TabBarView(
              children: [
                tabInfo(),
                tabAnalytics(),
                tabInventory()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tabInventory() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InventoryDropdownScreen(bovine: widget.bovine)
    );
  }

  Widget tabInfo() {
    List<Widget> columnBody = List.empty(growable: true);

    columnBody.add(buildIdInfo());
    columnBody.add(buildReproductionInfo());
    columnBody.add(buildParentsInfo());
    columnBody.add(buildBirthInfo());
    columnBody.add(buildEntryInfo());
    columnBody.add(buildWeaningInfo());
    columnBody.add(buildYearlingInfo());
    columnBody.add(buildFinishInfo());

    if (isEditing) {
      inspect(bovine);

      return SingleChildScrollView(padding: EdgeInsets.all(0), child: Column(children: [
        Row(children: [
          Expanded(child: Text(
            "Editando Animal: #${bovine.earring}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          IconButton(icon: Icon(Icons.close), onPressed: () => setState(() => isEditing = false))
        ]),
        BovineFormView(bovine: bovine, postSave: () {
          final isar = GetIt.instance<Isar>();

          isar.bovines.get(bovine.earring).then((b) {
            setState(() {
              isEditing = false;
              bovine = b!;
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
        if (widget.showEditButton)
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
          Text("Brinco", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(bovine.earring.toString()),
          Text("Nome", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(bovine.name ?? "-"),
        ])
      )
    );
  }

  Widget buildReproductionInfo() {
    final breederQuestion = bovine.sex == Sex.female ? "Matriz" : "Reprodutor";
    final breederAnswer = bovine.isBreeder ? "Positivo" : "Negativo";

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Reprodução", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Sexo", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(bovine.sex.toString()),
          Text("Raça", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(bovine.breed),
          Text(breederQuestion, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(breederAnswer),
        ])
      )
    );
  }

  Widget buildParentsInfo() {
    bovine.ensureLoadedSync();

    late String father;
    late String mother;

    if (bovine.artificialInsemination.value == null && bovine.naturalReproduction.value == null) {
      return SizedBox();
    }

    if (bovine.artificialInsemination.value != null) {
      father = bovine.artificialInsemination.value!.breeder.value!.toString();
      mother = bovine.artificialInsemination.value!.cow.value!.toString();
    } else if (bovine.naturalReproduction.value != null) {
      father = bovine.naturalReproduction.value!.bull.value!.toString();
      mother = bovine.naturalReproduction.value!.cow.value!.toString();
    }

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Pais", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Pai", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(father),
          Text("Mãe", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(mother),
        ])
      )
    );
  }

  Widget buildWeightGainInfo() {
    return Card(
      color: Colors.white,
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Ganho de Peso", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Total", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("${bovine.totalWG()?.toStringAsFixed(2) ?? "-"} Kg/dia"),
          Text("Entre Nascimento e Desmama", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("${bovine.birthWeaningWG()?.toStringAsFixed(2) ?? "-"} Kg/dia"),
          Text("Entre Desmama e Sobreano", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("${bovine.weaningYearlingWG()?.toStringAsFixed(2) ?? "-"} Kg/dia"),
          Text("Entre Sobreano e Abate", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("${bovine.yearlingFinishWG()?.toStringAsFixed(2) ?? "-"} Kg/dia"),
        ])
      )
    );
  }

  Widget buildBirthInfo() {
    final birth = bovine.birth;

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Nascimento", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          if (birth.value != null) ...[
            Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(birth.value!.date)),
            Text("Peso", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(birth.value!.weight.toString()),
            Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(birth.value!.observation ?? "-"),
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

  Widget buildEntryInfo() {
    final entry = bovine.entry.value;

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Entrada", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          if (entry != null) ...[
            Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(entry.date)),
            Text("Peso", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(entry.weight.toString()),
            Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(entry.observation ?? "-"),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text("Dados não informados.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)) ]
            ),
          ]
        ])
      )
    );
  }

  Widget buildWeaningInfo() {
    final weaning = bovine.weaning;

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Desmame", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          if (weaning.value != null) ...[
            Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(weaning.value!.date)),
            Text("Peso", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(weaning.value!.weight.toString()),
            Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(weaning.value!.observation ?? "-"),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text("Dados não informados.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)) ]
            ),
          ]
        ])
      )
    );
  }

  Widget buildYearlingInfo() {
    final yearling = bovine.yearling.value;

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Sobreano", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          if (yearling != null) ...[
            Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(yearling.date)),
            Text("Peso", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(yearling.weight.toStringAsFixed(2)),
            Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(yearling.observation ?? "-"),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text("Dados não informados.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)) ]
            ),
          ]
        ])
      )
    );
  }
  Widget buildFinishInfo() {
    final finish = bovine.finish.value;

    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Finalização", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          if (bovine.finishingReason != FinishingReason.notYet) ...[
            Text("Razão", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(bovine.finishingReason.toString()),
            Text("Data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(DateFormat.yMd("pt_BR").format(finish!.date)),
            Text("Peso", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(finish.weight.toString()),
            Text("Observação", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(finish.observation ?? "-"),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text("Dados não informados.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)) ]
            ),
          ]
        ])
      )
    );
  }

  Widget tabAnalytics() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4.0,
        children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.65, child: Card(
          color: Colors.white,
          child: Column(children: [
            Text("Peso", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Expanded(child: weightEvolution())
          ])
        )),
        buildWeightGainInfo(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.35, child: Card(
          color: Colors.white,
          child: Padding(padding: EdgeInsets.all(8.0), child: Column(children: [
            Text("Taxa de Prenhez - Inseminações", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Expanded(child: buildPregnancySuccessRate()),
          ]))
        )),
      ])
    );
  }

  Widget buildPregnancySuccessRate() {
    final isar = GetIt.I<Isar>();

    final positivesN = isar.naturalReproductions.filter()
                                            .cow((c) => c.earringEqualTo(bovine.earring))
                                            .diagnosticEqualTo(ReproductionDiagnostic.positive).countSync();

    final positives = positivesN + isar.artificialInseminationReproductions.filter()
                                            .cow((c) => c.earringEqualTo(bovine.earring))
                                            .diagnosticEqualTo(ReproductionDiagnostic.positive).countSync();


    final negativesN = isar.naturalReproductions.filter()
                                            .cow((c) => c.earringEqualTo(bovine.earring))
                                            .diagnosticEqualTo(ReproductionDiagnostic.negative).countSync();

    final negatives = negativesN + isar.artificialInseminationReproductions.filter()
                                            .cow((c) => c.earringEqualTo(bovine.earring))
                                            .diagnosticEqualTo(ReproductionDiagnostic.negative).countSync();


    if (positives + negatives == 0) {
      return Center(child: Text("Nenhum diagnóstico de prenhez até o momento."));
    }

    final successRate = (positives / (positives + negatives)) * 100;
    final failureRate = (negatives / (positives + negatives)) * 100;

    final chart = PieChart(
      PieChartData(sections: [
        PieChartSectionData(
          value: successRate,
          title: "${successRate.toStringAsFixed(2)}% ($positives)",
          color: Colors.green
        ),
        PieChartSectionData(
          value: failureRate,
          title: "${failureRate.toStringAsFixed(2)}% ($negatives)",
          color: Colors.red
        ),
      ])
    );

    return Column(spacing: 4.0, children: [
      Expanded(child: chart),
      Row(spacing: 2.0, children: [
        SizedBox(width: 32, height: 32, child: Container(color: Colors.green)),
        Text("Positivo"),
        SizedBox(width: 16.0),
        SizedBox(width: 32, height: 32, child: Container(color: Colors.red)),
        Text("Negativo"),
      ]),
    ]);
  }

  Widget weightEvolution() {
    bovine.ensureLoadedSync();

    var weights = bovine.weighings.toList();

    weights.sort((w1, w2) => w1.date.compareTo(w2.date));

    if (weights.isEmpty) {
      return Center(child: Text("Nada para ver aqui"));
    }

    var maxWeight = weights.reduce((currentMax, nextItem) =>
        nextItem.weight > currentMax.weight ? nextItem : currentMax).weight.ceilToDouble();

    maxWeight = (maxWeight / 5.0).ceilToDouble() * 5.0;

    maxWeight = max(maxWeight, 75) + 25;

    final plot =  LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        lineTouchData: LineTouchData(touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedBarSpots) {
            return touchedBarSpots.map((spot) {
              final obs = weights[spot.x.toInt()].observation;
              if (obs == null) {
                return LineTooltipItem(spot.y.toStringAsFixed(2), TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ));
              }

              return LineTooltipItem("$obs - ${spot.y.toStringAsFixed(2)} kg", TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ));
            }).toList();
          }
        )),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles : const AxisTitles(sideTitles: SideTitles(reservedSize: 44, showTitles: true)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 86,
              interval: 1,
              getTitlesWidget: (idx, _) {
                if (idx < weights.length) {
                  return Column(children: [
                    Spacer(flex: 4),
                    Expanded(flex: 12, child:
                    Transform.rotate(
                      angle: pi / 4,
                      child: Text(DateFormat.yMd("pt_BR").format(weights[idx.toInt()].date))
                    ))
                  ]);
                }
                return Text("");
              }
            )
          )
        ),
        borderData: FlBorderData(show: true),
        minX: 0,
        maxX: min(weights.length + 2, 10),
        minY: 0,
        maxY: maxWeight,
        lineBarsData: [
          LineChartBarData(
            spots: weights.indexed.map((record) {
                double el = record.$2.weight;
                return FlSpot(record.$1.toDouble(), el);
              }).toList(),
            color: Colors.blue,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: Colors.blue.withValues(alpha: 0.3)),
          ),
        ],
      ),
    );

    return Padding(padding: EdgeInsets.symmetric(horizontal:8.0), child: plot);
  }
}
