// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['title', 'userId']);
  return Todo(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    userId: json['userId'] as String,
    done: json['done'] as bool,
    order: json['order'] as int,
  );
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'done': instance.done,
      'order': instance.order,
      'userId': instance.userId,
    };
