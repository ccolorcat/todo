// Author: cxx
// Date: 2021-06-15
// GitHub: https://github.com/ccolorcat

import 'package:todo/base/gui.dart';
import 'package:todo/data/category.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({
    Key? key,
    required this.data,
    required this.onPressed,
    required this.onDelete,
  }) : super(key: key);

  final Category data;
  final ValueCallback<Category> onPressed;
  final ValueCallback<Category> onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        data.name,
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.black54,
        ),
      ),
      trailing: Visibility(
        visible: data.deletable,
        child: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => onDelete(data),
        ),
      ),
      onTap: () => onPressed(data),
    );
  }
}
