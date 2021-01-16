import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../modules/todo/actions/todo_action.dart';
import '../../modules/todo/models/bar_action.dart';
import '../app_state.dart';

class ActionContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _ = AppLocalizations.of(context);

    return StoreConnector<AppState, Function>(
      distinct: true,
      converter: (store) => (option) {
        switch (option) {
          case BarAction.selectAll:
            store.dispatch(startSelectAll(store.state.todo.todos));
            break;
          case BarAction.removeAll:
            store.dispatch(startRemoveAll(store.state.todo.todos));
        }
      },
      builder: (context, onSelect) => PopupMenuButton<BarAction>(
        onSelected: onSelect,
        offset: Offset(0, 60),
        itemBuilder: (context) => <PopupMenuEntry<BarAction>>[
          PopupMenuItem(
            value: BarAction.selectAll,
            child: Text(_.selectAll),
          ),
          PopupMenuItem(
            value: BarAction.removeAll,
            child: Text(_.deleteAll),
          )
        ],
      ),
    );
  }
}
