import 'package:change_language/utils/appLanguage.dart';
import 'package:change_language/utils/hiveBoxKey.dart';
import 'package:hive/hive.dart';

class SettingsRepository {
  Future<void> setCurrentLanguageCode(String value) async {
    Hive.box(settingsBoxKey).put(currentLanguageCodeKey, value);
  }

  String getCurrentLanguageCode() {
    return Hive.box(settingsBoxKey).get(currentLanguageCodeKey) ??
        defaultLanguageCode;
  }
}
