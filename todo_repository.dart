import 'todo.dart';

class ToDoRepository {
  // Returns a sample list of ToDos
  static List<ToDo> getAllToDos() {
    // List<ToDo> list = database.rawQuery('SELECT * FROM toDoList');
    // return list;
    
    // Connection to database should be done here, but we return
    // a sample list instead
    return [
      ToDo(id:1, name: "Nazwe 1", description: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", createdAt: 1706131694000, isDone: false),
      ToDo(id:2, name: "Nazwa 2", description: "Opis 2", createdAt: 1706131419000, isDone: true),
      ToDo(id:3, name: "Nazwa 3", description: "Opis 3", createdAt: 1706131419000, isDone: false),
    ];
  }
}
