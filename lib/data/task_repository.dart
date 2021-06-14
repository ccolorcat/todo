// Author: cxx
// Date: 2021-06-13
// GitHub: https://github.com/ccolorcat
import 'package:mobx/mobx.dart';
import 'package:todo/data/task.dart';
import 'package:todo/data/task_dao.dart';
import 'package:todo/util/log.dart';

import '../util/lru_cache.dart';

class TaskRepository {
  final _log = Log('TaskRepository');

  final _cached = LruCache<String, ObservableList<Task>>(8);
  final TaskDao _dao;

  TaskRepository(this._dao);

  Future<void> insert(Task task) async {
    final dao = await _opened();
    final inserted = await dao.insert(task);
    _cached.getOrPut(task.category, () => ObservableList()).add(inserted);
    _log.ld(() => 'insert succeed: $inserted');
  }

  Future<List<Task>> query(String category) async {
    var cached = _cached[category];
    if (cached == null) {
      final dao = await _opened();
      final queried = await dao.queryByCategory(category);
      cached = ObservableList.of(queried);
      _cached[category] = cached;
    }
    _log.lv(() => 'query $category: $cached');
    return cached;
  }

  Future<void> delete(Task task) async {
    final cached = _cached[task.category];
    if (cached != null) {
      cached.removeWhere((e) => e.id == task.id);
      final dao = await _opened();
      await dao.delete(task.id!);
      _log.li(() => 'delete $task succeed');
    }
  }

  Future<void> update(Task task) async {
    final cached = _cached[task.category];
    if (cached != null) {
      final index = cached.indexWhere((e) => e.id == task.id);
      cached[index] = task;
    }
    final dao = await _opened();
    await dao.update(task);
    _log.ld(() => 'update $task succeed');
  }

  Future<TaskDao> _opened() async {
    if (!_dao.isOpen) {
      await _dao.open();
    }
    return _dao;
  }
}
