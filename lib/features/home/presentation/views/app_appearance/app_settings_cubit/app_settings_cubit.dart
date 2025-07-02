import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/services/cache_helper.dart';
import '../../../../data/enums/enums.dart';
import 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  static const _themeKey = 'app_theme';
  static const _languageKey = 'app_language';

  AppSettingsCubit()
    : super(
        const AppSettingsState(
          themeMode: AppThemeMode.system,
          language: AppLanguage.en,
        ),
      ) {
    _loadSettings();
  }

  void _loadSettings() {
    final themeStr = CacheHelper.getData(key: _themeKey) as String?;
    final langStr = CacheHelper.getData(key: _languageKey) as String?;

    final theme = AppThemeMode.values.firstWhere(
      (e) => e.name == themeStr,
      orElse: () => AppThemeMode.system,
    );

    final lang = AppLanguage.values.firstWhere(
      (e) => e.name == langStr,
      orElse: () => AppLanguage.en,
    );

    emit(state.copyWith(themeMode: theme, language: lang));
  }

  void changeTheme(AppThemeMode mode) {
    CacheHelper.saveData(key: _themeKey, value: mode.name);
    emit(state.copyWith(themeMode: mode));
  }

  void changeLanguage(AppLanguage lang) {
    CacheHelper.saveData(key: _languageKey, value: lang.name);
    emit(state.copyWith(language: lang));
  }
}
