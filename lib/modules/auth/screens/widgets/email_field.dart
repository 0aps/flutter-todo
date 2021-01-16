import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailField extends StatelessWidget {
  final String name;
  final Function onSaved;
  final String initialValue;

  const EmailField({Key key, this.name, this.onSaved, this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = AppLocalizations.of(context);

    return TextFormField(
      initialValue: initialValue,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        labelText: name,
        hintText: name,
      ),
      validator: (value) {
        return value.trim().isEmpty
            ? _.emptyError
            : !EmailValidator.validate(value)
                ? _.invalidEmail
                : null;
      },
      onSaved: onSaved,
    );
  }
}
