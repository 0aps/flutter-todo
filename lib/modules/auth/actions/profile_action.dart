import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'auth_action.dart';
import '../models/user_profile_vm.dart';
import '../../../shared/app_state.dart';

class StartSaveProfileAction {}

class DoneSaveProfileAction {}

class ErrorSaveProfileAction {
  final String error;

  ErrorSaveProfileAction(this.error);
}

ThunkAction<AppState> startSaveProfileAction(UserProfile profile) {
  return (Store<AppState> store) {
    store.dispatch(StartSaveProfileAction());

    final service = store.state.auth.api;
    service.updateProfile(profile).then((_) {
      if (profile.emailChanged) {
        profile.user.sendEmailVerification();
        store.dispatch(startLogoutAction);
      } else {
        store.dispatch(DoneSaveProfileAction());
      }
    }).catchError((e) => store.dispatch(ErrorLoginAction(e.code)));
  };
}
