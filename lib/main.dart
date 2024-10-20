import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:integrazoo/base.dart';
import 'package:integrazoo/dairy_cattle_subsystem/dairy_cattle_subsystem.dart';


class DatabaseConnector {
    static final DatabaseConnector _singleton = DatabaseConnector._internal();

    static Database? db;
    static bool _isDBOpened = false;

    factory DatabaseConnector() {
        return _singleton;
    }

    DatabaseConnector._internal();

    static connectToDatabase(Database db) {
        _isDBOpened = true;
        DatabaseConnector.db = db;
    }

    static isConnected() => DatabaseConnector._isDBOpened;

    static onCreate(Database db, int version) {
        DairyCattleSubsystem.onDatabaseCreate(db, version);
    }
}


void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    /* INFO: Comment this line when not testing database creation. */
    await deleteDatabase(join(await getDatabasesPath(), 'integrazoo.sqlite'));

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
        onUpgrade:(db, oldVersion, newVersion) {
        },
        onDowngrade:(db, oldVersion, newVersion) {
        },
    );

    runApp(MaterialApp(
        localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
        ],
        home: const IntegrazooApp(),
        supportedLocales: const [ Locale('pt', 'BR') ],
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green))
    ));
}

class IntegrazooApp extends StatefulWidget {
    const IntegrazooApp({ super.key });

    @override
    State<StatefulWidget> createState() => _IntegrazooAppState();

}

class _IntegrazooAppState extends State<IntegrazooApp> {
    bool isDBLoaded = false;

    @override
    Widget build(BuildContext context) {
        return const IntegrazooBaseApp(body: Center(child: Text('Hello World!')));
    }
}

