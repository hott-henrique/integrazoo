import 'dart:async';

import 'package:excel/excel.dart' as ex;
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:integrazoo/domain/bovine/birth.dart';
import 'package:integrazoo/domain/bovine/bovine.dart';
import 'package:integrazoo/domain/bovine/finishing_reason.dart';
import 'package:integrazoo/domain/bovine/weighing.dart';
import 'package:integrazoo/domain/health/treatment.dart';
import 'package:integrazoo/domain/health/vaccine.dart';
import 'package:integrazoo/domain/reproduction/breeder.dart';
import 'package:integrazoo/domain/reproduction/reproduction.dart';
import 'package:isar/isar.dart';


class ExportPage extends StatefulWidget {
  const ExportPage({ super.key });

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Usado para garantir rolagem se o conteúdo for muito grande
      padding: const EdgeInsets.all(16.0),
      child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ocupa apenas o espaço necessário
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
            children: [
              const Text(
                "Exportar Dados",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                "Converta e exporte seus dados para uma planilha Excel (.xlsx).",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Seção do Ícone e Texto
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.green.shade200, width: 1),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.description, // Ícone de planilha (substituto para FileSpreadsheet)
                      size: 64,
                      color: Colors.green.shade500,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Dados prontos para a sua planilha!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Formato: Microsoft Excel (.xlsx)",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              ElevatedButton.icon(
                onPressed: () async {
                  final dir = await getDirectoryPath();

                  if (dir == null) {
                    return;
                  }

                  final exportFut = export(dir);

                  if (!context.mounted) {
                    return;
                  }

                  showDialog(context: context, builder:(ctx) {
                    exportFut.then(Navigator.of(ctx).pop);
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      child: PopScope(
                        canPop: false,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Keep column size minimal
                            children: const [
                              CircularProgressIndicator(), // A spinning loader
                              SizedBox(height: 20), // Spacing between loader and text
                              Text(
                                "Aguarde, exportando dados, isso pode levar algum tempo.",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }, barrierDismissible: false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5,
                ),
                icon: const Icon(Icons.download, size: 24),
                label: const Text(
                  "Exportar Planilha",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "A exportação pode levar alguns segundos dependendo do volume de dados.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
    );
  }

  Future<void> export(String dir) async {
    var excel = ex.Excel.createExcel();

    await Future.delayed(Duration(seconds: 30));

    excel.delete("Sheet1");

    exportBovines(excel);
    exportBirths(excel);
    exportEntry(excel);
    exportWeanings(excel);
    exportYearling(excel);
    exportFinish(excel);
    exportBreeders(excel);
    exportTreatments(excel);
    exportVaccines(excel);
    exportNaturalReproductions(excel);
    exportInseminations(excel);

    final now = DateTime.now();

    final fileName = "$dir/integrazoo_dados_${now.day}_${now.month}_${now.year}.xlsx";

    final bytes = excel.save();

    final XFile file = XFile.fromData(
      Uint8List.fromList(bytes!),
      mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', // XLSX MIME type
    );

    try {
      // Write the file to the chosen path
      await file.saveTo(fileName);
    } catch (e) {
      print('Error saving file: $e');
    }

    print("Exported!");

    Future.value();
  }

  void exportBovines(ex.Excel excel) async {
    ex.Sheet bovinesSheet = excel["Animais"];

    final isar = GetIt.I<Isar>();

    final count = isar.bovines.countSync();

    bovinesSheet.appendRow(Bovine.asHeader());

    for (var i = 0; i < count; i++) {
      final bovines = isar.bovines.where().offset(i * 25).limit(25).findAllSync();

      for (final b in bovines) {
        bovinesSheet.appendRow(b.asRow());
      }
    }
  }

  void exportBirths(ex.Excel excel) async {
    ex.Sheet sheet = excel["Partos"];

    final isar = GetIt.I<Isar>();

    final count = isar.bovines.filter().not().birthIsNull().countSync();

    sheet.appendRow(Bovine.asBirthHeader());

    for (var i = 0; i < count; i++) {
      final records = isar.bovines.filter().not().birthIsNull().offset(i * 25).limit(25).findAllSync();

      for (final r in records) {
        sheet.appendRow(r.asBirthRow());
      }
    }
  }

  void exportWeanings(ex.Excel excel) async {
    ex.Sheet sheet = excel["Desmames"];

    final isar = GetIt.I<Isar>();

    final count = isar.bovines.filter().not().birthIsNull().countSync();

    sheet.appendRow(Bovine.asWeaningHeader());

    for (var i = 0; i < count; i++) {
      final records = isar.bovines.filter().not().birthIsNull().offset(i * 25).limit(25).findAllSync();

      for (final r in records) {
        sheet.appendRow(r.asWeaningRow());
      }
    }
  }

  void exportYearling(ex.Excel excel) async {
    ex.Sheet sheet = excel["Sobreano"];

    final isar = GetIt.I<Isar>();

    final count = isar.bovines.filter().not().yearlingIsNull().countSync();

    sheet.appendRow(Bovine.asYearlingHeader());

    for (var i = 0; i < count; i++) {
      final records = isar.bovines.filter().not().yearlingIsNull().offset(i * 25).limit(25).findAllSync();

      for (final r in records) {
        sheet.appendRow(r.asYearlingRow());
      }
    }
  }

  void exportFinish(ex.Excel excel) async {
    ex.Sheet sheet = excel["Finalização"];

    final isar = GetIt.I<Isar>();

    final count = isar.bovines.filter().finishingReasonEqualTo(FinishingReason.death)
                                       .or()
                                       .finishingReasonEqualTo(FinishingReason.slaughter)
                                       .or()
                                       .finishingReasonEqualTo(FinishingReason.sell)
                                       .or()
                                       .finishingReasonEqualTo(FinishingReason.notYet).countSync();

    sheet.appendRow(Bovine.asFinishHeader());

    for (var i = 0; i < count; i++) {
      final records = isar.bovines.filter().finishingReasonEqualTo(FinishingReason.death)
                                           .or()
                                           .finishingReasonEqualTo(FinishingReason.slaughter)
                                           .or()
                                           .finishingReasonEqualTo(FinishingReason.sell)
                                           .or()
                                           .finishingReasonEqualTo(FinishingReason.notYet).offset(i * 25).limit(25).findAllSync();

      for (final r in records) {
        sheet.appendRow(r.asFinishRow());
      }
    }
  }

  void exportEntry(ex.Excel excel) async {
    ex.Sheet sheet = excel["Entradas"];

    final isar = GetIt.I<Isar>();

    final count = isar.bovines.filter().not().entryIsNull().countSync();

    sheet.appendRow(Bovine.asEntryHeader());

    for (var i = 0; i < count; i++) {
      final records = isar.bovines.filter().not().entryIsNull().offset(i * 25).limit(25).findAllSync();

      for (final r in records) {
        sheet.appendRow(r.asEntryRow());
      }
    }
  }

  void exportNaturalReproductions(ex.Excel excel) async {
    ex.Sheet sheet = excel["Montas"];

    final isar = GetIt.I<Isar>();

    final count = isar.naturalReproductions.countSync();

    sheet.appendRow(NaturalReproduction.asHeader());

    for (var i = 0; i < count; i++) {
      final records = isar.naturalReproductions.where().offset(i * 25).limit(25).findAllSync();
      for (final r in records) {
        sheet.appendRow(r.asRow());
      }
    }
  }

  void exportInseminations(ex.Excel excel) async {
    ex.Sheet sheet = excel["Inseminações"];

    final isar = GetIt.I<Isar>();

    final count = isar.artificialInseminationReproductions.countSync();

    sheet.appendRow(ArtificialInseminationReproduction.asHeader());

    for (var i = 0; i < count; i++) {
      final records = isar.artificialInseminationReproductions.where().offset(i * 25).limit(25).findAllSync();
      for (final r in records) {
        sheet.appendRow(r.asRow());
      }
    }
  }

  void exportBreeders(ex.Excel excel) async {
    ex.Sheet sheet = excel["Reprodutores"];

    final isar = GetIt.I<Isar>();

    final count = isar.breeders.countSync();

    sheet.appendRow(Breeder.asHeader());

    for (var i = 0; i < count; i++) {
      final records = isar.breeders.where().offset(i * 25).limit(25).findAllSync();
      for (final r in records) {
        sheet.appendRow(r.asRow());
      }
    }
  }

  void exportWeighings(ex.Excel excel) async {
    ex.Sheet sheet = excel["Pesagens"];

    final isar = GetIt.I<Isar>();

    final count = isar.weighings.countSync();

    sheet.appendRow(Weighing.asHeader());

    for (var i = 0; i < count; i++) {
      final records = isar.weighings.where().offset(i * 25).limit(25).findAllSync();
      for (final r in records) {
        sheet.appendRow(r.asRow());
      }
    }
  }

  void exportTreatments(ex.Excel excel) async {
    ex.Sheet sheet = excel["Tratamentos"];

    final isar = GetIt.I<Isar>();

    final count = isar.treatments.countSync();

    sheet.appendRow(Treatment.asHeader());

    for (var i = 0; i < count; i++) {
      final records = isar.treatments.where().offset(i * 25).limit(25).findAllSync();
      for (final r in records) {
        sheet.appendRow(r.asRow());
      }
    }
  }

  void exportVaccines(ex.Excel excel) async {
    ex.Sheet sheet = excel["Vacinações"];

    final isar = GetIt.I<Isar>();

    final count = isar.vaccines.countSync();

    sheet.appendRow(Vaccine.asHeader());

    for (var i = 0; i < count; i++) {
      final records = isar.vaccines.where().offset(i * 25).limit(25).findAllSync();
      for (final r in records) {
        sheet.appendRow(r.asRow());
      }
    }
  }
}
