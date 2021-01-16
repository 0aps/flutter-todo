import 'package:flutter/cupertino.dart';

import '../modules/auth/auth_routes.dart';
import '../modules/todo/todo_routes.dart';

class AppRoutes {
  static final auth = AuthRoutes();
  static final todo = TodoRoutes();

  static getRoutes() {
    final routes = [auth, todo]
        .map((route) => route.getRoutes())
        .fold({}, (routes, route) => {...routes, ...route});

    return Map<String, Widget Function(BuildContext)>.from(routes);
  }
}
