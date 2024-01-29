import 'package:flutter/material.dart';
import 'todo.dart';
import 'todo_list_item.dart';
import 'todo_repository.dart';
import 'add_task_screen.dart';

class MainScreen extends StatefulWidget {
  final ToDoRepository todoRepository;
  final String username;

  MainScreen({required this.todoRepository, required this.username});

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
      actions: [
        DropdownButton<String>(
          icon: Icon(Icons.more_vert),
          onChanged: (String? value) {
            if (value == 'add') {
              _handleAddTask(context);
            } else if (value == 'deleteAll') {
              _handleDeleteAllTasks();
            }
          },
          items: [
            DropdownMenuItem<String>(
              value: 'add',
              child: Text('Add New Task'),
            ),
            DropdownMenuItem<String>(
              value: 'deleteAll',
              child: Text('Delete All Tasks'),
            ),
          ],
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        return ToDoListItem(toDo: _todos[index]);
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        _handleAddTask(context);
      },
      child: Icon(Icons.add),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );
}


  void _handleAddTask(BuildContext context) async {
    // Await the result when navigating to AddTaskScreen
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(todoRepository: widget.todoRepository),
      ),
    );

    // Check if a new task was added
    if (result == true) {
      _loadToDos(); // Reload tasks from the database and update the UI
    }
  }

  void _handleDeleteAllTasks() {
    widget.todoRepository.deleteAllToDo();
    _loadToDos();
  }
}
