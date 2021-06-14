// Author: cxx
// Date: 2021-06-13
// GitHub: https://github.com/ccolorcat
import 'package:todo/base/app_database.dart';
import 'package:todo/data/task.dart';

class TaskDao extends AppDatabase<Task> {
  static const _tableName = 'task_table';
  static const _primaryKey = 'id';

  static const sqlCreate = 'CREATE TABLE IF NOT EXISTS $_tableName('
      '$_primaryKey INTEGER PRIMARY KEY AUTOINCREMENT,'
      'category TEXT,'
      'create_time INTEGER,'
      'content TEXT,'
      'state INTEGER)';

  TaskDao() : super(_tableName, _primaryKey);

  @override
  Future<Task> insert(Task data) async {
    await super.insert(data);
    final inserted = await db!.query(
      tableName,
      where: 'category = ? AND create_time = ? AND content = ? AND state = ?',
      whereArgs: [data.category, data.createTime, data.content, data.state],
      limit: 1,
    );
    return fromSql(inserted[0]);
  }

  Future<List<Task>> queryByCategory(String category) async {
    final result = await query(
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'create_time',
    );
    return result;
  }

  @override
  primaryValue(Task data) {
    return data.id;
  }

  @override
  Task fromSql(Map<String, dynamic> sql) {
    return Task.fromJson(sql);
  }

  @override
  Map<String, dynamic> toSql(Task data) {
    return data.toJson();
  }
}
