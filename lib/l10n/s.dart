// Author: cxx
// Date: 2021-06-13
// GitHub: https://github.com/ccolorcat

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class S {
  S._internal();

  static Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      AppLocalizations.localizationsDelegates;

  static Iterable<Locale> get supportedLocales =>
      AppLocalizations.supportedLocales;

  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}
