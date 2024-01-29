import 'package:flutter/material.dart';

import 'todo.dart';
import 'todo_repository.dart';

class AddTaskScreen extends StatefulWidget {
  final ToDoRepository todoRepository;

  // Constructor to receive the todoRepository
  AddTaskScreen({required this.todoRepository});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers when the screen is disposed to prevent memory leak
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTask() async {
    String taskDesc = _descriptionController.text;
    String taskTitle = _titleController.text;
    ToDo newToDo = ToDo(
      name: taskTitle,
      description: taskDesc,
    );
    // The toMap method will not include the ID, createdAt, and isDone,
    // allowing SQLite to assign them automatically or use defaults
    Map<String, dynamic> toDoMap = newToDo.toMap();
    await widget.todoRepository.addNewToDo(newToDo); // Insert the new task into the database
    Navigator.of(context).pop(true); // Close the screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {_saveTask();},
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}