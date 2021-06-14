// Author: cxx
// Date: 2021-06-14
// GitHub: https://github.com/ccolorcat

import 'package:todo/base/gui.dart';
import 'package:todo/data/task.dart';
import 'package:todo/util/log.dart';
import 'package:todo/util/tools.dart' as tool;

class TaskWidget extends StatelessWidget {
  static const _actionComplete = 0;
  static const _actionDelete = 1;

  TaskWidget({
    Key? key,
    required this.task,
    required this.onComplete,
    required this.onDelete,
  }) : super(key: key);

  final Task task;
  final ValueCallback<Task> onComplete;
  final ValueCallback<Task> onDelete;

  String get _formattedTime {
    final date = DateTime.fromMillisecondsSinceEpoch(task.createTime);
    return tool.formatDateTime(date);
  }

  List<PopupMenuEntry<int>> _buildMenuEntry(BuildContext context) {
    final complete = S.of(context).complete;
    final delete = S.of(context).delete;
    return [
      PopupMenuItem(
        child: Text(complete),
        value: TaskWidget._actionComplete,
      ),
      PopupMenuItem(
        child: Text(delete),
        value: TaskWidget._actionDelete,
      ),
    ];
  }

  void _handleAction(int value) {
    Log().ld(() => "_handleAction: $value");
    switch (value) {
      case TaskWidget._actionDelete:
        onDelete(task);
        break;
      case TaskWidget._actionComplete:
        onComplete(task);
        break;
      default:
        throw StateError(
            'the value($value) must be ${TaskWidget._actionComplete} or ${TaskWidget._actionDelete}');
    }
  }

  Widget _buildAction() {
    return PopupMenuButton<int>(
      itemBuilder: _buildMenuEntry,
      icon: Icon(Icons.more_vert),
      onSelected: _handleAction,
      padding: const EdgeInsets.all(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: task.isCompleted ? Colors.black26 : null,
      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
    );
    return Card(
      margin: const EdgeInsets.all(KMargin),
      child: ListTile(
        title: Text(
          task.content,
          style: style.copyWith(fontSize: 18.0),
        ),
        subtitle: Text(
          _formattedTime,
          style: style,
        ),
        trailing: _buildAction(),
      ),
    );
  }
}
