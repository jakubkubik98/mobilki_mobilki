import 'package:sqflite/sqflite.dart';

import 'todo.dart';

class ToDoRepository {
  late Database database;

  ToDoRepository({required this.database});
  // Returns a sample list of ToDos
  Future<List<ToDo>> getAllToDos() async {
    List<Map<String, dynamic>> results = await database.rawQuery('SELECT * FROM toDoList');
    List<ToDo> todos = results.map((result) => ToDo.fromMap(result)).toList();
    
    return todos;
  }

  Future<void> addNewToDo(ToDo newToDo) async {
    Map<String, dynamic> toDoMap = newToDo.toMap();
    await database.insert('toDoList', toDoMap);
  }

  Future<void> deleteAllToDo() async {
    await database.rawDelete('DELETE FROM toDoList');
  }
}
