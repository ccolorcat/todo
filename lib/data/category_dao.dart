// Author: cxx
// Date: 2021-06-14
// GitHub: https://github.com/ccolorcat

import 'package:sqflite/sqflite.dart';
import 'package:todo/base/app_database.dart';
import 'package:todo/data/category.dart';

class CategoryDao extends AppDatabase<Category> {
  static const _tableName = 'category_table';
  static const _primaryKey = 'name';

  static const sqlCreate = 'CREATE TABLE IF NOT EXISTS $_tableName('
      '$_primaryKey TEXT PRIMARY KEY,'
      'type INTEGER)';

  CategoryDao() : super(_tableName, _primaryKey);

  ConflictAlgorithm get conflictAlgorithm => ConflictAlgorithm.ignore;

  @override
  primaryValue(Category data) {
    return data.name;
  }

  @override
  Category fromSql(Map<String, dynamic> sql) {
    return Category.fromJson(sql);
  }

  @override
  Map<String, dynamic> toSql(Category data) {
    return data.toJson();
  }
}
