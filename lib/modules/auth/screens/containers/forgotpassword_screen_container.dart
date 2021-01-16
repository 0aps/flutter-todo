import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../forgotpassword_screen.dart';
import '../../actions/auth_action.dart';
import '../../models/auth_container_vm.dart';
import '../../../../shared/app_state.dart';

class ForgotPasswordScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthContainerViewModel>(
      converter: (store) => AuthContainerViewModel(
        auth: store.state.auth,
        onResetPassword: (email) =>
            store.dispatch(startResetPasswordAction(email)),
      ),
      builder: (context, vm) => ForgotPasswordScreen(
        onResetPassword: vm.onResetPassword,
        message: vm.auth.message,
      ),
    );
  }
}
