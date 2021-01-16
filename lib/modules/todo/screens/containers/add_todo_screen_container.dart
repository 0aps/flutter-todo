import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../actions/todo_action.dart';
import '../../models/todos_screen_vm.dart';
import '../../screens/add_todo_screen.dart';
import '../../../../shared/app_state.dart';

class AddTodoScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodosContainerViewModel>(
      distinct: true,
      converter: (store) => TodosContainerViewModel(
        todo: store.state.todo,
        onAddTodo: (todo) => store.dispatch(
          startAddTodoAction(todo.copy(userId: store.state.auth.user.uid)),
        ),
      ),
      builder: (context, vm) => AddTodoScreen(
        onAddTodo: vm.onAddTodo,
      ),
    );
  }
}
