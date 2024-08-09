import 'dart:convert';

import 'package:change_language/utils/appLanguage.dart';
import 'package:change_language/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;

  late Map<String, String> _localizedValues;

  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  Future loadJson() async {
    final String languageJsonName = locale.countryCode == null
        ? locale.languageCode
        : "${locale.languageCode}-${locale.countryCode}";
    final String jsonStringValues =
        await rootBundle.loadString('assets/languages/$languageJsonName.json');
    final Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? getTranslatedValues(String? key) {
    return _localizedValues[key!];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    //
    return appLanguages
        .map(
          (appLanguage) =>
              Utils.getLocaleFromLanguageCode(appLanguage.languageCode),
        )
        .toList()
        .contains(locale);
  }

  //load languageCode.json files
  @override
  Future<AppLocalization> load(Locale locale) async {
    final AppLocalization localization = AppLocalization(locale);
    await localization.loadJson();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
