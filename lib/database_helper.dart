import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '/task_model.dart';

class DatabaseHelper {
  static const String _databaseName = 'todo_database.db';
  static const String _tableName = 'tasks';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        creation_date TEXT,
        is_done INTEGER
      )
    ''');
  }

  Future<List<Task>> getTasks(String userName) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'user_name = ?',
      whereArgs: [userName],
    );

    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        name: maps[index]['name'],
        description: maps[index]['description'],
        creationDate: maps[index]['creation_date'],
        isDone: maps[index]['is_done'] == 1,
      );
    });
  }

  Future<int> insertTask(String userName, Task task) async {
    final Database db = await database;
    return db.insert(
      _tableName,
      {
        'user_name': userName,
        'name': task.name,
        'description': task.description,
        'creation_date': task.creationDate,
        'is_done': task.isDone ? 1 : 0,
      },
    );
  }

  Future<int> updateTask(Task task) async {
    final Database db = await database;
    return db.update(
      _tableName,
      {
        'name': task.name,
        'description': task.description,
        'creation_date': task.creationDate,
        'is_done': task.isDone ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int taskId) async {
    final Database db = await database;
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}