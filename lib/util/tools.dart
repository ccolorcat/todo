// Author: cxx
// Date: 2021-06-14
// GitHub: https://github.com/ccolorcat

import 'package:intl/intl.dart';

final _dateFormatter = DateFormat('M/dd h:mm');

String formatDateTime(DateTime dateTime) {
  return _dateFormatter.format(dateTime);
}
