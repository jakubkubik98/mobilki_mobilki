import 'package:flutter/material.dart';
import 'initial_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> main() async {
  var databasePath = await getDatabasesPath();
  String path = join(databasePath, 'database.db');
  Database database = await openDatabase(path, version: 1,
    onCreate: (Database db, int (db, version) async {
      await db.execute('CREATE TABLE ToDoList (id INTEGER PRIMARY KEY, name VARCHAR(255), desc VARCHAR(255)), createdAt TIMESTAMP, isDone BOOL)')
  }
  )
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialScreen(),
    );
  }
}
