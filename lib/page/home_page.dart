// Author: cxx
// Date: 2021-06-13
// GitHub: https://github.com/ccolorcat
import "package:todo/base/gui.dart";
import 'package:todo/data/task.dart';
import 'package:todo/data/task_dao.dart';
import 'package:todo/data/task_repository.dart';
import 'package:todo/page/home_store.dart';
import 'package:todo/util/tools.dart';
import 'package:todo/widget/task_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController? controller;
  final HomeStore store = HomeStore(TaskRepository(TaskDao()));

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
    showEditDialog(context).then((value) {
      if (value?.isNotEmpty == true) {
        store.addTask(value!);
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
    store.delete(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).title),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleCreate(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
