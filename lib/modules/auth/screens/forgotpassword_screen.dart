import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'widgets/email_field.dart';
import 'widgets/standard_button.dart';
import '../models/auth_parser.dart';
import '../../../shared/widgets/message_snackbar.dart';
import '../../../shared/widgets/standard_form.dart';
import '../../../shared/models/message.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final void Function(String) onResetPassword;
  final Message message;

  const ForgotPasswordScreen({Key key, this.onResetPassword, this.message})
      : super(key: key);

  State<ForgotPasswordScreen> createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String email;
  Message message = Message();

  @override
  Widget build(BuildContext context) {
    final _ = AppLocalizations.of(context);

    final resetInstructions = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        _.resetPasswordInstructions,
        style: Theme.of(context).textTheme.headline5,
      ),
    );

    final emailField = EmailField(
      name: _.email,
      onSaved: (value) => email = value.trim(),
    );

    final resetPasswordBtn = StandardButton(
      name: _.resetPassword,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          widget.onResetPassword(email);
          Navigator.pop(context);
        }
      },
    );

    if (widget.message.hasContent() && widget.message.isError()) {
      message = widget.message.copy(
        content: AuthParser.parse(_, widget.message.content),
      );
    }

    return Scaffold(
      body: StandardForm(
        formKey: _formKey,
        children: <Widget>[
          resetInstructions,
          emailField,
          resetPasswordBtn,
          MessageSnackBar(message: message)
        ],
      ),
    );
  }
}
