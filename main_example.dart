import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String databasesDirectory = await getDatabasesPath();
  String databasePath = databasesDirectory + "database.db";
  Database db = await openDatabase(
    databasePath,
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS todos(id INTEGER PRIMARY KEY, name TEXT, desc TEXT, created_at INTEGER, is_done BOOL)");
      await db.execute(
          "INSERT INTO todos(id, name, desc, created_at, is_done) VALUES (1, 'nazwa', 'opis', 1234, 1)");
    },
  );
  runApp(MainApp(database: db));
}

class MainApp extends StatelessWidget {
  Database database;
  MainApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: database.rawQuery("SELECT * FROM todos"),
          builder: (context, snapshot) {
            return Center(child: Text(snapshot.toString()));
          },
        ),
      ),
    );
  }
}
