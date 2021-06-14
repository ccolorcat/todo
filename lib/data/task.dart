// Author: cxx
// Date: 2021-06-13
// GitHub: https://github.com/ccolorcat
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  static const stateNormal = 0;
  static const stateCompleted = 1;

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'category')
  String category;

  /// fromMillisecondsSinceEpoch
  @JsonKey(name: 'create_time')
  int createTime;
  @JsonKey(name: 'content')
  String content;
  @JsonKey(name: 'state')
  int state;

  bool get isCompleted => state == Task.stateCompleted;

  Task({
    this.id,
    required this.category,
    required this.createTime,
    required this.content,
    this.state = Task.stateNormal,
  });

  factory Task.create(String category, String content) {
    final createTime = DateTime.now().millisecondsSinceEpoch;
    return Task(
      category: category,
      createTime: createTime,
      content: content,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  void complete() {
    state = Task.stateCompleted;
  }

  void incomplete() {
    state = Task.stateNormal;
  }

  @override
  String toString() {
    return 'Task{id: $id, category: $category, createTime: $createTime, content: $content, state: $state}';
  }
}
