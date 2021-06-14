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

  final _$_selectedCategoryAtom = Atom(name: '_HomeStore._selectedCategory');

  @override
  Category? get _selectedCategory {
    _$_selectedCategoryAtom.reportRead();
    return super._selectedCategory;
  }

  @override
  set _selectedCategory(Category? value) {
    _$_selectedCategoryAtom.reportWrite(value, super._selectedCategory, () {
      super._selectedCategory = value;
    });
  }

  final _$categoriesAtom = Atom(name: '_HomeStore.categories');

  @override
  ObservableList<Category> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableList<Category> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
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
  void deleteTask(Task task) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.deleteTask');
    try {
      return super.deleteTask(task);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addCategory(String name) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.addCategory');
    try {
      return super.addCategory(name);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteCategory(Category category) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.deleteCategory');
    try {
      return super.deleteCategory(category);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectCategory(Category category) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.selectCategory');
    try {
      return super.selectCategory(category);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categories: ${categories},
tasks: ${tasks},
currentCategory: ${currentCategory}
    ''';
  }
}
