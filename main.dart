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
      await database.execute('CREATE TABLE toDoList (id INTEGER PRIMARY KEY, name VARCHAR(255), desc VARCHAR(255), createdAt INTEGER, isDone INTEGER)');
      await database.execute("INSERT INTO toDoList VALUES (1, 'Testname1', 'TestDesc', '1234', '1' )");
      await database.execute("INSERT INTO toDoList VALUES (2, 'Testname2', 'TestDesc', '1234', '0' )");
      await database.execute("INSERT INTO toDoList VALUES (3, 'Testname3', 'TestDesc', '1234', '1' )");
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
