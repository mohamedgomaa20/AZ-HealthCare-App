import '../../../../data/enums/enums.dart';

class AppSettingsState {
  final AppThemeMode themeMode;
  final AppLanguage language;

  const AppSettingsState({
    required this.themeMode,
    required this.language,
  });

  AppSettingsState copyWith({
    AppThemeMode? themeMode,
    AppLanguage? language,
  }) {
    return AppSettingsState(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }
}
