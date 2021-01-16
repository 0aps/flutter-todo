import 'package:redux/redux.dart';

import '../todo_state.dart';
import '../actions/todo_action.dart';
import '../../../shared/models/message.dart';

final todoReducers = combineReducers<TodoState>([
  TypedReducer<TodoState, StartLoadTodoAction>(_startLoadTodoAction),
  TypedReducer<TodoState, DoneLoadTodoAction>(_doneLoadTodoAction),
  TypedReducer<TodoState, ErrorLoadTodoAction>(_errorLoadTodoAction),
  TypedReducer<TodoState, ErrorAddTodoAction>(_errorAddTodoAction),
]);

TodoState _startLoadTodoAction(TodoState state, StartLoadTodoAction action) {
  return state.copy(isLoading: true);
}

TodoState _doneLoadTodoAction(TodoState state, DoneLoadTodoAction action) {
  return state.copy(isLoading: false, todos: action.todos);
}

TodoState _errorLoadTodoAction(TodoState state, ErrorLoadTodoAction action) {
  return state.copy(
    isLoading: false,
    message: Message(content: action.error, type: MessageType.error),
  );
}

TodoState _errorAddTodoAction(TodoState state, ErrorAddTodoAction action) {
  return state.copy(
    isLoading: false,
    message: Message(content: action.error, type: MessageType.error),
  );
}
