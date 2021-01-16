import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  final Function(Todo) onAddTodo;

  const AddTodoScreen({Key key, this.onAddTodo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddTodoScreenState();
}

class AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title, _description;

  @override
  Widget build(BuildContext context) {
    final _ = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(_.addEntity(_.todo))),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                validator: (value) =>
                    value.trim().isEmpty ? _.emptyError : null,
                onSaved: (value) => _title = value,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  labelText: _.title,
                  hintText: _.title,
                ),
              ),
              TextFormField(
                onSaved: (value) => _description = value,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  labelText: _.description,
                  hintText: _.description,
                ),
                maxLength: 100,
                maxLines: 10,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onAddTodo(Todo(
              title: _title,
              description: _description ?? "",
            ));
            Navigator.pop(context);
          }
        },
        tooltip: _.addEntity(_.todo),
        child: Icon(Icons.add),
      ),
    );
  }
}
