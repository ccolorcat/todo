import 'package:flutter/material.dart';
import 'package:todo/data/category_dao.dart';
import 'package:todo/data/category_repository.dart';
import 'package:todo/data/task_dao.dart';
import 'package:todo/data/task_repository.dart';
import 'package:todo/page/home_page.dart';

import 'data/category.dart';
import 'l10n/s.dart';
import 'page/home_store.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) {
          final taskRepo = TaskRepository(TaskDao());
          final categoryRepo = CategoryRepository(CategoryDao());
          return HomePage(
            store: HomeStore(
              taskRepo,
              categoryRepo,
              Category(
                name: S.of(context).categoryDefault,
                type: Category.typeSystem,
              ),
            ),
          );
        },
      ),
    );
  }
}
