import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart'; //I honestly believe this code generations sucks big time

@JsonSerializable(nullable: false)
class Todo {
  final String id;

  @JsonKey(required: true)
  final String title;

  final String description;

  final bool done;

  final int order;

  @JsonKey(required: true)
  final String userId;

  Todo({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.done,
    this.order,
  });

  Todo copy({
    String id,
    String title,
    String description,
    String userId,
    bool done,
    int order,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        userId: userId ?? this.userId,
        done: done ?? this.done,
        order: order ?? this.order,
      );

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
