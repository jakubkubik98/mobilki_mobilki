import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'task_model.dart';
import 'dart:io';

class TaskListScreen extends StatefulWidget {
  final String userName;

  TaskListScreen({required this.userName});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late List<Task> _tasks;

  @override
  void initState() {
    super.initState();
    if(File('todo_database.db').exists() == false) {
      
    }
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    print("Im here");
    _tasks = await DatabaseHelper.instance.getTasks(widget.userName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks for ${widget.userName}'),
      ),
      body: _tasks.isEmpty
          ? Center(
              child: Text('No tasks yet.'),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                Task task = _tasks[index];
                return ListTile(
                  title: Text(task.name),
                  subtitle: Text('Created: ${task.creationDate}'),
                  trailing: Checkbox(
                    value: task.isDone,
                    onChanged: (value) => _updateTaskStatus(task, value),
                  ),
                  onTap: () => _showTaskOptionsDialog(task),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _updateTaskStatus(Task task, bool? isDone) async {
    task.isDone = isDone ?? false;
    await DatabaseHelper.instance.updateTask(task);
    _loadTasks();
  }

  Future<void> _showTaskOptionsDialog(Task task) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Task Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => _deleteTask(task),
              child: Text('Delete Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTask(Task task) async {
    await DatabaseHelper.instance.deleteTask(task.id!);
    _loadTasks();
    Navigator.pop(context); // Close the options dialog
  }

  void _navigateToAddTask() {
    Navigator.pushNamed(context, '/addTask'); // You need to define a route for the Add Task screen
  }
}
