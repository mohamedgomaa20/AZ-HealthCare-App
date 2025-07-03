import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../data/enums/enums.dart';
import '../app_settings_cubit/app_settings_cubit.dart';
import 'language_option.dart';

class CustomLanguageBottomSheet extends StatefulWidget {
  const CustomLanguageBottomSheet({super.key});

  @override
  State<CustomLanguageBottomSheet> createState() =>
      _CustomLanguageBottomSheetState();
}

class _CustomLanguageBottomSheetState extends State<CustomLanguageBottomSheet> {
  late AppLanguage _tempSelectedLanguage;

  @override
  void initState() {
    super.initState();
    _tempSelectedLanguage = context.read<AppSettingsCubit>().state.language;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        border: Border(
          top: BorderSide(color: AppColors.white10Color, width: 1),
        ),
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
          Text(
            'Choose Language',
            style: AppTextStyles.bold22.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white10, thickness: 1),

          LanguageOption(
            label: 'العربية',
            value: AppLanguage.ar,
            selected: _tempSelectedLanguage == AppLanguage.ar,
            onTap: () => setState(() => _tempSelectedLanguage = AppLanguage.ar),
          ),
          LanguageOption(
            label: 'English',
            value: AppLanguage.en,
            selected: _tempSelectedLanguage == AppLanguage.en,
            onTap: () => setState(() => _tempSelectedLanguage = AppLanguage.en),
          ),
          LanguageOption(
            label: 'System Default',
            value: AppLanguage.system,
            selected: _tempSelectedLanguage == AppLanguage.system,
            onTap:
                () =>
                    setState(() => _tempSelectedLanguage = AppLanguage.system),
          ),

          const Divider(color: Colors.white10, thickness: 1),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CustomButton(
                  text: "Cancel",
                  backgroundColor: AppColors.darkGray,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: "Ok",
                  onPressed: () {
                    context.read<AppSettingsCubit>().changeLanguage(
                      _tempSelectedLanguage,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
