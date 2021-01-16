import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  final Function onPressed;
  final String name;

  const StandardButton({Key key, this.onPressed, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
          onPressed: onPressed,
          child: Text(name),
        ),
      ),
    );
  }
}
