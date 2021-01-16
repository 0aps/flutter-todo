import 'package:flutter/material.dart';

class StandardForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  const StandardForm({Key key, this.formKey, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
