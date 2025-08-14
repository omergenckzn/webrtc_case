import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum LangCode { ar, en, tr }

class LanguageService {

  LanguageService._singleton(this.context) {
    currentLanguage = _currentLanguage;
    languageCode = _languageCode;
    rtl = _rtl;
  }

  factory LanguageService(BuildContext context) {
    if (_instance != null) {
      if (Localizations.localeOf(context).languageCode != languageCode) {
        return LanguageService._singleton(context);
      }
      return _instance!;
    }
    return LanguageService._singleton(context);
  }
  static late Locale currentLanguage;
  static late String languageCode;
  static late bool rtl;

  final BuildContext context;
  static LanguageService? _instance;

  Locale get _currentLanguage => Localizations.localeOf(context);

  String get _languageCode => _currentLanguage.languageCode;

  bool get _rtl => _currentLanguage == localMap[LangCode.ar]!;

  static const List<Locale> supportedLocales = [
    Locale('ar'),
    Locale('en'),
    Locale('tr'),
  ];

  static const Locale defaultLocale = Locale('ar');

  static const Map<LangCode, Locale> localMap = {
    LangCode.en: Locale('en'),
    LangCode.tr: Locale('tr'),
    LangCode.ar: Locale('ar'),
  };

  static const Map<String, Locale> mapLanguageCodeToLocale = {
    'en': Locale('en'),
    'tr': Locale('tr'),
    'ar': Locale('ar'),
  };

  static const Map<String, LangCode> languageNameAndLanguageCode = {
    'English': LangCode.en,
    'Turkish': LangCode.tr,
    'Arabic': LangCode.ar,
  };
}
