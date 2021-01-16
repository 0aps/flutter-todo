import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'app.dart';
import 'modules/auth/actions/auth_action.dart';
import 'shared/app_reducer.dart';
import 'shared/app_state.dart';
import 'shared/middlewares/nav_middleware.dart';
import 'shared/models/ad_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAdMob.instance.initialize(appId: AdManager.appId);

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  final store = Store<AppState>(
    appReducer,
    middleware: [thunkMiddleware, NavMiddleware(navigatorKey)],
    initialState: AppState.initialState(),
  );

  store.dispatch(startListenUserAction(store.state.auth.api.authStateChanges));

  runApp(
    App(
      store: store,
      navigatorKey: navigatorKey,
    ),
  );
}
