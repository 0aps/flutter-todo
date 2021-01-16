import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileAlertDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final GlobalKey<FormState> formKey;

  const ProfileAlertDialog({Key key, this.title, this.child, this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: child,
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              Navigator.pop(context);
            }
          },
          child: Text(_.ok),
        ),
      ],
    );
  }
}
