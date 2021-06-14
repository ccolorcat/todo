// Author: cxx
// Date: 2021-06-14
// GitHub: https://github.com/ccolorcat
import 'package:todo/base/vm.dart';
import 'package:todo/data/category.dart';
import 'package:todo/data/task.dart';
import 'package:todo/data/task_repository.dart';
import 'package:todo/util/log.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final _log = Log('HomeStore');

  _HomeStore(this.taskRepo) {
    _updateTasks();
  }

  final TaskRepository taskRepo;

  @observable
  Category _category = Category(name: 'default');

  @computed
  Category get currentCategory => _category;

  @observable
  ObservableList<Task> tasks = ObservableList();

  @action
  void addTask(String content) {
    final task = Task.create(_category.name, content);
    _log.ld(() => 'addTask: $task');
    taskRepo.insert(task).then((value) => _updateTasks());
  }

  @action
  void complete(Task task) {
    _log.lv(() => 'complete: $task');
    taskRepo.update(task..complete()).then((value) => _updateTasks());
  }

  @action
  void incomplete(Task task) {
    _log.lv(() => 'incomplete: $task');
    taskRepo.update(task..incomplete()).then((value) => _updateTasks());
  }

  @action
  void delete(Task task) {
    _log.li(() => 'delete: $task');
    taskRepo.delete(task).then((value) => _updateTasks());
  }

  void _updateTasks() {
    taskRepo.query(_category.name).then((value) {
      tasks
        ..clear()
        ..addAll(value);
    });
  }
}
