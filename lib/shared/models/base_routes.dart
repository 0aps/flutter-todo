import 'package:flutter/cupertino.dart';

abstract class BaseRoutes {
  Map<String, Widget Function(BuildContext context)> getRoutes();
}
