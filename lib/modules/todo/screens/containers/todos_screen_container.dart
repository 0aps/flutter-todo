import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../todos_screen.dart';
import '../../../../shared/app_state.dart';
import '../../models/todos_screen_vm.dart';

class TodosScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodosContainerViewModel>(
      distinct: true,
      converter: (store) => TodosContainerViewModel(
        todo: store.state.todo,
      ),
      builder: (context, vm) => TodosScreen(),
    );
  }
}
