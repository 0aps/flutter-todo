import '../modules/auth/actions/auth_action.dart';
import '../modules/todo/reducers/todo_reducer.dart';
import '../modules/auth/reducers/auth_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState state, action) {
  if (action is DoneLogoutAction) {
    return AppState.initialState();
  }

  final authState = authReducers(state.auth, action);
  final todoState = todoReducers(state.todo, action);

  return state.copy(auth: authState, todo: todoState);
}
