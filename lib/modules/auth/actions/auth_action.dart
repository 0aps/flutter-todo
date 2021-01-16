import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../models/auth_exceptions.dart';
import '../models/auth_parser.dart';
import '../../../shared/app_state.dart';

class DoneListenUserAction {
  final User user;
  final File image;

  DoneListenUserAction(this.user, [this.image]);
}

class ErrorLoginAction {
  final String error;

  ErrorLoginAction(this.error);
}

class DoneSignUpAction {
  final String message = AuthParser.remindConfirmEmail;
}

class DoneResetPassword {
  final String message = AuthParser.sentResetPasswordEmail;
}

class StartLoginAction {}

class StartLogoutAction {}

class DoneLogoutAction {}

ThunkAction<AppState> startListenUserAction(Stream<User> tokenStream) {
  return (Store<AppState> store) {
    store.dispatch(StartLoginAction());
    tokenStream.listen((User user) async {
      if (user != null &&
          user.photoURL != null &&
          user.photoURL.isNotEmpty &&
          store.state.auth.userImage == null) {
        final fileImage =
            await store.state.auth.api.loadUserImage(user.photoURL);
        store.dispatch(DoneListenUserAction(
          user,
          fileImage,
        ));
      } else {
        store.dispatch(DoneListenUserAction(user));
      }
    });
  };
}

ThunkAction<AppState> startLoginAction(String email, String password) {
  return (Store<AppState> store) async {
    store.dispatch(StartLoginAction());

    final service = store.state.auth.api;
    try {
      UserCredential authCredential = await service.signIn(email, password);
      if (!authCredential.user.emailVerified) {
        await service.logOut();
        throw new EmailNotVerifiedException();
      }
    } catch (e) {
      store.dispatch(ErrorLoginAction(e.code));
    }
  };
}

ThunkAction<AppState> startSignUpAction(String email, String password) {
  return (Store<AppState> store) async {
    store.dispatch(StartLoginAction());

    final service = store.state.auth.api;
    try {
      UserCredential authCredential = await service.signUp(email, password);
      if (!authCredential.user.emailVerified) {
        authCredential.user.sendEmailVerification();
        store.dispatch(DoneSignUpAction());
      }
    } catch (e) {
      store.dispatch(ErrorLoginAction(e.code));
    }
  };
}

ThunkAction<AppState> startResetPasswordAction(String email) {
  return (Store<AppState> store) {
    store.dispatch(StartLoginAction());

    final service = store.state.auth.api;
    service
        .resetPassword(email)
        .then((_) => store.dispatch(DoneResetPassword()))
        .catchError((e) => store.dispatch(ErrorLoginAction(e.code)));
  };
}

void startLogoutAction(Store<AppState> store) {
  store.dispatch(StartLogoutAction());

  final service = store.state.auth.api;
  service.logOut().then((_) => store.dispatch(DoneLogoutAction()));
}
