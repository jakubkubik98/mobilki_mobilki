import 'package:flutter/material.dart';
import 'initial_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'todo_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var databasePath = await getDatabasesPath();
  String path = join(databasePath, 'database.db');
  Database database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      var currentTime = DateTime.now().millisecondsSinceEpoch.toString();
      await db.execute(
          'CREATE TABLE toDoList (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(255), desc VARCHAR(255), createdAt INTEGER, isDone INTEGER)');
      await db.execute(
          "INSERT INTO toDoList VALUES (1, 'Example Task', 'Example Description', '$currentTime', '1' )");
    },
  );
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Database database;
  final ToDoRepository todoRepository;

  MyApp({Key? key, required this.database})
      : todoRepository = ToDoRepository(database: database),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialScreen(todoRepository: todoRepository),
    );
  }
}
