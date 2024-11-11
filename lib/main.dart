import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import 'package:integrazoo/persistence/database_connector.dart';

import 'package:integrazoo/base.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* INFO: Comment this line when not testing database creation. */
  // await deleteDatabase(join(await getDatabasesPath(), 'integrazoo.sqlite'));

  await openDatabase(
    join(await getDatabasesPath(), 'integrazoo.sqlite'),
    version: 1,
    onConfigure: (db) {
      db.execute('PRAGMA foreign_keys = 1;');
    },
    onCreate: (db, version) {
      DatabaseConnector.connectToDatabase(db);
      DatabaseConnector.onCreate(db, version);
    },
    onOpen: (db) {
      DatabaseConnector.connectToDatabase(db);
    },
    onUpgrade: (db, oldVersion, newVersion) {},
    onDowngrade: (db, oldVersion, newVersion) {},
  );

  runApp(MaterialApp(
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    home: const IntegrazooApp(),
    supportedLocales: const [Locale('pt', 'BR')],
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.green[400]),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))))
        )
      )
    )
  ));
}

class IntegrazooApp extends StatefulWidget {
  const IntegrazooApp({super.key});

  @override
  State<StatefulWidget> createState() => _IntegrazooAppState();
}

class _IntegrazooAppState extends State<IntegrazooApp> {
  bool isDBLoaded = false;

  @override
  Widget build(BuildContext context) {
    return const IntegrazooBaseApp(body: Center(child: Text('Testing branch protection again!')));
  }
}
