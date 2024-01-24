import 'todo.dart';

class ToDoRepository {
  // Returns a sample list of ToDos
  static List<ToDo> getAllToDos() {
    List<ToDo> list = await database.rawQuery('SELECT * FROM toDoList');
    return list;
    // Connection to database should be done here, but we return
    // a sample list instead
    // return [
    //   ToDo(name: "Nazwa 1", description: "Opis 1"),
    //   ToDo(name: "Nazwa 2", description: "Opis 2"),
    // ];
  }
}
