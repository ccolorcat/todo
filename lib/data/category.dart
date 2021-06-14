// Author: cxx
// Date: 2021-06-14
// GitHub: https://github.com/ccolorcat
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  static const typeSystem = 0;
  static const typeUser = 1;

  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'type')
  int type;

  bool get deletable => type != Category.typeSystem;

  Category({required this.name, this.type = Category.typeUser});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => name.hashCode ^ type.hashCode;

  @override
  String toString() {
    return 'Category{name: $name, type: $type}';
  }
}
