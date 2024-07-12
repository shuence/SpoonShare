import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('en', 'US'); // Default locale

  Locale get currentLocale => _currentLocale;

  void changeLanguage(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }
}
