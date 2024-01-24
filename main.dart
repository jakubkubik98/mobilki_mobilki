import 'package:flutter/material.dart';
import 'initial_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var databasePath = await getDatabasesPath();
  String path = join(databasePath, 'database.db');
  Database database = await openDatabase(
    path, 
    version: 1,
    onCreate: (database, version) async {
      await database.execute('CREATE TABLE toDoList (id INTEGER PRIMARY KEY, name VARCHAR(255), desc VARCHAR(255), createdAt INTEGER, isDone BOOL)');
      await database.execute("INSERT INTO toDoList VALUES (1, 'nazwa', 'opis', '1234', '1' )");
    });
  runApp(MainApp(database: database));
}

class MainApp extends StatelessWidget {
  Database database;
  MainApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: database.rawQuery("SELECT * FROM toDoList"),
          builder: (context, snapshot) {
            return Center(child: Text(snapshot.toString()));
          },
        ),
      ),
    );
  }
}
