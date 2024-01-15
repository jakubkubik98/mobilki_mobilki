import 'package:flutter/material.dart';
import 'todo.dart';
import 'todo_list_item.dart';
import 'todo_repository.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    super.key,
    required this.username,
  });

  // Variable used to store username passed from initial screen
  final String username;

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  List<ToDo> _todos = [];

  @override
  void initState() {
    super.initState();
    // Read all entries from repository here
    _todos = ToDoRepository.getAllToDos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Use the username provided to widget from state
        title: Text("Hello, ${widget.username}"),
      ),
      body: ListView.builder(
        // Number of items for the list to use
        itemCount: _todos.length,
        // Builder uses context and index of element in list to create a new
        // widget for each item in list
        itemBuilder: (context, index) {
          return ToDoListItem(toDo: _todos[index]);
        },
      ),
    );
  }
}
