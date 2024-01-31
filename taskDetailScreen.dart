import 'package:flutter/material.dart';
import 'todo.dart';
import 'todo_repository.dart';

class TaskDetailScreen extends StatelessWidget {
  final ToDo toDo;
  final ToDoRepository todoRepository;

  TaskDetailScreen({required this.toDo, required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(toDo.name),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => _handlePopupSelection(value, context),
            itemBuilder: (BuildContext context) {
              return ['toggle'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase(),
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description:',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(toDo.description),
          ],
        ),
      ),
    );
  }

  void _handlePopupSelection(String value, BuildContext context) {
    if (value == 'toggle') {
      for (var i = 0; i < 2; i++) {
        _toggleTask(context);
      }
      // temporary solution to bug
      /// Currently there is bug here that correctly changes the status of the task after running the updateTaskStatus twice.
      /// This is especially visible when going between ListView and DetailView but i lack the knowledge to solve the issue.
      /// How to reproduce:
      /// 1. Be in ListView
      /// 2. Click the task
      /// 3. Toggle task status
      /// 4. Go back to ListView
      /// 5. Refresh - Task wont change the status
      /// 6. repeat the 2 and 3 and again 3
      /// 7. Refresh - now the task should change status
    }
  }

  Future<void> _toggleTask(BuildContext context) async {
    toDo.isDone = toDo.isDone == 1 ? 0 : 1;
    await todoRepository.updateTaskStatus(toDo);
  }
}
