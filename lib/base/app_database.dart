// Author: cxx
// Date: 2021-06-13
// GitHub: https://github.com/ccolorcat

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/base/gui.dart';

abstract class AppDatabase<T> {
  AppDatabase(this.dbName, this.table, this.primaryKey, [this.version = 1]);

  final String dbName;
  final String table;

  final String primaryKey;

  final int version;

  @protected
  Database? db;

  bool get isOpen => db?.isOpen == true;

  Future<void> open() async {
    final path = join(await getDatabasesPath(), dbName);
    db = await openDatabase(
      path,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
      version: version,
    );
  }

  Future<void> onCreate(Database db, int version);

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    return Future.value(null);
  }

  Future<void> close() async {
    if (isOpen) {
      await db?.close();
    }
  }

  Future<T> insert(T data) async {
    await db!.insert(
      table,
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
      table,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
    return result.map((e) => fromSql(e)).toList();
  }

  Future<T> update(T data) async {
    await db!.update(
      table,
      toSql(data),
      where: '$primaryKey = ?',
      whereArgs: [primaryValue(data)],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return data;
  }

  Future<void> delete(dynamic primaryValue) async {
    await db!.delete(
      table,
      where: '$primaryKey = ?',
      whereArgs: [primaryValue],
    );
  }

  dynamic primaryValue(T data);

  T fromSql(Map<String, dynamic> sql);

  Map<String, dynamic> toSql(T data);
}
