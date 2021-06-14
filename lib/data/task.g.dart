// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: json['id'] as int?,
    category: json['category'] as String,
    createTime: json['create_time'] as int,
    content: json['content'] as String,
    state: json['state'] as int,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'create_time': instance.createTime,
      'content': instance.content,
      'state': instance.state,
    };
