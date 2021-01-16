import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../shared/widgets/action_container.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../../../shared/widgets/message_snackbar.dart';
import '../../../shared/models/ad_manager.dart';
import '../../../shared/app_state.dart';
import '../todo_routes.dart';
import '../todo_state.dart';
import '../actions/todo_action.dart';
import 'widgets/filter_todo_button.dart';
import 'widgets/list_todo.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TodosScreenState();
}

class TodosScreenState extends State<TodosScreen> {
  final BannerAd _bannerAd = BannerAd(
    adUnitId: AdManager.bannerAdUnitId,
    size: AdSize.banner,
  );

  @override
  void initState() {
    super.initState();
    _bannerAd
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: -30,
      );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _ = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_.appTitle),
        actions: [FilterTodoButton(), ActionContainer()],
      ),
      drawer: AppDrawerContainer(),
      body: StoreConnector<AppState, TodoState>(
        distinct: true,
        onInit: (store) =>
            store.dispatch(loadTodoAction(store.state.auth.user.uid)),
        converter: (store) => store.state.todo,
        builder: (context, state) {
          if (state.isLoading && state.todos.length == 0) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              MessageSnackBar(message: state.message),
              Expanded(child: ListTodo(todos: state.todos)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, TodoRoutes.addTodo),
        backgroundColor: Theme.of(context).colorScheme.primary,
        tooltip: _.addEntity(_.todo),
        child: Icon(Icons.add),
      ),
    );
  }
}
