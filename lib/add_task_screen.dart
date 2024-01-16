import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'task_model.dart';

class AddTaskScreen extends StatefulWidget {
  final String userName;

  AddTaskScreen({required this.userName});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              onChanged: (value) {
                setState(() {
                  _isButtonEnabled = value.trim().isNotEmpty;
                });
              },
              decoration: InputDecoration(
                labelText: 'Task Name',
                errorText: _isButtonEnabled ? null : 'Name is required',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonEnabled ? _saveTask : null,
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveTask() async {
    final String taskName = _nameController.text.trim();
    final String taskDescription = _descriptionController.text.trim();
    final String creationDate = DateTime.now().toString();

    Task newTask = Task(
      name: taskName,
      description: taskDescription,
      creationDate: creationDate,
      isDone: false,
    );

    await DatabaseHelper.instance.insertTask(widget.userName, newTask);
    Navigator.pop(context); // Close the Add Task screen
  }
}
