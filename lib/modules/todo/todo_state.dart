import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import 'services/todo_service.dart';
import 'models/todo.dart';
import '../../shared/models/message.dart';

@immutable
class TodoState {
  final List<Todo> todos;
  final bool isLoading;
  final TodoService api;
  final Message message;

  TodoState({
    this.todos,
    this.isLoading,
    this.api,
    this.message,
  });

  static TodoState initialState({api}) => TodoState(
        todos: [],
        isLoading: false,
        api: api ?? TodoService(FirebaseFirestore.instance),
        message: Message(),
      );

  copy({
    List<Todo> todos,
    bool isLoading,
    TodoService api,
    Message message,
  }) =>
      TodoState(
        todos: todos ?? this.todos,
        isLoading: isLoading ?? this.isLoading,
        api: api ?? this.api,
        message: message ?? this.message,
      );
}
