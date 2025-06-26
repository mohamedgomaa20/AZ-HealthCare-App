import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/switch_auth_text.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/terms_and_conditions_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/or_continue_with.dart';
import '../../../../../get_start/presentation/views/widgets/google_button.dart';
import '../../login/login_view.dart';
import '../../login/widgets/remember_me_widget.dart';
import '../../welcome_to_a2z_care/welcome_to_a2z_care_view.dart';
import 'agree_with_action_text.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  bool agreedToTerms = false;
  bool agreed = false;
  String termsText = '';

  Future<void> _showTermsDialog() async {
    // Load the string (you can also use DefaultAssetBundle or rootBundle)
    if (termsText.isEmpty) {
      termsText = await rootBundle.loadString(
        'assets/texts/terms_conditions.txt',
      );
    }

    showDialog(
      context: context,
      builder:
          (_) => TermsAndConditionsDialog(
            title: "Terms & Conditions",
            body: termsText,
            onCancel: () => Navigator.pop(context),
            onConfirm: () {
              setState(() => agreedToTerms = true);
              Navigator.pop(context);
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder:
          (context, innerBoxIsScrolled) => [
            const CustomSliverAppBar(title: "Join A2Z Care Today \uD83E\uDE7A"),
          ],
      body: Builder(
        builder:
            (context) => CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "Create your account and start monitoring your health",
                          style: AppTextStyles.medium14,
                        ),
                        const SizedBox(height: 45),
                        Text("UserName", style: AppTextStyles.semiBold16),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hintText: "UserName",
                          controller: TextEditingController(),
                          keyboardType: TextInputType.name,
                          prefixIconData: CupertinoIcons.profile_circled,
                        ),
                        const SizedBox(height: 20),
                        Text("Email", style: AppTextStyles.semiBold16),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hintText: "Email",
                          controller: TextEditingController(),
                          keyboardType: TextInputType.emailAddress,
                          prefixIconData: Icons.email,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Create Password",
                          style: AppTextStyles.semiBold16,
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hintText: "Create Password",
                          controller: TextEditingController(),
                          keyboardType: TextInputType.visiblePassword,
                          prefixIconData: Icons.lock,
                          suffixIconData: CupertinoIcons.eye_fill,
                          isPassword: true,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Confirm Password",
                          style: AppTextStyles.semiBold16,
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hintText: "Confirm Password",
                          controller: TextEditingController(),
                          keyboardType: TextInputType.visiblePassword,
                          prefixIconData: Icons.lock,
                          suffixIconData: CupertinoIcons.eye_fill,
                          isPassword: true,
                        ),
                        const SizedBox(height: 10),
                        AgreeWithActionText(
                          value: agreedToTerms,
                          onChanged: (val) {
                            if (val == true) {
                              _showTermsDialog();
                            } else {
                              setState(() => agreedToTerms = false);
                            }
                          },
                          normalText: "I agree to A2ZCare ",
                          actionText: "Terms & Conditions",
                          onTap: _showTermsDialog,
                        ),

                        const SizedBox(height: 16),
                        SwitchAuthText(
                          normalText: "Already have an account? ",
                          actionText: "Sign in",
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              LoginView.routeName,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const OrContinueWith(),
                        const SizedBox(height: 16),
                        const GoogleButton(),
                        const SizedBox(height: 32),
                        CustomButton(
                          text: "Sign Up",
                          onPressed:
                              agreedToTerms
                                  ? () {
                                    Navigator.pushNamed(
                                      context,
                                      WelcomeToA2zCareView.routeName,
                                    );
                                  }
                                  : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
