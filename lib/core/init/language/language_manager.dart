import 'package:flutter/material.dart';

class LanguageManager {
  LanguageManager._init();
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  static const enLocale = Locale('en', 'US');
  static const trLocale = Locale('tr', 'TR');

  List<Locale> get supportedLocales => [enLocale, trLocale];
}
