enum MessageType { normal, error }

class Message {
  final String content;
  final MessageType type;

  Message({this.content, this.type});

  hasContent() => content != null && content.isNotEmpty;

  isError() => this.type == MessageType.error;

  isNormal() => this.type == MessageType.normal;

  copy({
    String content,
    MessageType type,
  }) =>
      Message(
        content: content ?? this.content,
        type: type ?? this.type,
      );
}
