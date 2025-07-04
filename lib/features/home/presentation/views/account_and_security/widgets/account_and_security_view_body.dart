import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/widgets/custom_loading_dialog.dart';
import 'package:az_health_care/features/get_start/presentation/views/get_start_view.dart';
import 'package:az_health_care/features/settings/presentation/views/change_password/change_password_view.dart';
import 'package:flutter/material.dart';
import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';

import '../../../../../../core/services/show_toast.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/build_switch_item.dart';
import '../../../../../../core/widgets/custom_confirmation_dialog.dart';
import '../../data_and_analytics/widgets/settings_tile.dart';
import '../../profile/widgets/build_menu_item.dart';

class AccountAndSecurityViewBody extends StatefulWidget {
  const AccountAndSecurityViewBody({super.key});

  @override
  State<AccountAndSecurityViewBody> createState() =>
      _AccountAndSecurityViewBodyState();
}

class _AccountAndSecurityViewBodyState
    extends State<AccountAndSecurityViewBody> {
  bool biometricID = true;
  bool faceID = true;
  bool smsAuth = false;
  bool googleAuth = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: 'Account & Security'),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              // padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.blueGrayBackground2,
                borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
              ),
              child: Column(
                children: [
                  // Switches
                  BuildSwitchItem(
                    title: 'Biometric ID',
                    value: biometricID,
                    onChanged: (v) => setState(() => biometricID = v),
                  ),
                  BuildSwitchItem(
                    title: 'Face ID',
                    value: faceID,
                    onChanged: (v) => setState(() => faceID = v),
                  ),
                  BuildSwitchItem(
                    title: 'SMS Authenticator',
                    value: smsAuth,
                    onChanged: (v) => setState(() => smsAuth = v),
                  ),
                  BuildSwitchItem(
                    title: 'Google Authenticator',
                    value: googleAuth,
                    onChanged: (v) => setState(() => googleAuth = v),
                  ),

                  BuildMenuItem(
                    title: 'Change Password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordView(),
                        ),
                      );
                    },
                  ),
                  SettingsTile(
                    title: 'Device Management',
                    subtitle:
                        'Manage your account on the various devices you own.',
                    onTap: () {},
                  ),
                  const SizedBox(height: 8),
                  SettingsTile(
                    title: 'Deactivate Account',
                    subtitle:
                        "Temporarily deactivate your account. Easily reactivate when you're ready.",
                    onTap: () {},
                  ),
                  const SizedBox(height: 8),

                  SettingsTile(
                    isDanger: true,
                    title: 'Delete Account',
                    subtitle:
                        'Permanently remove your account and data. Proceed with caution.',
                    onTap: () {
                      showCustomConfirmationDialog(
                        content: "",
                        context: context,
                        title: 'Delete Account',
                        contentWidget: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: AppColors.errorColor, // أو Colors.red
                                  size: 30,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    'This action is irreversible!',
                                    style: TextStyle(
                                      color: AppColors.errorColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Are you sure you want to delete your account? This will permanently remove all your data and cannot be undone.',
                              style: TextStyle(color: AppColors.white70Color),
                            ),
                          ],
                        ),
                        confirmText: 'Delete',
                        onConfirm: () {
                          ///TODO : delete account
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (_) => CustomLoadingDialog(
                                  message: 'Deleting Account...',
                                  onComplete: () async {
                                    ToastHelper.showToast2(
                                      context: context,
                                      msg: 'Account deleted successfully',
                                      state: ToastStates.SUCCESS,
                                    );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const GetStartView(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
