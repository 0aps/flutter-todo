import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../actions/auth_action.dart';
import '../../models/auth_container_vm.dart';
import '../../../../shared/app_state.dart';
import '../login_screen.dart';

class AuthenticationContainer extends StatelessWidget {
  final Widget home;

  const AuthenticationContainer({Key key, this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthContainerViewModel>(
      distinct: true,
      converter: (store) => AuthContainerViewModel(
        auth: store.state.auth,
        onAuth: (user, password) =>
            store.dispatch(startLoginAction(user, password)),
      ),
      builder: (context, vm) {
        final auth = vm.auth;
        if (auth.user != null && auth.user.emailVerified && !auth.isLoading) {
          return this.home;
        }

        if (auth.isLoading) {
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }

        return LoginScreen(onLogin: vm.onAuth, message: auth.message);
      },
    );
  }
}
