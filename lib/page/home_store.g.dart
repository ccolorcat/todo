// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  Computed<Category>? _$currentCategoryComputed;

  @override
  Category get currentCategory => (_$currentCategoryComputed ??=
          Computed<Category>(() => super.currentCategory,
              name: '_HomeStore.currentCategory'))
      .value;

  final _$_categoryAtom = Atom(name: '_HomeStore._category');

  @override
  Category get _category {
    _$_categoryAtom.reportRead();
    return super._category;
  }

  @override
  set _category(Category value) {
    _$_categoryAtom.reportWrite(value, super._category, () {
      super._category = value;
    });
  }

  final _$tasksAtom = Atom(name: '_HomeStore.tasks');

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void addTask(String content) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.addTask');
    try {
      return super.addTask(content);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void complete(Task task) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.complete');
    try {
      return super.complete(task);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incomplete(Task task) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.incomplete');
    try {
      return super.incomplete(task);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(Task task) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.delete');
    try {
      return super.delete(task);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tasks: ${tasks},
currentCategory: ${currentCategory}
    ''';
  }
}
