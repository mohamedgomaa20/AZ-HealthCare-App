import 'package:flutter/material.dart';

enum AppThemeMode { light, dark, system }

class CustomThemeBottomSheet extends StatelessWidget {
  final AppThemeMode selectedTheme;
  final ValueChanged<AppThemeMode> onThemeChanged;

  const CustomThemeBottomSheet({
    super.key,
    required this.selectedTheme,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Text(
            'Choose Theme',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          _ThemeOption(
            label: 'Light Theme',
            value: AppThemeMode.light,
            selected: selectedTheme == AppThemeMode.light,
            onTap: () => onThemeChanged(AppThemeMode.light),
          ),
          _ThemeOption(
            label: 'Dark Theme',
            value: AppThemeMode.dark,
            selected: selectedTheme == AppThemeMode.dark,
            onTap: () => onThemeChanged(AppThemeMode.dark),
          ),
          _ThemeOption(
            label: 'System Default',
            value: AppThemeMode.system,
            selected: selectedTheme == AppThemeMode.system,
            onTap: () => onThemeChanged(AppThemeMode.system),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String label;
  final AppThemeMode value;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: selected ? Colors.white : Colors.white54,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.white70,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
