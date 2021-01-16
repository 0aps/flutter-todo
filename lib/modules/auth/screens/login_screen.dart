import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/email_field.dart';
import 'widgets/password_field.dart';
import '../auth_routes.dart';
import '../models/auth_parser.dart';
import '../screens/widgets/standard_button.dart';
import '../../../shared/widgets/message_snackbar.dart';
import '../../../shared/widgets/standard_form.dart';
import '../../../shared/models/message.dart';

class LoginScreen extends StatefulWidget {
  final void Function(String, String) onLogin;
  final Message message;

  const LoginScreen({Key key, this.onLogin, this.message}) : super(key: key);

  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
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
      lazy: true,
    );

    final loginBtn = StandardButton(
      name: _.login,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          widget.onLogin(_email, _password);
        }
      },
    );

    final forgotPassword = GestureDetector(
      onTap: () => Navigator.pushNamed(context, AuthRoutes.forgotPassword),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(_.forgotPassword),
      ),
    );

    final signUp = GestureDetector(
      onTap: () => Navigator.pushNamed(context, AuthRoutes.signUp),
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(_.signUp),
      ),
    );

    if (widget.message != null && widget.message.hasContent()) {
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
          forgotPassword,
          loginBtn,
          signUp,
          MessageSnackBar(message: _message)
        ],
      ),
    );
  }
}
