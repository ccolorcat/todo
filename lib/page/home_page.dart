// Author: cxx
// Date: 2021-06-13
// GitHub: https://github.com/ccolorcat
import "package:todo/base/gui.dart";
import 'package:todo/data/task.dart';
import 'package:todo/page/home_store.dart';
import 'package:todo/util/tools.dart';
import 'package:todo/widget/task_widget.dart';

import 'category_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.store}) : super(key: key);

  final HomeStore store;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController? controller;

  HomeStore get store => widget.store;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _handleCreate(BuildContext context) {
    showEditDialog(context, S.of(context).inputTip).then((value) {
      final content = value?.trim();
      if (content?.isNotEmpty == true) {
        store.addTask(content!);
      }
    });
  }

  void _handleComplete(Task task) {
    store.complete(task);
  }

  void _handleIncomplete(Task task) {
    store.incomplete(task);
  }

  void _handleDelete(Task task) {
    store.deleteTask(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) {
            return Text(store.currentCategory.name);
          },
        ),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          final tasks = store.tasks;
          return ListView.builder(
            key: PageStorageKey('tasks'),
            itemBuilder: (_, index) => TaskWidget(
              task: tasks[index],
              onComplete: _handleComplete,
              onIncomplete: _handleIncomplete,
              onDelete: _handleDelete,
            ),
            itemCount: tasks.length,
            controller: controller,
          );
        },
      ),
      drawer: CategoryPage(store: store),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleCreate(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
