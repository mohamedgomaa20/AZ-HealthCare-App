import 'package:az_health_care/features/home/data/enums/enums.dart';

class DisplayHelpers {
  static String getLanguageLabel(AppLanguage language) {
    switch (language) {
      case AppLanguage.ar:
        return 'العربية';
      case AppLanguage.en:
        return 'English';
      case AppLanguage.system:
        return 'System Default';
    }
  }

  static String getThemeLabel(AppThemeMode themeMode) {
    switch (themeMode) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System Default';
    }
  }
}
