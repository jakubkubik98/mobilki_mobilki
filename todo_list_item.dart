import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'taskDetailScreen.dart';
import 'todo.dart';

class ToDoListItem extends StatelessWidget {
  ToDoListItem({
    required this.toDo,
    VoidCallback? onLongPress,
  }) : _onLongPress = onLongPress;

  final ToDo toDo;
  final VoidCallback? _onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the TaskDetailScreen when the task is tapped
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskDetailScreen(toDo: toDo),
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
    if (toDo.isDone == 0)
    {
      return Text(
      toDo.name,
      style: Theme.of(context).textTheme.headlineSmall,
    );
    }
    else {
      return Text(
      toDo.name,
      style: Theme.of(context).textTheme.headlineSmall?.merge(TextStyle(decoration: TextDecoration.lineThrough),));
    }
    
  }

  Widget _descriptionRow(BuildContext context) {
    int maxLenght = 10;
    if (toDo.description.length > maxLenght) {
      String trimmedDesc = toDo.description.replaceRange(maxLenght+1, null, "...");
      return Text(
      trimmedDesc,
      style: Theme.of(context).textTheme.bodyMedium,
    );}
    else
    {
      return Text(
      toDo.description,
      style: Theme.of(context).textTheme.bodyMedium,
    );}
  }

  Widget _createdRow(BuildContext context) {
    var formattedDate = DateFormat("EEE, d MMM yyyy 'at' HH:mm").format(DateTime.fromMillisecondsSinceEpoch(toDo.createdAt));
    return Text("Created at: "+formattedDate, style: Theme.of(context).textTheme.bodySmall,);
  }
}
