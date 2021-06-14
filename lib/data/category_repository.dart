// Author: cxx
// Date: 2021-06-15
// GitHub: https://github.com/ccolorcat

import 'package:todo/data/category.dart';
import 'package:todo/data/category_dao.dart';
import 'package:todo/util/log.dart';

class CategoryRepository {
  final _log = Log('CategoryRepository');

  CategoryRepository(this._dao);

  final CategoryDao _dao;

  Future<List<Category>> listAll() async {
    final dao = await _opened();
    final result = await dao.query();
    _log.lv(() => 'listAll: $result');
    return result;
  }

  Future<void> insert(Category category) async {
    final dao = await _opened();
    await dao.insert(category);
    _log.ld(() => 'insert: $category');
  }

  Future<void> delete(Category category) async {
    final dao = await _opened();
    await dao.delete(category.name);
    _log.li(() => 'delete: $category');
  }

  Future<CategoryDao> _opened() async {
    if (!_dao.isOpen) {
      await _dao.open();
    }
    return _dao;
  }
}
