import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordField extends StatelessWidget {
  final String name;
  final Function onSaved;
  final Function onValidate;
  final TextEditingController controller;
  final bool lazy;
  static const int maxPasswordLength = 8;
  static const int maxErrorLines = 3;

  const PasswordField(
      {Key key,
      this.name,
      this.onSaved,
      this.onValidate,
      this.controller,
      this.lazy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = AppLocalizations.of(context);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        labelText: name,
        hintText: name,
        errorMaxLines: maxErrorLines,
      ),
      obscureText: true,
      validator: (value) {
        return value.trim().isEmpty
            ? _.emptyError
            : value.trim().length < maxPasswordLength && lazy == null
                ? _.passwordLongerError
                : onValidate != null
                    ? onValidate(value)
                    : null;
      },
      onSaved: onSaved,
    );
  }
}
