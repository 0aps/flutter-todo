import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'tile_todo.dart';
import '../../models/todo.dart';
import '../../../../shared/app_state.dart';
import '../../../../modules/todo/actions/todo_action.dart';

class ListTodo extends StatelessWidget {
  final List<Todo> todos;
  final Function onFilterCheck;

  const ListTodo({Key key, this.todos, this.onFilterCheck}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, Function>>(
      distinct: true,
      converter: (store) => {
        'onDone': (todo) {
          store.dispatch(startTodoComplete(todo));
          onFilterCheck();
        },
        'onRemove': (todo) => store.dispatch(startTodoRemove(todo)),
        'onMove': (oldIndex, newIndex) => store.dispatch(
            startTodoMove(store.state.todo.todos, oldIndex, newIndex)),
      },
      builder: (context, actions) {
        final todoWidgets = todos
            .map(
              (todo) => TileTodo(
                key: Key(todo.id),
                todo: todo,
                onDone: actions['onDone'],
                onRemove: actions['onRemove'],
              ),
            )
            .toList();

        return ReorderableListView(
          onReorder: actions['onMove'],
          scrollDirection: Axis.vertical,
          children: todoWidgets,
        );
      },
    );
  }
}
