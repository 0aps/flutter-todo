import 'package:equatable/equatable.dart';

import '../todo_state.dart';
import 'todo.dart';

class TodosContainerViewModel extends Equatable {
  final Function(Todo) onAddTodo;
  final TodoState todo;

  TodosContainerViewModel({this.onAddTodo, this.todo});

  @override
  List<Object> get props => [onAddTodo, todo];
}
