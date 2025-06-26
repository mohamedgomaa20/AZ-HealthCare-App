import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:az_health_care/core/widgets/custom_text_form_field.dart';
import 'package:az_health_care/features/Auth/presentation/views/login/widgets/remember_me_widget.dart';
import 'package:az_health_care/core/widgets/or_continue_with.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_text_styles.dart';

import '../../../../../get_start/presentation/views/widgets/google_button.dart';
import '../../../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../sign_up/sign_up_view.dart';
import '../../sign_up/widgets/switch_auth_text.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder:
          (context, innerBoxIsScrolled) => [
            const CustomSliverAppBar(title: 'Welcome Back! 👋'),
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
                          "Log in to continue your health journey",
                          style: AppTextStyles.medium14,
                        ),
                        const SizedBox(height: 45),
                        Text("Email", style: AppTextStyles.semiBold16),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hintText: "Email",
                          controller: TextEditingController(),
                          keyboardType: TextInputType.emailAddress,
                          prefixIconData: Icons.email,
                        ),
                        const SizedBox(height: 20),
                        Text("Password", style: AppTextStyles.semiBold16),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hintText: "Password",
                          controller: TextEditingController(),
                          keyboardType: TextInputType.visiblePassword,
                          prefixIconData: Icons.lock,
                          suffixIconData: CupertinoIcons.eye_fill,
                          isPassword: true,
                        ),
                        const SizedBox(height: 10),
                        RememberMeWidget(),
                        const SizedBox(height: 16),
                        SwitchAuthText(
                          normalText: "Don't have an account? ",
                          actionText: "Sign Up",
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              SignUpView.routeName,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const OrContinueWith(),
                        const SizedBox(height: 16),
                        const GoogleButton(),
                        const SizedBox(height: 32),
                        CustomButton(text: "Log In", onPressed: () {}),
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
