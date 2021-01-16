import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../lib/modules/auth/actions/auth_action.dart';
import '../../../lib/modules/auth/models/auth_parser.dart';
import '../../../lib/modules/auth/services/authentication_service.dart';
import '../../../lib/modules/todo/services/todo_service.dart';
import '../../../lib/shared/app_reducer.dart';
import '../../../lib/shared/app_state.dart';

import '../mocks.dart';

void main() {
  group('Auth State Reducer', () {
    test(
      'Should listen to auth stream changes on startListenUserAction',
      () async {
        final api = MockFirebaseAuth();
        final StreamController<MockUser> userStreamController =
            StreamController<MockUser>();
        final store = _buildStore(api, userStreamController);

        expect(store.state.auth.isLoading, false);
        store.dispatch(
            startListenUserAction(store.state.auth.api.authStateChanges));
        verify(api.idTokenChanges());
        expect(store.state.auth.isLoading, true);

        userStreamController.add(null);
        await Future.delayed(Duration(milliseconds: 500));

        expect(store.state.auth.isLoading, false);
        userStreamController.close();
      },
    );

    test('Should raise EmailNotVerifiedException on startLoginAction',
        () async {
      final api = MockFirebaseAuth();
      final StreamController<MockUser> userStreamController =
          StreamController<MockUser>();
      final store = _buildStore(api, userStreamController);

      MockUser user = MockUser(
          email: "unverifiedEmail", password: "password", emailVerified: false);

      when(
        api.signInWithEmailAndPassword(
            email: user.email, password: user.password),
      ).thenAnswer(
        (_) {
          userStreamController.add(user);
          return Future.value(MockUserCredential(user));
        },
      );

      store.dispatch(startLoginAction(user.email, user.password));
      expect(store.state.auth.isLoading, true);

      verify(api.signInWithEmailAndPassword(
          email: user.email, password: user.password));

      await Future.delayed(Duration(milliseconds: 500));
      expect(store.state.auth.isLoading, false);
      expect(store.state.auth.message.isError(), true);
      expect(store.state.auth.message.content, AuthParser.emailNotVerified);
    });
  });

  test('Should call sendEmailVerification on startSignUpAction', () async {
    final api = MockFirebaseAuth();
    final StreamController<MockUser> userStreamController =
        StreamController<MockUser>();
    final store = _buildStore(api, userStreamController);

    MockUser user = MockUser(
        email: "unverifiedEmail", password: "password", emailVerified: false);
    MockUserCredential credential = MockUserCredential(user);

    when(
      api.createUserWithEmailAndPassword(
          email: user.email, password: user.password),
    ).thenAnswer(
      (_) {
        userStreamController.add(user);
        return Future.value(credential);
      },
    );

    when(credential.user.sendEmailVerification())
        .thenAnswer((realInvocation) => null);

    store.dispatch(startSignUpAction(user.email, user.password));
    expect(store.state.auth.isLoading, true);

    verify(api.createUserWithEmailAndPassword(
        email: user.email, password: user.password));

    await Future.delayed(Duration(milliseconds: 500));
    verify(credential.user.sendEmailVerification());

    await Future.delayed(Duration(milliseconds: 500));
    expect(store.state.auth.isLoading, false);
    expect(store.state.auth.message.isNormal(), true);
    expect(store.state.auth.message.content, AuthParser.remindConfirmEmail);
  });
}

_buildStore(api, streamController) {
  final store = Store<AppState>(
    appReducer,
    middleware: [thunkMiddleware],
    initialState: AppState.initialState(
      userApi: AuthenticationService(api),
      todoApi: TodoService(MockFirebaseFirestore()),
    ),
  );

  when(api.idTokenChanges()).thenAnswer((_) => streamController.stream);

  return store;
}
