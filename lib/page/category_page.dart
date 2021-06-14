// Author: cxx
// Date: 2021-06-15
// GitHub: https://github.com/ccolorcat
import 'package:todo/base/gui.dart';
import 'package:todo/data/category.dart';
import 'package:todo/page/home_store.dart';
import 'package:todo/util/tools.dart';
import 'package:todo/widget/category_widget.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key, required this.store}) : super(key: key);

  final HomeStore store;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
    showEditDialog(context, S.of(context).inputCategory).then((value) {
      final name = value?.trim();
      if (name?.isNotEmpty == true) {
        store.addCategory(name!);
      }
    });
  }

  void _handleSelect(BuildContext context, Category data) {
    store.selectCategory(data);
    Navigator.of(context).pop();
  }

  void _handleDelete(Category data) {
    store.deleteCategory(data);
  }

  Widget _buildTitle(BuildContext context) {
    return ListTile(
      title: Text(
        S.of(context).type,
        style: Theme.of(context).textTheme.headline5,
      ),
      trailing: IconButton(
        onPressed: () => _handleCreate(context),
        icon: Icon(Icons.add_circle),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, Category data) {
    return CategoryWidget(
      data: data,
      onPressed: (value) => _handleSelect(context, value),
      onDelete: (value) => _handleDelete(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          16.0,
          96.0,
          16.0,
          32.0,
        ),
        child: Column(
          children: [
            _buildTitle(context),
            _buildCategory(
              context,
              store.defaultCategory,
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  final data = store.categories;
                  return ListView.builder(
                    itemBuilder: (_, index) {
                      return _buildCategory(context, data[index]);
                    },
                    itemCount: data.length,
                    controller: controller,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
