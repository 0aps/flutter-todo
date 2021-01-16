import 'package:flutter/material.dart';
import '../../models/todo.dart';

class TileTodo extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onDone, onRemove;

  const TileTodo({
    Key key,
    this.todo,
    this.onDone,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('D${todo.id}'),
      background: Container(color: Colors.red),
      onDismissed: (_) => this.onRemove(todo),
      child: ListTile(
        leading: Icon(Icons.article),
        trailing: Checkbox(
          value: todo.done ?? false,
          onChanged: (value) => this.onDone(todo.copy(done: value)),
        ),
        title: Text(todo.title),
        subtitle: Text(todo.description),
      ),
    );
  }
}
