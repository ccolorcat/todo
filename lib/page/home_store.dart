// Author: cxx
// Date: 2021-06-14
// GitHub: https://github.com/ccolorcat
import 'package:todo/base/vm.dart';
import 'package:todo/data/category.dart';
import 'package:todo/data/category_repository.dart';
import 'package:todo/data/task.dart';
import 'package:todo/data/task_repository.dart';
import 'package:todo/util/log.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final _log = Log('HomeStore');

  _HomeStore(this.taskRepo, this.categoryRepository, this.defaultCategory) {
    _updateCategories(true);
  }

  final TaskRepository taskRepo;
  final CategoryRepository categoryRepository;
  final Category defaultCategory;

  @observable
  Category? _selectedCategory;

  @computed
  Category get currentCategory => _selectedCategory ?? defaultCategory;

  @observable
  ObservableList<Category> categories = ObservableList();

  @observable
  ObservableList<Task> tasks = ObservableList();

  @action
  void addTask(String content) {
    final task = Task.create(currentCategory.name, content);
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
  void deleteTask(Task task) {
    _log.li(() => 'delete: $task');
    taskRepo.delete(task).then((value) => _updateTasks());
  }

  @action
  void addCategory(String name) {
    if (name != defaultCategory.name) {
      final category = Category(name: name);
      categoryRepository.insert(category).then((value) => _updateCategories());
    }
  }

  @action
  void deleteCategory(Category category) {
    categoryRepository.delete(category).then((value) {
      if (category.name == _selectedCategory?.name) {
        _selectedCategory = null;
        _updateCategories(true);
      }
    });
  }

  @action
  void selectCategory(Category category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      _updateTasks();
    }
  }

  void _updateTasks() {
    taskRepo.query(currentCategory.name).then((value) {
      tasks
        ..clear()
        ..addAll(value);
    });
  }

  void _updateCategories([bool refreshTasks = false]) {
    categoryRepository.listAll().then((value) {
      categories
        ..clear()
        ..addAll(value);
      if (refreshTasks) {
        _updateTasks();
      }
    });
  }
}
