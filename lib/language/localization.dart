import 'package:get/get.dart';
import '../shared/constants/settings_constants.dart';
import 'arabic.dart';
import 'english.dart';

class LocalizationApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        SettingsConstants.ara: ar,
        SettingsConstants.ene: en,
      };
}
