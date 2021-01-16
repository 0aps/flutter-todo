import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';
import '../../modules/auth/actions/auth_action.dart';

class NavMiddleware extends MiddlewareClass<AppState> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavMiddleware(this.navigatorKey);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is DoneLogoutAction) {
      navigatorKey.currentState.popUntil((route) => route.isFirst);
    }

    next(action);
  }
}
