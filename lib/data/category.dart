// Author: cxx
// Date: 2021-06-14
// GitHub: https://github.com/ccolorcat
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  static const typeSystem = 0;
  static const typeUser = 1;

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'type')
  int type;

  bool get deletable => type != Category.typeSystem;

  Category({this.id, required this.name, this.type = Category.typeUser});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  String toString() {
    return 'Category{id: $id, name: $name, type: $type}';
  }
}
