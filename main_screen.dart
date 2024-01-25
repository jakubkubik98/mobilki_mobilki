import 'package:flutter/material.dart';
import 'todo.dart';
import 'todo_list_item.dart';
import 'todo_repository.dart';

class MainScreen extends StatefulWidget {
  final ToDoRepository todoRepository;
  final String username;

  MainScreen({required this.todoRepository, required this.username});

  // Variable used to store username passed from initial screen

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
    _loadToDos();
  }

  Future<void> _loadToDos() async {
    List<ToDo> todos = await widget.todoRepository.getAllToDos();
    setState(() {
      _todos = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: FutureBuilder<List<ToDo>>(
        future: widget.todoRepository.getAllToDos(),  // Use widget.todoRepository here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<ToDo> todos = snapshot.data ?? [];
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].name),
                );
              },
            );
          }
        },
      ),
    );
  }
}
    // return Scaffold(
    //   appBar: AppBar(
    //     // Use the username provided to widget from state
    //     title: Text("Hello, ${widget.username}"),
    //   ),
    //   body: ListView.builder(
    //     // Number of items for the list to use
    //     itemCount: _todos.length,
    //     // Builder uses context and index of element in list to create a new
    //     // widget for each item in list
    //     itemBuilder: (context, index) {
    //       return ToDoListItem(
    //         toDo: _todos[index],
    //         onPressed: {
    //               },
    //         );
    //     },
    //   ),
    // );