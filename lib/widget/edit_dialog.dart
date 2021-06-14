// Author: cxx
// Date: 2021-06-14
// GitHub: https://github.com/ccolorcat

import 'package:todo/base/gui.dart';

class EditDialog extends StatefulWidget {
  EditDialog({Key? key, this.hint = ""}) : super(key: key);

  final String hint;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  TextEditingController? controller;
  String? text;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController()
      ..addListener(() {
        this.text = controller?.text;
      });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final actions = [
      TextButton(
        child: Text(local.cancel),
        onPressed: () {
          Navigator.of(context).pop(null);
        },
      ),
      TextButton(
        child: Text(local.confirm),
        onPressed: () {
          Navigator.of(context).pop(text);
        },
      )
    ];
    return AlertDialog(
      content: TextField(
        autofocus: true,
        textInputAction: TextInputAction.done,
        maxLines: null,
        controller: controller,
        decoration: InputDecoration(
          hintText: widget.hint,
        ),
      ),
      actions: actions,
    );
  }
}
