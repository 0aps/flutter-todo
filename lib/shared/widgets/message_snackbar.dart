import 'package:flutter/material.dart';

import '../models/message.dart';

class MessageSnackBar extends StatelessWidget {
  final Message message;

  const MessageSnackBar({Key key, this.message}) : super(key: key);

  _onMessage(context, content) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  _onError(context, error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.message != null && this.message.hasContent()) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (this.message.isNormal()) {
            this._onMessage(context, this.message.content);
          } else {
            this._onError(context, this.message.content);
          }
        },
      );
    }

    return SizedBox.shrink();
  }
}
