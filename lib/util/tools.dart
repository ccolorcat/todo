// Author: cxx
// Date: 2021-06-14
// GitHub: https://github.com/ccolorcat

import 'package:intl/intl.dart';
import 'package:todo/base/gui.dart';
import 'package:todo/widget/edit_dialog.dart';

final _dateFormatter = DateFormat('M/dd h:mm');

String formatDateTime(DateTime dateTime) {
  return _dateFormatter.format(dateTime);
}

Future<String?> showEditDialog(BuildContext context) {
  return showDialog<String>(context: context, builder: (_) => EditDialog());
}
