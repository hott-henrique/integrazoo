import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:integrazoo/domain/bovine/weighing.dart';

import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:get_it/get_it.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';

import 'package:integrazoo/domain/reproduction/breeder.dart';
import 'package:integrazoo/domain/reproduction/reproduction.dart';

import 'package:integrazoo/domain/health/treatment.dart';
import 'package:integrazoo/domain/health/vaccine.dart';

import 'package:integrazoo/view/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [
      BovineSchema, WeighingSchema,
      BreederSchema, ArtificialInseminationReproductionSchema, NaturalReproductionSchema,
      VaccineSchema, TreatmentSchema
    ],
    directory: dir.path,
    name: "BANCO_DE_DADOS_INTEGRAZOO_BOVINO_CORTE"
  );

  GetIt.instance.registerSingleton<Isar>(isar);

  performMigrationIfNeeded(isar);

  runApp(const Application());
}

Future<void> performMigrationIfNeeded(Isar isar) async {
  final prefs = await SharedPreferences.getInstance();

  final currentVersion = prefs.getInt('version') ?? 1;

  print("VERSION: $currentVersion");

  switch(currentVersion) {
    case 1:
      await migrateV1ToV2(isar);
      break;

    case 2:
      // If the version is not set (new installation) or already 2, we do not need to migrate
      break;

    default:
      throw Exception('Unknown version: $currentVersion');
  }

  await prefs.setInt('version', 1);
}

Future<void> migrateV1ToV2(Isar isar) async {
  final isar = GetIt.I<Isar>();
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        canvasColor: Color.fromRGBO(199, 233, 192, 1.0),
        textButtonTheme: TextButtonThemeData(style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
          shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0))),
        )),
        iconButtonTheme: IconButtonThemeData(style:  ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.black),
          shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0))),
        )),
        cardTheme: CardThemeData(margin: EdgeInsets.all(1.0))
      ),
      supportedLocales: [ Locale('pt', 'BR') ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HomePage()
    );
  }
}
