import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'list_todo.dart';
import '../../models/todo.dart';
import '../../todo_state.dart';
import '../../../../shared/app_state.dart';

class FilterTodoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodoState>(
      distinct: true,
      converter: (store) => store.state.todo,
      builder: (context, vm) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => {
              showSearch(
                context: context,
                delegate: Search(vm.todos),
              )
            },
            icon: Icon(Icons.search),
          ),
        );
      },
    );
  }
}

class Search extends SearchDelegate {
  final List<Todo> todos;

  Search(this.todos);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => query = "",
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Todo> filteredTodos = [];
    filteredTodos.addAll(
      todos.where(
        (todo) => todo.title.contains(query),
      ),
    );

    return ListTodo(
      todos: filteredTodos,
      onFilterCheck: () => Navigator.pop(context),
    );
  }
}
