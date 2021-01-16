import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../signup_screen.dart';
import '../../actions/auth_action.dart';
import '../../models/auth_container_vm.dart';
import '../../../../shared/app_state.dart';

class SignUpScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthContainerViewModel>(
      converter: (store) => AuthContainerViewModel(
        auth: store.state.auth,
        onAuth: (user, password) =>
            store.dispatch(startSignUpAction(user, password)),
      ),
      builder: (context, vm) => SignUpScreen(
        onSignUp: vm.onAuth,
        message: vm.auth.message,
      ),
    );
  }
}
