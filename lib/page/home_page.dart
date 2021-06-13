// Author: cxx
// Date: 2021-06-13
// GitHub: https://github.com/ccolorcat
import "package:todo/base/gui.dart";

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  void _handleCreate() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).title),
        centerTitle: true,
      ),
      body: Center(
        child: const Text('todo list'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleCreate,
        tooltip: 'add',
        child: Icon(Icons.add),
      ),
    );
  }
}
