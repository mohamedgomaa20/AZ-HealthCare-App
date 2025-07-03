import 'package:az_health_care/core/services/show_toast.dart';
import 'package:az_health_care/features/home/presentation/views/preferences/widget/preference_section.dart';
import 'package:az_health_care/features/home/presentation/views/preferences/widget/reset_all_progress_section.dart';
import 'package:az_health_care/features/home/presentation/views/preferences/widget/reset_time_section.dart';
import 'package:az_health_care/features/home/presentation/views/preferences/widget/time_format_section.dart';
import 'package:az_health_care/features/home/presentation/views/preferences/widget/weight_section.dart';
import 'package:flutter/material.dart';

import '../../../../../upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'blood_sugar_section.dart';
import 'clear_cache_section.dart';
import 'first_day_section.dart';
import 'height_section.dart';

class PreferencesViewBody extends StatefulWidget {
  const PreferencesViewBody({super.key});

  @override
  State<PreferencesViewBody> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesViewBody> {
  String weightUnit = 'kg';
  String heightUnit = 'cm';
  String bloodSugarUnit = 'mg/dL';
  String firstDayOfWeek = 'Monday';
  String timeFormat = 'System Default';
  String dayResetTime = '00:00 AM';
  String cacheSize = '45.8 MB';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: 'Preferences'),
          const SizedBox(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  PreferenceSection(
                    children: [
                      WeightSection(
                        selectedUnit: weightUnit,
                        onChanged: (v) => setState(() => weightUnit = v),
                      ),
                      HeightSection(
                        selectedUnit: heightUnit,
                        onChanged: (v) => setState(() => heightUnit = v),
                      ),
                      BloodSugarSection(
                        selectedUnit: bloodSugarUnit,
                        onChanged: (v) => setState(() => bloodSugarUnit = v),
                      ),
                    ],
                  ),

                  PreferenceSection(
                    children: [
                      FirstDaySection(
                        selectedDay: firstDayOfWeek,
                        onChanged: (v) => setState(() => firstDayOfWeek = v),
                      ),
                      TimeFormatSection(
                        selectedFormat: timeFormat,
                        onChanged: (v) => setState(() => timeFormat = v),
                      ),
                      ResetTimeSection(
                        currentTime: dayResetTime,
                        onChanged: (v) => setState(() => dayResetTime = v),
                      ),
                    ],
                  ),

                  PreferenceSection(
                    children: [
                      ResetAllProgressSection(
                        onReset: () {
                          ToastHelper.showToast2(
                            context: context,
                            msg: 'Progress reset successfully',
                            state: ToastStates.SUCCESS,
                          );
                        },
                      ),

                      ClearCacheSection(
                        cacheSize: cacheSize,
                        onClear: () {
                          setState(() => cacheSize = '0 MB');
                          ToastHelper.showToast2(
                            context: context,
                            msg: 'Cache cleared successfully',
                            state: ToastStates.SUCCESS,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
