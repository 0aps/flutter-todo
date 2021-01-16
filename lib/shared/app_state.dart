import 'package:meta/meta.dart';
import '../modules/auth/auth_state.dart';
import '../modules/todo/todo_state.dart';

@immutable
class AppState {
  final AuthState auth;
  final TodoState todo;

  AppState({this.auth, this.todo});

  static AppState initialState({userApi, todoApi}) => AppState(
        auth: AuthState.initialState(api: userApi),
        todo: TodoState.initialState(api: todoApi),
      );

  AppState copy({
    AuthState auth,
    TodoState todo,
  }) =>
      AppState(auth: auth ?? this.auth, todo: todo ?? this.todo);
}
