import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../models/todo.dart';
import '../../../shared/app_state.dart';

class StartLoadTodoAction {}

class DoneLoadTodoAction {
  final List<Todo> todos;

  DoneLoadTodoAction(this.todos);
}

class ErrorLoadTodoAction {
  final String error;

  ErrorLoadTodoAction(this.error);
}

class StartAddTodoAction {}

class DoneAddTodoAction {}

class ErrorAddTodoAction {
  final String error;

  ErrorAddTodoAction(this.error);
}

ThunkAction<AppState> loadTodoAction(String uid, [bool refresh = true]) {
  return (Store<AppState> store) async {
    if (refresh) store.dispatch(StartLoadTodoAction());

    final service = store.state.todo.api;

    return service
        .loadTodos(uid)
        .then((todos) => store.dispatch(DoneLoadTodoAction(todos)))
        .catchError((e) => store.dispatch(ErrorLoadTodoAction(e.code)));
  };
}

ThunkAction<AppState> startAddTodoAction(Todo todo) {
  return (Store<AppState> store) async {
    store.dispatch(StartAddTodoAction());

    final service = store.state.todo.api;

    return service
        .addTodo(todo)
        .then((_) => store.dispatch(loadTodoAction(store.state.auth.user.uid)))
        .catchError((e) => store.dispatch(ErrorAddTodoAction(e.code)));
  };
}

ThunkAction<AppState> startTodoComplete(Todo todo) {
  return (Store<AppState> store) async {
    final service = store.state.todo.api;

    return service
        .updateTodo(todo)
        .then((_) => store.dispatch(loadTodoAction(store.state.auth.user.uid)))
        .catchError((e) => store.dispatch(ErrorLoadTodoAction(e.code)));
  };
}

ThunkAction<AppState> startTodoRemove(Todo todo) {
  return (Store<AppState> store) async {
    final service = store.state.todo.api;

    return service
        .removeTodo(todo)
        .then((_) =>
            store.dispatch(loadTodoAction(store.state.auth.user.uid, false)))
        .catchError((e) => store.dispatch(ErrorLoadTodoAction(e.code)));
  };
}

ThunkAction<AppState> startSelectAll(List<Todo> todos) {
  return (Store<AppState> store) async {
    final service = store.state.todo.api;

    return service
        .updateTodos(todos.map((todo) => todo.copy(done: true)).toList())
        .then((_) => store.dispatch(loadTodoAction(store.state.auth.user.uid)))
        .catchError((e) => store.dispatch(ErrorLoadTodoAction(e.code)));
  };
}

ThunkAction<AppState> startRemoveAll(List<Todo> todos) {
  return (Store<AppState> store) async {
    final service = store.state.todo.api;

    return service
        .removeAllTodos(todos.where((todo) => todo.done).toList())
        .then((_) =>
            store.dispatch(loadTodoAction(store.state.auth.user.uid, false)))
        .catchError((e) => store.dispatch(ErrorLoadTodoAction(e.code)));
  };
}

ThunkAction<AppState> startTodoMove(
    List<Todo> todos, int oldIndex, int newIndex) {
  return (Store<AppState> store) async {
    final service = store.state.todo.api;

    List<Todo> orderedTodos =
        todos.where((todo) => todo.id != todos[oldIndex].id).toList();
    if (newIndex > orderedTodos.length) newIndex -= 1;
    orderedTodos = [
      ...orderedTodos.sublist(0, newIndex),
      todos[oldIndex],
      ...orderedTodos.sublist(newIndex),
    ]
        .asMap()
        .entries
        .map((entry) => entry.value.copy(order: entry.key))
        .toList();

    store.dispatch(DoneLoadTodoAction(orderedTodos));

    return service
        .updateTodos(orderedTodos)
        .catchError((e) => store.dispatch(ErrorLoadTodoAction(e.code)));
  };
}
