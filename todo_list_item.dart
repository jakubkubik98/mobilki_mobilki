import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'taskDetailScreen.dart';
import 'todo.dart';
import 'todo_repository.dart';

class ToDoListItem extends StatelessWidget {
  ToDoListItem({
    required this.toDo,
    VoidCallback? onLongPress,
    required this.todoRepository, // Add todoRepository as a required parameter
  }) : _onLongPress = onLongPress;

  final ToDo toDo;
  final VoidCallback? _onLongPress;
  final ToDoRepository todoRepository; // Add todoRepository as a member variable

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskDetailScreen(
              toDo: toDo,
              todoRepository: todoRepository, // Pass todoRepository when creating TaskDetailScreen
            ),
          ),
        );
      },
      onLongPress: _onLongPress,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _nameRow(context),
              SizedBox(height: 8),
              _descriptionRow(context),
              _createdRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameRow(BuildContext context) {
    if (toDo.isDone == 0) {
      return Text(
        toDo.name,
        style: Theme.of(context).textTheme.headlineSmall,
      );
    } else {
      return Text(
        toDo.name,
        style: Theme.of(context).textTheme.headlineSmall?.merge(TextStyle(decoration: TextDecoration.lineThrough)),
      );
    }
  }

  Widget _descriptionRow(BuildContext context) {
    int maxLength = 10;
    if (toDo.description.length > maxLength) {
      String trimmedDesc = toDo.description.replaceRange(maxLength + 1, null, "...");
      return Text(
        trimmedDesc,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    } else {
      return Text(
        toDo.description,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }
  }

  Widget _createdRow(BuildContext context) {
    var formattedDate = DateFormat("EEE, d MMM yyyy 'at' HH:mm").format(DateTime.fromMillisecondsSinceEpoch(toDo.createdAt));
    return Text("Created at: " + formattedDate, style: Theme.of(context).textTheme.bodySmall);
  }
}
