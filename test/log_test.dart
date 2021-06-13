// Author: cxx
// Date: 2021-06-13
// GitHub: https://github.com/ccolorcat

import 'package:todo/util/log.dart';

void main() {
  testLog();
}

void testLog() {
  final log = Log();
  log.lv(() => 'this is verbose log');
  log.ld(() => 'this is debug log');
  log.li(() => 'this is info log');
  log.lw(() => 'this is warning log');
  log.le(() => 'this is error log');
}
