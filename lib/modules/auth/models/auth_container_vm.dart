import 'package:equatable/equatable.dart';

import '../auth_state.dart';

class AuthContainerViewModel extends Equatable {
  final Function(String, String) onAuth;
  final Function(String) onResetPassword;
  final AuthState auth;

  AuthContainerViewModel({this.onAuth, this.auth, this.onResetPassword});

  @override
  List<Object> get props => [auth.user, auth.isLoading, auth.message.content];
}
