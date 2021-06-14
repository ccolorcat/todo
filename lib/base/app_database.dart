// Author: cxx
// Date: 2021-06-13
// GitHub: https://github.com/ccolorcat

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/base/gui.dart';
import 'package:todo/data/task_dao.dart';

abstract class AppDatabase<T> {
  static const _dbName = 'todo_database';
  static const _version = 1;

  final String tableName;
  final String primaryKey;

  AppDatabase(this.tableName, this.primaryKey);

  @protected
  Database? db;

  bool get isOpen => db?.isOpen == true;

  Future<void> open() async {
    final path = join(await getDatabasesPath(), _dbName);
    db = await openDatabase(
      path,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: _version,
    );
  }

  // crate all tables
  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(TaskDao.sqlCreate);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {}

  Future<void> close() async {
    if (isOpen) {
      await db?.close();
    }
  }

  Future<T> insert(T data) async {
    await db!.insert(
      tableName,
      toSql(data),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return data;
  }

  Future<List<T>> query({
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
  }) async {
    final result = await db!.query(
      tableName,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
    return result.map(fromSql).toList();
  }

  Future<T> update(T data) async {
    await db!.update(
      tableName,
      toSql(data),
      where: '$primaryKey = ?',
      whereArgs: [primaryValue(data)],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return data;
  }

  Future<void> delete(dynamic primaryValue) async {
    await db!.delete(
      tableName,
      where: '$primaryKey = ?',
      whereArgs: [primaryValue],
    );
  }

  dynamic primaryValue(T data);

  T fromSql(Map<String, dynamic> sql);

  Map<String, dynamic> toSql(T data);
}
