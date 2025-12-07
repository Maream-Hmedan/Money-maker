import 'package:flutter/material.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/widgets/helpers/general.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:ui';



class AppLocale extends Model {
  AppLocale._private();
  static final AppLocale _shared = AppLocale._private();
  factory AppLocale() => _shared;

  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  Future<void> init() async {
    final saved = await General.getPrefString(
      ConstantValues.SELECTED_LANGUAGE,
      'en',
    );
    _currentLocale = Locale(saved);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (_currentLocale == locale) return;
    _currentLocale = locale;
    await General.savePrefString(
      ConstantValues.SELECTED_LANGUAGE,
      locale.languageCode,
    );
    notifyListeners();
  }

  bool isArabic() => _currentLocale.languageCode == 'ar';
}
