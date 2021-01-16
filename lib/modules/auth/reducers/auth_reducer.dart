import 'package:redux/redux.dart';

import '../auth_state.dart';
import '../actions/auth_action.dart';
import '../../../shared/models/message.dart';

final authReducers = combineReducers<AuthState>([
  TypedReducer<AuthState, DoneListenUserAction>(_doneListenUser),
  TypedReducer<AuthState, DoneSignUpAction>(_doneSignUpAction),
  TypedReducer<AuthState, DoneResetPassword>(_doneResetPassword),
  TypedReducer<AuthState, StartLoginAction>(_startLogin),
  TypedReducer<AuthState, StartLogoutAction>(_startLogout),
  TypedReducer<AuthState, ErrorLoginAction>(_errorLogin),
]);

AuthState _doneListenUser(AuthState auth, DoneListenUserAction action) {
  return auth.copy(
    user: action.user,
    isLoading: false,
    message: Message(),
    userImage: action.image,
  );
}

AuthState _startLogin(AuthState auth, StartLoginAction action) {
  return auth.copy(isLoading: true);
}

AuthState _errorLogin(AuthState auth, ErrorLoginAction action) {
  return auth.copy(
    isLoading: false,
    message: Message(content: action.error, type: MessageType.error),
  );
}

AuthState _startLogout(AuthState auth, StartLogoutAction action) {
  return auth.copy(isLoading: true);
}

AuthState _doneSignUpAction(AuthState auth, DoneSignUpAction action) {
  return auth.copy(
    isLoading: false,
    message: Message(content: action.message, type: MessageType.normal),
  );
}

AuthState _doneResetPassword(AuthState auth, DoneResetPassword action) {
  return auth.copy(
    isLoading: false,
    message: Message(content: action.message, type: MessageType.normal),
  );
}
