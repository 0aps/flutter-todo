import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'widgets/email_field.dart';
import 'widgets/password_field.dart';
import 'widgets/standard_button.dart';
import '../models/auth_parser.dart';
import '../../../shared/widgets/message_snackbar.dart';
import '../../../shared/widgets/standard_form.dart';
import '../../../shared/models/message.dart';

class SignUpScreen extends StatefulWidget {
  final void Function(String, String) onSignUp;
  final Message message;

  const SignUpScreen({Key key, this.onSignUp, this.message}) : super(key: key);

  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  Message _message = Message();

  @override
  Widget build(BuildContext context) {
    final _ = AppLocalizations.of(context);

    final emailField = EmailField(
      name: _.email,
      onSaved: (value) => _email = value.trim(),
    );

    final passwordField = PasswordField(
      name: _.password,
      onSaved: (value) => _password = value.trim(),
    );

    final signUpBtn = StandardButton(
      name: _.signUp,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          widget.onSignUp(_email, _password);
          Navigator.pop(context);
        }
      },
    );

    if (widget.message.hasContent() && widget.message.isError()) {
      _message = widget.message.copy(
        content: AuthParser.parse(_, widget.message.content),
      );
    }

    return Scaffold(
      body: StandardForm(
        formKey: _formKey,
        children: <Widget>[
          emailField,
          passwordField,
          signUpBtn,
          MessageSnackBar(message: _message)
        ],
      ),
    );
  }
}
