import 'package:flutter/material.dart';
import 'todo.dart';

class ToDoListItem extends StatelessWidget {
  ToDoListItem({
    required this.toDo,
  });

  // Variable used to store todo that this widget will show
  final ToDo toDo;

  @override
  Widget build(BuildContext context) {
    // Card makes the element in list look nicer
    return Card(
      child: Padding(
        // Padding to add margins to all card children
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show ToDo content with custom methods
            _nameRow(context),
            // SizedBox here used to add some space betweet name and description
            SizedBox(height: 8),
            _descriptionRow(context),
          ],
        ),
      ),
    );
  }

  Widget _nameRow(BuildContext context) {
    return Text(
      toDo.name,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _descriptionRow(BuildContext context) {
    return Text(
      toDo.description,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
