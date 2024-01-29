import 'package:flutter/material.dart';
import 'todo.dart';

class TaskDetailScreen extends StatelessWidget {
  final ToDo toDo;

  TaskDetailScreen({required this.toDo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(toDo.name),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                // Handle Edit action
                _editTask(context);
              } else if (value == 'delete') {
                // Handle Delete action
                _deleteTask(context);
              } else if (value == 'toggle') {
                // Handle Toggle action
                _toggleTask(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return ['Edit', 'Delete', 'Toggle status'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase(),
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(toDo.description),
          ],
        ),
      ),
    );
  }

  // Implement functions for Edit, Delete, and Toggle actions
  void _editTask(BuildContext context) {
    // Implement the logic to navigate to the edit screen
  }

  void _deleteTask(BuildContext context) {
    // Implement the logic to delete the task
  }

  void _toggleTask(BuildContext context) {
    // Implement the logic to toggle the task's status
  }
}
