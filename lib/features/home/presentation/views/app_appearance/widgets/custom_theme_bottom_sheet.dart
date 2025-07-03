import 'package:az_health_care/features/home/presentation/views/app_appearance/widgets/theme_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../data/enums/enums.dart';
import '../app_settings_cubit/app_settings_cubit.dart';

class CustomThemeBottomSheet extends StatefulWidget {
  const CustomThemeBottomSheet({super.key});

  @override
  State<CustomThemeBottomSheet> createState() => _CustomThemeBottomSheetState();
}

class _CustomThemeBottomSheetState extends State<CustomThemeBottomSheet> {
  late AppThemeMode _tempSelectedTheme;

  @override
  void initState() {
    super.initState();
    _tempSelectedTheme = context.read<AppSettingsCubit>().state.themeMode;
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
            'Choose Theme',
            style: AppTextStyles.bold22.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white10, thickness: 1),
          ThemeOption(
            label: 'Light Theme',
            value: AppThemeMode.light,
            selected: _tempSelectedTheme == AppThemeMode.light,
            onTap: () {
              setState(() {
                _tempSelectedTheme = AppThemeMode.light;
              });
            },
          ),
          ThemeOption(
            label: 'Dark Theme',
            value: AppThemeMode.dark,
            selected: _tempSelectedTheme == AppThemeMode.dark,
            onTap: () {
              setState(() {
                _tempSelectedTheme = AppThemeMode.dark;
              });
            },
          ),
          ThemeOption(
            label: 'System Default',
            value: AppThemeMode.system,
            selected: _tempSelectedTheme == AppThemeMode.system,
            onTap: () {
              setState(() {
                _tempSelectedTheme = AppThemeMode.system;
              });
            },
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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: "Ok",
                  onPressed: () {
                    context.read<AppSettingsCubit>().changeTheme(
                      _tempSelectedTheme,
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

//دون الازرار في الشيتب
// class CustomThemeBottomSheet extends StatelessWidget {
//   final AppThemeMode selectedTheme;
//   final ValueChanged<AppThemeMode> onThemeChanged;
//
//   const CustomThemeBottomSheet({
//     super.key,
//     required this.selectedTheme,
//     required this.onThemeChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//       decoration: const BoxDecoration(
//         color: AppColors.backgroundColor,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//         border: Border(
//           top: BorderSide(color: AppColors.white10Color, width: 1),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 36,
//             height: 4,
//             margin: const EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white24,
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//           Text(
//             'Choose Theme',
//             style: AppTextStyles.bold22.copyWith(color: AppColors.primaryColor),
//           ),
//           const SizedBox(height: 16),
//           const Divider(color: Colors.white10, thickness: 1),
//
//           _ThemeOption(
//             label: 'Light Theme',
//             value: AppThemeMode.light,
//             selected: selectedTheme == AppThemeMode.light,
//             onTap: () => onThemeChanged(AppThemeMode.light),
//           ),
//           _ThemeOption(
//             label: 'Dark Theme',
//             value: AppThemeMode.dark,
//             selected: selectedTheme == AppThemeMode.dark,
//             onTap: () => onThemeChanged(AppThemeMode.dark),
//           ),
//           _ThemeOption(
//             label: 'System Default',
//             value: AppThemeMode.system,
//             selected: selectedTheme == AppThemeMode.system,
//             onTap: () => onThemeChanged(AppThemeMode.system),
//           ),
//           const Divider(color: Colors.white10, thickness: 1),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: CustomButton(
//                   text: "Cancel",
//                   backgroundColor: AppColors.darkGray,
//                   onPressed: () {},
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(child: CustomButton(text: "Ok", onPressed: () {})),
//             ],
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }
