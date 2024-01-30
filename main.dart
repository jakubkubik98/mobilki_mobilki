import 'package:flutter/material.dart';
import 'initial_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'main_screen.dart';
import 'todo_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var databasePath = await getDatabasesPath();
  String path = join(databasePath, 'database.db');
  Database database = await openDatabase(
    path, 
    version: 1,
    onCreate: (database, version) async {
      var currentTime = DateTime.now().millisecondsSinceEpoch.toString();
      await database.execute('CREATE TABLE toDoList (id INTEGER PRIMARY KEY AUTOINCEMENT, name VARCHAR(255), desc VARCHAR(255), createdAt INTEGER, isDone INTEGER)');
      await database.execute("INSERT INTO toDoList VALUES (1, 'Example Task', 'Example Description', '$currentTime', '1' )");
    });
  ToDoRepository todoRepository = ToDoRepository(database: database);
  runApp(
    MaterialApp( 
      home: MainScreen(
        todoRepository: todoRepository, 
        username: "",
        )
      )
    );
}

class MainApp extends StatelessWidget {
  Database database;
  ToDoRepository todoRepository;

  MainApp({Key? key, required this.database}) :todoRepository = ToDoRepository(database: database), super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialScreen(todoRepository: todoRepository,),
    );
  }
}
